def whyrun_supported?
  true
end

action :create do
  datadir = new_resource.path

  disks_with_fs = node[:filesystem].to_s.scan(/[sx]v?d[a-z]/)
  disks = node[:block_device].to_s.scan(/[sx]v?d[a-z]/)

  # use disk or fall back to first disk without fs
  disk = new_resource.disk || (disks - disks_with_fs).first
  disk = "/dev/#{disk}" unless disk.nil? || disk.match(/^\/dev\//)

  # target disk enumeration
  partition = "#{disk}1"

  execute "partition the disk" do
    command "echo -e 'n\np\n1\n\n\nw\n' | fdisk #{disk}"
    not_if { ::File.exist?(partition) }
  end

  execute "format the disk" do
    command "mkfs -t ext4 #{partition}"
    not_if { disk.nil? || ::File.directory?("#{datadir}") }
  end

  execute "mkdir #{datadir}" do
    not_if { ::File.exist?("#{datadir}") }
  end

  mount datadir do
    device partition
    action [:mount, :enable]
    fstype new_resource.fstype || "ext3"
    not_if { disk.nil? }
  end

  updated = !disk.nil?
  new_resource.updated_by_last_action(updated)
end

action :delete do
  datadir = new_resource.path
  disk = new_resource.disk

  Chef::Log.fatal("You need to pass the disk parameter in (e.g.: disk \"/dev/svdb1\")") if disk.nil?

  m = mount datadir do
    device partition
    action [:umount, :disable]
    fstype new_resource.fstype || "ext3"
    not_if { disk.nil? }
  end

  new_resource.updated_by_last_action(m.updated_by_last_action?)
end
