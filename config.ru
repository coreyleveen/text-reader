use Rack::Static,
  :urls => ["/public"],
  :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html'
    },
    File.open('public/test.html', File::RDONLY)
  ]
}
