#
# Cookbook Name:: hadoop
# Attributes:: hadoop
#

default['hadoop']['namenode']['packages']          = %w{hadoop-hdfs-namenode}
default['hadoop']['jobtracker']['packages']        = %w{hadoop-0.20-mapreduce-jobtracker}
default['hadoop']['workernode']['packages']        = %w{hadoop-0.20-mapreduce-tasktracker hadoop-hdfs-datanode}

# configure using alternatives directory?
set[:hadoop][:confdir]     = "/etc/hadoop/conf"
set[:hadoop][:namenodedir] = "/data/hdfs/local"
set[:hadoop][:mapreddir]   = "/data/mapred/local"
set[:hadoop][:datanodedir] = "/data/hdfs/local"

