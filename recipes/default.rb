#
# Cookbook Name:: datadisk
# Recipe:: default
#
# Copyright 2014, Milo de Vries
#

# target partition enumeration

datadir = node['datadisk']['datapart']

disks_with_fs = node[:filesystem].to_s.scan(/[sx]v?d[a-z]/)
disks = node[:block_device].to_s.scan(/[sx]v?d[a-z]/)
disk_without_fs = disks - disks_with_fs

datadisk_storage datadir do
  disk disk_without_fs.first
  fstype "ext3"
  action :create
end
