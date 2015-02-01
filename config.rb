require 'slim'

activate :automatic_image_sizes

set :css_dir,    'assets/css'
set :js_dir,     'assets/js'
set :images_dir, 'assets/img'

configure :development do
  activate :livereload

  compass_config do |config|
    config.output_style = :expanded
  end
end

configure :build do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
  activate :relative_assets

  set :relative_links, true

  compass_config do |config|
    config.output_style = :compressed
  end
end
