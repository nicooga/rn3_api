JSONAPI.configure do |config|
  config.default_paginator = :paged
  config.default_page_size = 8
  config.top_level_meta_include_page_count = true
end
