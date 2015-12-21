Gem::Specification.new do |s|
  s.name = 'ec2i3'
  s.version = '0.1.2'
  s.summary = 'EC2 in 3 steps: step 1. register the AWS account details in the XML registry, step 2. launch the EC2 instance, step 3. Publish the status of the instance using SimplePubSub.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/ec2i3.rb']
  s.add_runtime_dependency('instant_ec2', '~> 0.1', '>=0.1.3')
  s.add_runtime_dependency('sps-pub', '~> 0.4', '>=0.4.3')
  s.add_runtime_dependency('encrypt', '~> 0.1', '>=0.1.0')
  s.add_runtime_dependency('xml-registry', '~> 0.4', '>=0.4.4')
  s.add_runtime_dependency('dynarex-password', '~> 0.1', '>=0.1.1')
  s.signing_key = '../privatekeys/ec2i3.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/ec2i3'
end
