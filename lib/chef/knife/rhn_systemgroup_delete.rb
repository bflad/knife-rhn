#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

require 'chef/knife/rhn_base'

class Chef
  class Knife
    class RhnSystemgroupDelete < Knife

      include Knife::RhnBase

      banner "knife rhn systemgroup delete GROUP (options)"
      category "rhn"

      def run
        $stdout.sync = true
        
        group = name_args.first

        if group.nil?
          ui.fatal "You need a systemgroup name!"
          show_usage
          exit 1
        end

        set_rhn_connection_options

        RhnSatellite::Systemgroup.delete(group)
        ui.info "Deleted RHN Systemgroup: #{group}"
      end

    end
  end
end
