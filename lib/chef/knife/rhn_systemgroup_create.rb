#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemgroupCreate < BaseRhnCommand

    banner "knife rhn systemgroup create GROUP DESCRIPTION (options)"
    category "rhn"

    get_common_options

    def run
      
      group = name_args.first

      if group.nil?
        ui.fatal "You need a systemgroup name!"
        show_usage
        exit 1
      end

      description = name_args[1]
      description ||= group

      set_rhn_connection_options

      RhnSatellite::Systemgroup.create(group,description)
      ui.info "Created RHN Systemgroup: #{group}"
    end

  end
end
