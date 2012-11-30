# Knife RHN

A knife plugin for managing RHN.

## Installation

Uses `rhn_satellite` rubygem.

* `gem install knife-rhn`
* or... clone repo to ~/.chef/plugins/knife or path/to/cheforg/.chef/plugins/knife

## Usage

This plugin supports basic RHN operations.

### Common parameters

* `--rhn-hostname HOSTNAME` - RHN hostname
* `--rhn-password PASSWORD` - RHN password
* `--rhn-username USERNAME` - RHN username

### `knife rhn system delete SYSTEM`

Deletes the system profile for SYSTEM.

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
