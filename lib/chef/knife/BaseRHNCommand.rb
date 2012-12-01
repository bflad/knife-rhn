#
# Author:: Brian Flad (<bflad417@gmail.com>)
# License:: Apache License, Version 2.0
#

module RhnKnifePlugin

  require 'chef/knife'
  require 'rhn_satellite'
  
  class BaseRhnCommand < Chef::Knife

    #deps do
    #  require 'highline/import'
    #end

    def self.get_common_options
      unless defined? $default
        $default = Hash.new
      end

      option :rhn_debug,
        :long => "--rhn-debug",
        :description => "Enable debugging for RHN connection",
        :boolean => false

      option :rhn_hostname,
        :short => "-h HOSTNAME",
        :long => "--rhn-hostname HOSTNAME",
        :description => "The hostname for RHN"

      option :rhn_no_https,
        :long => "--rhn-no-https",
        :description => "Disable HTTPS for RHN connection",
        :boolean => false

      option :rhn_password,
        :short => "-p PASSWORD",
        :long => "--rhn-password PASSWORD",
        :description => "The password for RHN"

      option :rhn_timeout,
        :long => "--rhn-timeout SECONDS",
        :description => "The timeout in seconds for RHN"
      $default[:rhn_timeout] = 30

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

    def get_satellite_system(system)
      satellite_system = RhnSatellite::System.get(system)

      if satellite_system.nil?
        ui.fatal "Could not find system in RHN!"
        exit 1
      end

      satellite_system
    end

    def set_rhn_connection_options
      RhnSatellite::Connection::Handler.debug_enabled = true if get_config(:rhn_debug)
      RhnSatellite::Connection::Handler.default_hostname = get_config(:rhn_hostname)
      RhnSatellite::Connection::Handler.default_https = false if get_config(:rhn_no_https)
      # See: https://github.com/duritong/ruby-rhn_satellite/issues/3
      RhnSatellite::ActivationKey.https = false if get_config(:rhn_no_https)
      RhnSatellite::Api.https = false if get_config(:rhn_no_https)
      RhnSatellite::Channel.https = false if get_config(:rhn_no_https)
      RhnSatellite::ChannelAccess.https = false if get_config(:rhn_no_https)
      RhnSatellite::ChannelSoftware.https = false if get_config(:rhn_no_https)
      RhnSatellite::Packages.https = false if get_config(:rhn_no_https)
      RhnSatellite::System.https = false if get_config(:rhn_no_https)
      RhnSatellite::Systemgroup.https = false if get_config(:rhn_no_https)
      # End of issue 3 workaround
      RhnSatellite::Connection::Handler.default_timeout = get_config(:rhn_timeout)
      RhnSatellite::Connection::Handler.default_username = get_config(:rhn_username)
      password = get_config(:rhn_password)
      password ||= ask("RHN Password for #{get_config(:rhn_username)}: ") { |q| q.echo = "*" }
      RhnSatellite::Connection::Handler.default_password = password
    end

  end
end
