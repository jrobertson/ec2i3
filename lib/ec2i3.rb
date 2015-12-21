#!/usr/bin/env ruby

# file: ec2i3.rb


require 'sps-pub'
require 'encrypt'
require 'instant_ec2'
require 'xml-registry'
require 'dynarex-password'


class EC2i3 < InstantEC2

  def initialize(reg, address: '127.0.0.1', port: '59000')

    @address, @port = address, port

    entry = reg.get_key('hkey_apps/ec2i3')

    dp = DynarexPassword.new
    passphrase = dp.reverse_lookup(entry.text('passphrase'), 
                                                     entry.text('lookup_file'))
    enc_priv_key = entry.text('private_key').split(' ').map(&:to_i).pack('C*')
    private_key = Encrypt.load(enc_priv_key, passphrase)

    super credentials: [entry.text('access_key_id'), private_key]
    @sps = SPSPub.new address: @address, port: @port

    @hooks = {
      running: ->(ip){ 

        msg = "EC2i3: the instance is now accessible from %s" % [ip]
        @sps.notice msg

      },
      stopping: ->(){ 
        msg = "EC2i3: the instance is now stopping"
        @sps.notice msg
      }
    }
    
  end

end
