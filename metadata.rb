maintainer        "Modcloth Inc."
maintainer_email  "bi@modcloth.com"
license           "Apache 2.0"
description       "Installs hadoop from Cloudera chd4 distribution"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.8.1"
depends           "java"

recipe "hadoop::namenode", "Installs hadoop dfs master node process"
recipe "hadoop::jobtracker", "Installs hadoop master job-management process"
recipe "hadoop::workernode", "Installs hadoop tasktracker and datanode for slave servers"
recipe "hadoop::conf_pseudo", "Installs hadoop-conf-pseudo and enables hadoop services"
recipe "hadoop::doc", "Installs hadoop documentation"
recipe "hadoop::hive", "Installs hadoop's hive package"
recipe "hadoop::pig", "Installs hadoop's pig package"

%w{ debian }.each do |os|
  supports os
end
