require "erb"
require 'webrick'
include WEBrick

# render template
template = File.read('./table1.html.erb')
result = ERB.new(template).result(binding)

# write result to file
File.open('filename.html', 'w+') do |f|
  f.write result
end

#output file 
erb = ERB.new(File.open("#{__dir__}/table1.html.erb").read, 0, '>')
puts erb.result binding

#server
def start_webrick(config = {})
  config.update(:Port => 8080)     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end
 
start_webrick(:DocumentRoot => 'filename.html')