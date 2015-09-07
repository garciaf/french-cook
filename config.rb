###
# Blog settings
###

# Time.zone = "UTC"
activate :i18n, :mount_at_root => :en
activate :middleman_simple_thumbnailer

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.name = "en"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "blog/en/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  # blog.layout = "layout"
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag_en.html"
  blog.calendar_template = "calendar_en.html"
  blog.layout = "post"
  # Enable pagination
  blog.paginate = true
  blog.per_page = 6
  blog.page_link = "page/{num}"
end

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.name = "fr"
  blog.permalink = "fr/{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "blog/fr/{year}-{month}-{day}-{title}.html"
  blog.taglink = "fr/tag/{tag}.html"
  # blog.layout = "layout"
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  blog.year_link = "fr/{year}.html"
  blog.month_link = "fr/{year}/{month}.html"
  blog.day_link = "fr/{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag_fr.html"
  blog.calendar_template = "calendar_fr.html"
  blog.layout = "post"
  # Enable pagination
  blog.paginate = true
  blog.per_page = 6
  blog.page_link = "page/{num}"
end
set :casper, {
  blog: {
    url: 'http://the-french-cook.com/',
    name: 'The French cook',
    description: 'Make the world a better place to eat',
    date_format: '%d %B %Y',
    navigation: true,
    logo: 'cover.jpg' # Optional
  },
  author: {
    name: 'The Cooker',
    bio: "Developer by day, fighter, cook and photographer by night",
    location: 'Berlin',
    website: nil, # Optional
    gravatar_email: 'fabien@the-french-cook.com' # Optional
  },
  navigation: {
    "Fabbook" => "http://fabbook.fr",
    "Fabphoto" => "http://fabphoto.fr",
    "Fabfight" => "http://fabfight.com"
  }
}

page '/feed.en.xml', layout: false
page '/feed.fr.xml', layout: false
page '/sitemap.xml', layout: false


config = YAML.load_file("parameter.yml")
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

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: false


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :partials_dir, 'partials'

ignore '/partials/*'
ignore '/tag_en.html.haml'
ignore '/tag_fr.html.haml'
ignore '/calendar_en.html.haml'
ignore '/calendar_fr.html.haml'

ready do
  langs.each do |locale|
    if locale == I18n.default_locale
      proxy "/author/#{blog_author.name.parameterize}.html", "/author.#{locale}.html", ignore: true do
        ::I18n.locale = locale
      end
    else
      
      proxy "/#{locale}/author/#{blog_author.name.parameterize}.html", "/author.#{locale}.html", ignore: true do
        ::I18n.locale = locale
      end
    end
  end
end


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  activate :minify_html
  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
