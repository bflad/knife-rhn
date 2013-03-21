#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

require 'chef/knife/rhn_base'

class Chef
  class Knife
    class RhnSystemgroupList < Knife

      include Knife::RhnBase

      banner "knife rhn ystemgroup list (options)"
      category "rhn"

      def run
        $stdout.sync = true

        set_rhn_connection_options

        system_groups = RhnSatellite::Systemgroup.all
        system_groups.sort! {|a,b| a['name'] <=> b['name']}
        system_groups.each do |system_group|
          ui.info "#{system_group['name']}"
        end
      end

    end
  end
end
