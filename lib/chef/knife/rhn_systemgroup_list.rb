#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemgroupList < BaseRhnCommand

    banner "knife rhn ystemgroup list (options)"
    category "rhn"

    get_common_options

    def run

      set_rhn_connection_options

      system_groups = RhnSatellite::Systemgroup.all
      system_groups.sort! {|a,b| a['name'] <=> b['name']}
      system_groups.each do |system_group|
        ui.info "#{system_group['name']}"
      end
    end

  end
end
