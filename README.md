# Knife RHN

A knife plugin for managing RHN.

## Installation

Uses [rhn_satellite rubygem](https://github.com/duritong/ruby-rhn_satellite) for the backend.

* `gem install knife-rhn` (if using omnibus install, `/opt/chef/embedded/bin/gem install knife-rhn`)
* or... copy lib files to `~/.chef/plugins/knife`
* or... copy lib files to `path/to/cheforg/.chef/plugins/knife`

## Usage

### Common parameters

Configuration in knife.rb:
* `knife[:rhn_debug] = true` - Enable debugging for RHN connection
* `knife[:rhn_hostname] = "HOSTNAME"` - RHN hostname
* `knife[:rhn_no_https] = true` - Disable HTTPS for RHN connection
* `knife[:rhn_password] = "PASSWORD"` - RHN password
* `knife[:rhn_username] = "USERNAME"` - RHN username

Otherwise, from the command line:
* `--rhn-debug` - Enable debugging for RHN connection
* `--rhn-hostname HOSTNAME` - RHN hostname
* `--rhn-no-https` - Disable HTTPS for RHN connection
* `--rhn-password PASSWORD` - RHN password
* `--rhn-username USERNAME` - RHN username

### `knife rhn system delete SYSTEM`

Deletes the system profile for SYSTEM.

### `knife rhn system details SYSTEM`

Displays system details for SYSTEM.

### `knife rhn system move SYSTEM GROUP`

* Removes system SYSTEM from all current systemgroups.
* Adds system SYSTEM to systemgroup GROUP.

### `knife rhn system systemgroups SYSTEM`

Displays systemgroups for SYSTEM.

### `knife rhn systemgroup active GROUP`

Lists active systems in system group GROUP.

### `knife rhn systemgroup add GROUP SYSTEM`

Adds system SYSTEM to systemgroup GROUP.

### `knife rhn systemgroup create GROUP DESCRIPTION`

Creates systemgroup GROUP with DESCRIPTION.

### `knife rhn systemgroup delete GROUP`

Deletes systemgroup GROUP.

### `knife rhn systemgroup inactive GROUP`

Lists inactive systems in system group GROUP.

* `--days` - Number of inactive days

### `knife rhn systemgroup list`

Lists all systemgroups.

### `knife rhn systemgroup outdated GROUP`

Lists outdated systems in system group GROUP.

### `knife rhn systemgroup remove GROUP SYSTEM`

Removes system SYSTEM from systemgroup GROUP.

### `knife rhn systemgroup systems GROUP`

Lists all systems in system group GROUP.

## Contributing

Please use standard Github issues and pull requests.

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
