#
# Cookbook Name:: hadoop
# Recipe:: namenode
#

include_recipe "hadoop::default"

node['hadoop']['namenode']['packages'].each do |hadoop_pkg|
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

template "#{node[:hadoop][:confdir]}/hdfs-site.xml" do
    source "debian.master.hdfs-site.xml.erb"
    owner "root"
    group "hadoop"
    mode "0644"
  end

bash "create namenode dir" do
  user "root"
  code <<-EOH
    mkdir -p #{node[:hadoop][:namenodedir]}
    chown -R hdfs:hdfs #{node[:hadoop][:namenodedir]}
    chmod 700 #{node[:hadoop][:namenodedir]}
  EOH
end

=begin
--- As hdfs user:
hdfs namenode -format
create hdfs/mapred tmp directories
hadoop fs -mkdir /var
hadoop fs -mkdir /var/lib
hadoop fs -mkdir /var/lib/hadoop-hdfs
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred/mapred
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred

--- create mapred.system.dir (mapred-site.xml)
hadoop fs -mkdir /tmp/mapred/system
hadoop fs -chown mapred:hadoop /tmp/mapred/system

--- create home directory for mapreduce users
hadoop fs -mkdir /user/<user>
hadoop fs -chown <user> /user/<user>
=end
