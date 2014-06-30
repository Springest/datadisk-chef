actions :create, :delete
default_action :create

attribute :path, kind_of: String, name_attribute: true
attribute :disk, kind_of: String # optional, defaults to unformatted disk
attribute :fstype, kind_of: String # default "ext3"
