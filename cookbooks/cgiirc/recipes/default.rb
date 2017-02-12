#
# Cookbook Name:: cgiirc
# Recipe:: default
#
# Copyright 2011, OpenStreetMap Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache::ssl"

blocks = data_bag_item("cgiirc", "blocks")

package "cgiirc"

template "/etc/cgiirc/cgiirc.config" do
  source "cgiirc.config.erb"
  owner "root"
  group "root"
  mode 0o644
end

template "/etc/cgiirc/ipaccess" do
  source "ipaccess.erb"
  owner "root"
  group "root"
  mode 0o644
  variables :blocks => blocks["addresses"]
end

ssl_certificate "irc.openstreetmap.org" do
  domains "irc.openstreetmap.org"
  fallback_certificate "openstreetmap"
  notifies :reload, "service[apache2]"
end

apache_site "irc.openstreetmap.org" do
  template "apache.erb"
end
