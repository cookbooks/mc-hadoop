#
# Cookbook Name:: hadoop
# Recipe:: jobtracker
#

include_recipe "hadoop::default"

node['hadoop']['jobtracker']['packages'].each do |hadoop_pkg|
  package hadoop_pkg do
    action :install
  end
end

%w{hadoop-env.sh core-site.xml}.each do |file|
  template "#{node[:hadoop][:confdir]}/#{file}" do
    source "debian.#{file}.erb"
    owner "root"
    group "hadoop"
    mode "0644"
  end
end

template "#{node[:hadoop][:confdir]}/mapred-site.xml" do
  source "debian.master.mapred-site.xml.erb"
  owner "root"
  group "hadoop"
  mode "0644"
end
