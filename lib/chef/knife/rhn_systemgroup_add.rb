#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemgroupAdd < BaseRhnCommand

    banner "knife rhn systemgroup add GROUP SYSTEM (options)"
    category "rhn"

    get_common_options

    def run
      
      group = name_args.first

      if group.nil?
        ui.fatal "You need a systemgroup name!"
        show_usage
        exit 1
      end

      system = name_args[1]

      if system.nil?
        ui.fatal "You need a system name!"
        show_usage
        exit 1
      end

      set_rhn_connection_options

      satellite_system = get_satellite_system(system)
      RhnSatellite::Systemgroup.add_systems(group,[satellite_system['id']])
      ui.info "Added #{system} (ID: #{satellite_system['id']}) to RHN systemgroup: #{group}"
    end

  end
end