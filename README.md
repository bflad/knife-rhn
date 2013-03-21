# Knife RHN

A knife plugin for managing Red Hat Network.

## Installation

Uses [rhn_satellite rubygem](https://github.com/duritong/ruby-rhn_satellite) for the backend.

* `gem install knife-rhn` (if using omnibus install, `/opt/chef/embedded/bin/gem install knife-rhn`)
* or... copy `lib/chef/knife/*` files to `~/.chef/plugins/knife`
* or... copy `lib/chef/knife/*` files to `path/to/cheforg/.chef/plugins/knife`

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

Example output:

    ID: 1000023160
    Profile Name: bflad-test2
    Hostname: bflad-test2
    Release: 6Server
    Auto Update: Disabled
    Locked: Disabled
    RHN URL: https://example.com/rhn/systems/details/Overview.do?sid=1000023160
    Description:
    Initial Registration Parameters:
    OS: redhat-release-server
    Release: 6Server
    CPU Arch: x86_64
    Subscribed Channels:
    Red Hat Enterprise Linux Server (v. 6 for 64-bit x86_64)
     |_ Shibboleth RHEL 6 x86_64
     |_ RHEL Server Optional (v. 6 64-bit x86_64)
     |_ RHEL Server Supplementary (v. 6 64-bit x86_64)
     |_ EPEL 6 Server x86_64
    Critical Errata: 1
    Non-Critical Errata: 2
    Upgradable Packages: 4

### `knife rhn system move SYSTEM GROUP`

* Removes system SYSTEM from all current systemgroups.
* Adds system SYSTEM to systemgroup GROUP.

### `knife rhn system systemgroups SYSTEM`

Displays systemgroups for SYSTEM.

Example output:

    Core Systems
    Research Computing

### `knife rhn systemgroup active GROUP`

Lists active systems (systems that have checked into RHN in the last 24 hours) in systemgroup GROUP.

Example output:

    1000010619,server1.example.com
    1000018560,server2.example.com
    1000010446,server3.example.com

### `knife rhn systemgroup add GROUP SYSTEM`

Adds system SYSTEM to systemgroup GROUP.

### `knife rhn systemgroup create GROUP DESCRIPTION`

Creates systemgroup GROUP with DESCRIPTION.

### `knife rhn systemgroup delete GROUP`

Deletes systemgroup GROUP.

### `knife rhn systemgroup inactive GROUP`

Lists inactive systems (systems that have not checked into RHN in 24 hours) in systemgroup GROUP.

* `--days DAYS` - optionally set number of inactive days

Example output:

    1000010004,server4.example.com
    1000017215,server5.example.com

### `knife rhn systemgroup list`

Lists all systemgroups.

Example output:

    Accounting
    Core Systems
    Research Computing

### `knife rhn systemgroup outdated GROUP`

Lists outdated systems in system group GROUP.

Example output:

    1000018560,server2.example.com
    1000017215,server5.example.com

### `knife rhn systemgroup remove GROUP SYSTEM`

Removes system SYSTEM from systemgroup GROUP.

### `knife rhn systemgroup systems GROUP`

Lists all systems in system group GROUP.

Example output:

    1000010619,server1.example.com
    1000018560,server2.example.com
    1000010446,server3.example.com
    1000010004,server4.example.com
    1000017215,server5.example.com

## Contributing

Please use standard Github issues and pull requests.

## License and Author

Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012-2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
