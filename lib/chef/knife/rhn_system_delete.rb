#
# Author:: Brian Flad (<bflad@wharton.upenn.edu>)
# License:: Apache License, Version 2.0
#

module RHNKnifePlugin

  require 'chef/knife'

  class RHNSystemDelete < BaseRHNCommand

    banner "knife rhn system delete SYSTEM (options)"

    get_common_options

    def run
      
      system = name_args.first

      if system.nil?
        ui.fatal "You need a system name!"
        show_usage
        exit 1
      end

      
    end

  end
end
