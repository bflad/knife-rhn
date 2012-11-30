#
# Author:: Brian Flad (<bflad417@gmail.com>)
# License:: Apache License, Version 2.0
#

module RHNKnifePlugin

  require 'chef/knife'
  require 'rhn_satellite'
  
  class BaseRHNCommand < Chef::Knife

    #deps do
    #  require 'highline/import'
    #end

    def self.get_common_options
      unless defined? $default
        $default = Hash.new
      end

      option :rhn_hostname,
        :short => "-h HOSTNAME",
        :long => "--rhn-hostname HOSTNAME",
        :description => "The hostname for RHN"

      option :rhn_password,
        :short => "-p PASSWORD",
        :long => "--rhn-password PASSWORD",
        :description => "The password for RHN"

      option :rhn_username,
        :short => "-u USERNAME",
        :long => "--rhn-username USERNAME",
        :description => "The username for RHN"
    end

    def get_config(key)
      key = key.to_sym
      rval = config[key] || Chef::Config[:knife][key] || $default[key]
      Chef::Log.debug("value for config item #{key}: #{rval}")
      rval
    end

    # RhnSatellite::Connection::Handler.default_hostname = get_config(:rhn_hostname)
    # RhnSatellite::Connection::Handler.default_password = get_config(:rhn_password)
    # RhnSatellite::Connection::Handler.default_username = get_config(:rhn_username)

  end
end
