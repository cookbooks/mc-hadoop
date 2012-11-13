#
# Cookbook Name:: hadoop
# Recipe:: workernode
#

include_recipe "hadoop::default"

node['hadoop']['workernode']['packages'].each do |hadoop_pkg|
  package hadoop_pkg do
    action :install
  end
end

%w{hadoop-env.sh}.each do |file|
  template "#{node[:hadoop][:confdir]}/#{file}" do
    source "debian.#{file}.erb"
    owner "root"
    group "hadoop"
    mode "0644"
  end
end

%w{core-site.xml hdfs-site.xml}.each do |file|
  template "#{node[:hadoop][:confdir]}/#{file}" do
    source "debian.slave.#{file}.erb"
    owner "root"
    group "hadoop"
    mode "0644"
  end
end

bash "create datanode dir" do
  user "root"
  code <<-EOH
    mkdir -p #{node[:hadoop][:datanodedir]}
    chown -R hdfs:hdfs #{node[:hadoop][:datanodedir]}
    chmod 700 #{node[:hadoop][:datanodedir]}
  EOH
end

bash "create mapred dir" do
  user "root"
  code <<-EOH
    mkdir -p #{node[:hadoop][:mapreddir]}
    chown -R mapred:hadoop #{node[:hadoop][:mapreddir]}
    chmod -R 751 #{node[:hadoop][:mapreddir]}
  EOH
end
