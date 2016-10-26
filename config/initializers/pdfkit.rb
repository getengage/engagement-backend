PDFKit.configure do |config|
  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true
  }
  config.verbose = true
end