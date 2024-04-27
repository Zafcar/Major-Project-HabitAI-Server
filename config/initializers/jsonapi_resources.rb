JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :paged
  config.default_paginator = :paged

  config.default_page_size = 20
  config.maximum_page_size = 40

  config.json_key_format = :underscored_key
end
