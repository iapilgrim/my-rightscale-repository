name             'splunk'
maintainer       'HR Boss'
maintainer_email 'van.le@hrboss.com'
license          'All rights reserved'
description      'Installs/Configures splunk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends "rightscale"

recipe "splunk::default","Setup Splunk Server/Forwarder."
recipe "splunk::client","Setup Splunk Server/Forwarder."
recipe "splunk::setup_auth","Setup Splunk Authentication."

# Required #
attribute "splunk/servers",
   :display_name => "Splunk Server",
   :description => "Specify Splunk Servers.",
   :required => "required",
   :recipes => ["splunk::default"]

attribute "splunk/splunk_auth_info",
   :display_name => "Splunk Authentication Info",
   :description => "Specify Splunk Auth Info to Send Data.",
   :required => "required",
   :recipes => ["splunk::default"]   