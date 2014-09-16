PDFKit.configure do |config|

  config.default_options = {
    :encoding      => 'UTF-8',
    :page_size     => 'Letter',
    :margin_top    => '0.2in',
    :margin_right  => '0.2in',
    :margin_bottom => '0.4in',
    :margin_left   => '0.2in'
  }
end
