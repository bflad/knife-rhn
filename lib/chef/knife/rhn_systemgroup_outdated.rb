#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  class RhnSystemgroupOutdated < BaseRhnCommand

    banner "knife rhn systemgroup outdated GROUP (options)"
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

      systems = RhnSatellite::Systemgroup.systems(group)
      systems.sort! {|a,b| a['profile_name'] <=> b['profile_name']}
      systems.each do |system|
        ui.info "#{system['id']},#{system['profile_name']}" unless RhnSatellite::System.uptodate?(system['id'])
      end
    end

  end
end
