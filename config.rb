require 'boarding_pass'
require 'uglifier'

set :helpers_dir, 'helpers'
set :helpers_filename_glob, '**/*_helper.rb'
set :helpers_filename_to_module_name_proc, Proc.new { |filename|
  basename = File.basename(filename, File.extname(filename))
  basename.camelcase
}

Time.zone = 'Europe/Moscow'

set :markdown_engine, :redcarpet
set :markdown,
    :fenced_code_blocks => true,
    :no_intra_emphasis => true,
    :strikethrough => true,
    :smartypants => true,
    :tables => true,
    :link_attributes => { target: '_blank' }

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page '/path/to/file.html', :layout => false
#
# With alternative layout
# page '/path/to/file.html', :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page '/admin/*'
# end

# page '*', :layout => :article

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', :locals => {
#  :which_fake_page => 'Rendering a fake page with a local variable' }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Syntax highlighting
# activate :syntax

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

###
# Team member pages
###
# page '/team/*', :layout => 'team-member'

###
# Blogs
###
activate :blog do |blog|
  blog.name    = 'blog'
  blog.prefix  = 'blog'
  blog.sources = '{title}.html'
  blog.layout    = 'layouts/blog-post'
  blog.permalink = '{title}'
  blog.paginate  = true
  # blog.page_link = 'p{num}'
  blog.per_page  = 5
  blog.default_extension = '.md'
end

activate :blog do |blog|
  blog.name    = 'projects'
  blog.prefix  = 'projects'
  blog.sources = '{title}.html'
  blog.layout    = 'layouts/project'
  blog.permalink = '{title}'
  blog.default_extension = '.slim'
end

redirect 'about.html',      to: '/#about'
redirect 'portfolio.html', to: '/projects/'

activate :directory_indexes
page '/sitemap.xml', layout: false
page '/feed.xml',    layout: false

activate :deploy do |deploy|
  deploy.method = :git
  # deploy.remote = 'origin' # uses 'origin' by default
  # deploy.branch = 'gh-pages' # uses 'gh-pages' by default
end

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'
set :fonts_dir,  'fonts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css,
            inline: true

  # Minify Javascript on build
  uglifier = Uglifier.new(output: {
    inline_script: true
  })
  activate :minify_javascript,
            inline: true,
            compressor: uglifier

  # Enable cache buster
  activate :asset_hash

  activate :minify_html
  activate :gzip

  activate :asset_host
  set :asset_host, 'http://annasuprunenko.com'

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
end
