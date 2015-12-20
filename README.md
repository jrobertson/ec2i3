# Introducing the EC2i3 gem

    require 'ec2i3'

    reg = XMLRegistry.new '/home/james/da2/registry/registry.xml'
    e = EC2i3.new reg, address: '192.168.4.140'
    e.start 'windows', duration: 2

The above example fetches the Amazon Web Services (AWS)  credentials from the XML registry, launches the Windows EC2 instance, and then publishes the public IP address to the SimplePubSub broker. After 2 minutes the Windows EC2 instance is stopped, and a further SimplePubSub message is published to notify subscribers of topic *EC2i3* that the instance is stopping.

## How to create a ec2i3.reg file for importing into the XML registry

Before running this script you need to have a valid AWS access_key + AWS private_key, and have generated a ?Dynarex-password lookup file http://www.jamesrobertson.eu/snippets/2012/may/04/introducing-the-dynarex-password-gem.html?.

    require 'leetpassword'
    require 'dynarex-password'
    require 'encrypt'

    access_key = 'your_aws_accessid'
    private_key = 'your_aws_privatekey'
    lookup_file = '/home/james/password-010915.xml'

    dp = DynarexPassword.new
    passphrase = LeetPassword.generate(8)
    encrypted_passphrase = dp.lookup(passphrase, lookup_file)

    encrypted_private_key = Encrypt.dump(private_key, passphrase).\
                                                       each_byte.to_a.join(' ')
    private_key = Encrypt.load(encrypted_private_key.\
                                 split(' ').map(&:to_i).pack('C*'), passphrase)

    s = "
    hkey_apps/ec2i3
    access_key_id: #{access_key}
    private_key: #{encrypted_private_key}
    lookup_file: #{lookup_file}
    passphrase: #{encrypted_passphrase}
    "

    File.write 'ec2i3.reg', s

## Resources

* Introducing the xml-registry gem http://www.jamesrobertson.eu/snippets/2012/01/18/1357hrs.html
* Introducing the Leetpassword gem http://www.jamesrobertson.eu/snippets/2012/sep/19/introducing-the-leetpassword-gem.html
* Introducing the Encrypt gem http://www.jamesrobertson.eu/snippets/2014/feb/12/introducing-the-encrypt-gem.html
* Convert a string to bytes and then back to a string http://www.jamesrobertson.eu/snippets/2014/feb/12/convert-a-string-to-bytes-and-then.html
* Introducing the Dynarex-password gem http://www.jamesrobertson.eu/snippets/2012/may/04/introducing-the-dynarex-password-gem.html
* Introducing the instant_ec2 gem http://www.jamesrobertson.eu/snippets/2015/dec/20/introducing-the-instant_ec2-gem.html
* ec2i3 https://rubygems.org/gems/ec2i3

ec2i3 gem ec2 aws sps
