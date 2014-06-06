name             'feeder-web'
maintainer       'UAF-GINA'
maintainer_email 'support+chef@gina.alaska.edu'
license          'Apache 2.0'
description      'Installs/Configures feeder-web'
long_description 'Installs/Configures feeder-web'
version          '0.1.0'

supports "centos", ">= 6.0"

depends 'chruby'
depends 'nginx'
depends 'postgresql'
depends 'database'
depends 'unicorn'
depends 'runit'
depends 'yum-epel'
depends 'yum-gina'