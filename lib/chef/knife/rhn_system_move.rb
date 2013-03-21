#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

require 'chef/knife/rhn_base'

class Chef
  class Knife
    class RhnSystemMove < Knife

      include Knife::RhnBase

      banner "knife rhn system move SYSTEM GROUP (options)"
      category "rhn"

      def run
        $stdout.sync = true
        
        system = name_args.first

        if system.nil?
          ui.fatal "You need a system name!"
          show_usage
          exit 1
        end

        group = name_args[1]

        if group.nil?
          ui.fatal "You need a systemgroup name!"
          show_usage
          exit 1
        end

        set_rhn_connection_options

        satellite_system = get_satellite_system(system)
        system_groups = RhnSatellite::Systemgroup.all
        system_groups.sort! {|a,b| a['name'] <=> b['name']}
        system_groups.each do |system_group|
          if RhnSatellite::Systemgroup.systems(system_group['name']).find{|s| s['id'] == satellite_system['id']}
            RhnSatellite::Systemgroup.remove_systems(system_group['name'],[satellite_system['id']])
            ui.info "Removed system #{system} from RHN systemgroup: #{system_group['name']}"
          end
        end
        RhnSatellite::Systemgroup.add_systems(group,[satellite_system['id']])
        ui.info "Added system #{system} to RHN systemgroup: #{group}"
      end

    end
  end
end
