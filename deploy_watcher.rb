require 'serialport'
require 'rest_client'

port_str  = '/dev/tty.usbmodem1411'
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity    = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

TO_BRANCHES = ["staging", "feature_staging"]

def get_branch(index)
  RestClient.get("http://deploy-module.herokuapp.com/branches/#{index}")
end

while(true) do
  message = sp.gets
  message.chomp!

  puts message
  from, to = message.match(/Deploying - From:(\d+) To:(\d)/).captures.map(&:to_i)

  from_branch = get_branch(from)
  to_branch   = TO_BRANCHES[to - 1]

  puts from_branch
  puts to_branch

  filepath = `pwd`.strip + "/deploy.sh"
  puts `#{filepath} #{from_branch} #{to_branch}`
end
