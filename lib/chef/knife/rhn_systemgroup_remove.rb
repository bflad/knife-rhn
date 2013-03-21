#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

require 'chef/knife/rhn_base'

class Chef
  class Knife
    class RhnSystemgroupRemove < Knife

      include Knife::RhnBase

      banner "knife rhn systemgroup remove GROUP SYSTEM (options)"
      category "rhn"

      def run
        $stdout.sync = true
        
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
        RhnSatellite::Systemgroup.remove_systems(group,[satellite_system['id']])
        ui.info "Removed #{system} (ID: #{satellite_system['id']}) from RHN systemgroup: #{group}"
      end

    end
  end
end
