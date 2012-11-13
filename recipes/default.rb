#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

execute "apt-get update" do
  command "apt-get update"
  action :nothing
end

template "/etc/apt/sources.list.d/cloudera.list" do
  owner "root"
  mode "0644"
  source "cloudera.list.erb"
end

execute "wget -q -O - http://archive.cloudera.com/cdh4/debian/squeeze/amd64/cdh/archive.key | apt-key add -" do
  user "root"
  notifies :run, "execute[apt-get update]", :immediately
end

# handle hostname
# handle server names in /etc/hosts (not needed with DNS)
# configure hdfs
