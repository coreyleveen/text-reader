require 'rack'

app = Proc.new do |env|
  [
    '200',
    {'Content-Type' => 'text/html'},
    File.open("test.html", File::RDONLY)
  ]
end

Rack::Handler::WEBrick.run app
