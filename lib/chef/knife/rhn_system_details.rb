#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemDetails < BaseRhnCommand

    banner "knife rhn system details SYSTEM (options)"
    category "rhn"

    get_common_options

    def run
      
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

    end

  end
end
