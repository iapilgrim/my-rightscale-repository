default['splunk']['accept_license'] = true
default['splunk']['is_server']      = false
default['splunk']['receiver_port']  = '9997'
default['splunk']['servers']  = '54.251.106.123'

default['splunk']['user'] = {
  'username' => 'splunk',
  'comment'  => 'Splunk Server',
  'home'     => '/opt/splunkforwarder',
  'shell'    => '/bin/bash',
  'uid'      => 396
}

default['splunk']['ssl_options'] = {
  'enable_ssl' => false,
  'data_bag' => 'vault',
  'data_bag_item' => 'splunk_certificates',
  'keyfile' => 'self-signed.example.com.key',
  'crtfile' => 'self-signed.example.com.crt'
}

# If the `is_server` attribute is set (via an overridable location
# like a role), then set particular attribute defaults based on the
# server, rather than Universal Forwarder. We hardcode the path
# because we don't want to rely on automagic.
if node['splunk']['is_server']
  default['splunk']['user']['home'] = '/opt/splunk'
end

case node['platform_family']
when 'rhel'
  if node['kernel']['machine'] == 'x86_64'
    default['splunk']['forwarder']['url'] = 'http://download.splunk.com/releases/6.1.1/universalforwarder/linux/splunkforwarder-6.1.1-207789-linux-2.6-x86_64.rpm'
    default['splunk']['server']['url'] = 'http://download.splunk.com/releases/6.1.1/splunk/linux/splunk-6.1.1-207789-linux-2.6-x86_64.rpm'
  else
    default['splunk']['forwarder']['url'] = 'http://download.splunk.com/releases/6.1.1/universalforwarder/linux/splunkforwarder-6.1.1-207789.i386.rpm'
    default['splunk']['server']['url'] = 'http://download.splunk.com/releases/6.1.1/splunk/linux/splunk-6.1.1-207789.i386.rpm'
  end
when 'debian'
  if node['kernel']['machine'] == 'x86_64'
    default['splunk']['forwarder']['url'] = 'http://download.splunk.com/releases/6.1.1/universalforwarder/linux/splunkforwarder-6.1.1-207789-linux-2.6-amd64.deb'
    default['splunk']['server']['url'] = 'http://download.splunk.com/releases/6.1.1/splunk/linux/splunk-6.1.1-207789-linux-2.6-amd64.deb'
  else
    default['splunk']['forwarder']['url'] = 'http://download.splunk.com/releases/6.1.1/universalforwarder/linux/splunkforwarder-6.1.1-207789-linux-2.6-intel.deb'
    default['splunk']['server']['url'] = 'http://download.splunk.com/releases/6.1.1/splunk/linux/splunk-6.1.1-207789-linux-2.6-intel.deb'
  end
when 'omnios'
  default['splunk']['forwarder']['url'] = 'http://download.splunk.com/releases/6.1.1/universalforwarder/solaris/splunkforwarder-6.1.1-207789-SunOS-x86_64.tar.Z'
  default['splunk']['server']['url'] = 'http://download.splunk.com/releases/6.1.1/splunk/solaris/splunk-6.1.1-207789-solaris-10-intel.pkg.Z'
end