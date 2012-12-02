#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemSystemgroups < BaseRhnCommand

    banner "knife rhn system systemgroups SYSTEM (options)"
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
      system_groups = RhnSatellite::Systemgroup.all
      system_groups.sort! {|a,b| a['name'] <=> b['name']}
      system_groups.each do |system_group|
        ui.info "#{system_group['name']}" if RhnSatellite::Systemgroup.systems(system_group['name']).find{|s| s['id'] == satellite_system['id']}
      end
    end

  end
end
