require 'webrick'
 
include WEBrick
 
def start_webrick(config = {})
  config.update(:Port => 8080)     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end
 
start_webrick(:DocumentRoot => 'Labs/LabKPI1/filename.html')