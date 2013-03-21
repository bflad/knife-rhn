#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

require 'chef/knife/rhn_base'

class Chef
  class Knife
    class RhnSystemDetails < Knife

      include Knife::RhnBase

      banner "knife rhn system details SYSTEM (options)"
      category "rhn"

      def run
        $stdout.sync = true
        
        system = name_args.first

        if system.nil?
          ui.fatal "You need a system name!"
          show_usage
          exit 1
        end

        set_rhn_connection_options

        satellite_system = get_satellite_system(system)

        details = RhnSatellite::System.details(satellite_system['id'])
        ui.info "#{ui.color "ID", :cyan}: #{details['id']}"
        ui.info "#{ui.color "Profile Name", :cyan}: #{details['profile_name']}"
        ui.info "#{ui.color "Hostname", :cyan}: #{details['hostname']}"
        ui.info "#{ui.color "Release", :cyan}: #{details['release']}"
        ui.info "#{ui.color "Auto Update", :cyan}: #{details['auto_update'] ? "Enabled" : "Disabled"}"
        ui.info "#{ui.color "Locked", :cyan}: #{details['lock_status'] ? "Enabled" : "Disabled"}"
        ui.info "#{ui.color "RHN URL", :cyan}: https://#{get_config(:rhn_hostname)}/rhn/systems/details/Overview.do?sid=#{details['id']}"
        ui.info "#{ui.color "Description", :cyan}:"
        ui.info "#{details['description']}"

        base_channel = RhnSatellite::System.subscribed_base_channel(satellite_system['id'])
        child_channels = RhnSatellite::System.subscribed_child_channels(satellite_system['id'])
        ui.info "#{ui.color "Subscribed Channels", :cyan}:"
        ui.info "#{ui.color base_channel['name'], :bold}"
        child_channels.each do |child_channel|
          ui.info " |_ #{child_channel['name']}"
        end

        relevant_erratas = RhnSatellite::System.relevant_erratas(satellite_system['id'])
        critical_errata = relevant_erratas.select{|e| e["advisory_type"] == "Security Advisory"}.length
        ui.info "#{ui.color "Critical Errata", :cyan}: #{critical_errata}"
        ui.info "#{ui.color "Non-Critical Errata", :cyan}: #{relevant_erratas.length - critical_errata}"

        upgradable_packages = RhnSatellite::System.latest_upgradable_packages(satellite_system['id'])
        ui.info "#{ui.color "Upgradable Packages", :cyan}: #{upgradable_packages.length}"
      end

    end
  end
end
