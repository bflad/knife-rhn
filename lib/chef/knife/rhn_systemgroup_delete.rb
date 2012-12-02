#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemgroupDelete < BaseRhnCommand

    banner "knife rhn systemgroup delete GROUP (options)"
    category "rhn"

    get_common_options

    def run
      
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
