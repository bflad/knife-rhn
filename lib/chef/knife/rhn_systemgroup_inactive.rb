#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'

  # Until merged: https://github.com/duritong/ruby-rhn_satellite/pull/7
  module Systemgroup
    def inactive_systems(group_name,days=nil)
      if days
        base.default_call('systemgroup.listInactiveSystemsInGroup',group_name,days.to_i)
      else
        base.default_call('systemgroup.listInactiveSystemsInGroup',group_name)
      end
    end
  end

  class RhnSystemgroupInactive < BaseRhnCommand

    banner "knife rhn systemgroup inactive GROUP (options)"
    category "rhn"

    get_common_options

    option :days,
      :long => "--days DAYS",
      :description => "The number of inactive days"

    def run
      
      group = name_args.first

      if group.nil?
        ui.fatal "You need a systemgroup name!"
        show_usage
        exit 1
      end

      set_rhn_connection_options

      RhnSatellite::Systemgroup.extend(Systemgroup)
      system_ids = RhnSatellite::Systemgroup.inactive_systems(group,get_config(:days))
      systems = []
      system_ids.each do |system_id|
        systems << RhnSatellite::System.details(system_id)
      end
      systems.sort! {|a,b| a['profile_name'] <=> b['profile_name']}
      systems.each do |system|
        ui.info "#{system['id']},#{system['profile_name']}"
      end
    end

  end
end
