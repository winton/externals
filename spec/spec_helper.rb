$TESTING = true
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'externals'
require 'pp'

def debug(object)
  puts "<pre>"
  pp object
  puts "</pre>"
end