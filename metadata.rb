name             'datadisk'
maintainer       'Milo de Vries | Springest'
maintainer_email 'milo@springest.com'
license          'MIT'
description      'Finds, formats and mounts the datadisk provided by some hosters'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

provides "datadisk"
recipe "datadisk", "formats and mounts the datadisk"
