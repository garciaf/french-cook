require 'sanitize'

###
# Blog settings
###

# Time.zone = "UTC"
config = YAML.load_file("parameter.yml")
activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "blog/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  blog.summary_separator = /READMORE/
  # blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

# Required
set :blog_url, 'http://the-french-cook.com/'
set :blog_name, 'The French cook '
set :blog_description, 'Make the world a better place to eat'
set :author_name, 'French Cooker'
set :author_bio, 'Fight the bad food with the taste of good food ' 

# Optional
set :author_locaton, nil
set :author_website, nil
set :blog_logo, nil

page '/feed.xml', layout: false

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
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###
activate :deploy do |deploy|
  deploy.method = :ftp
  deploy.host = config['deploy']['host']
  deploy.user = config['deploy']['user']
  deploy.password = config['deploy']['password']
  deploy.path = config['deploy']['path']
  deploy.build_before = true # default: false
end
# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: true

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
