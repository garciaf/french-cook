module ApplicationHelpers
  def page_title
    title = blog_name.dup
    if current_page.data.title
      title << ": #{current_page.data.title}"
    elsif is_blog_article?
      title << ": #{current_article.title}"
    end
    title
  end

  def page_description
    if is_blog_article?
      Sanitize.clean(current_article.summary(150, '')).strip.gsub(/\s+/, ' ')
    else
      blog_description
    end
  end

  def page_class
    is_blog_article? ? 'post-template tag-getting-started' : 'home-template'
  end

  def summary(article)
    Sanitize.clean(article.summary, whitespace_elements: %w(h1))
  end

  def author
    {
      bio: author_bio,
      location: author_locaton,
      name: author_name,
      website: author_website
    }
  end
  def date_link(article = current_article, separator = ' ')
    links = []
    links << link_to(article.date.strftime('%d'), blog_day_path(article.date.year, article.date.month,article.date.day))
    links << link_to(article.date.strftime('%b'), blog_month_path(article.date.year,article.date.month) )
    links << link_to(article.date.year, blog_year_path(article.date.year))
    links.join(separator)
  end
  def tags?(article = current_article)
    article.tags.present?
  end
  def tags(article = current_article, separator = ' | ')
    article.tags.collect{|tag| link_to tag, tag_path(tag) }.join(separator)
  end
  def cover?(article = current_article)
    article.data['cover'].present?
  end
  def cover(article = current_article)
    image_tag article.data['cover']
  end
  def current_article_url
    URI.join(blog_url, current_article.url)
  end

  def blog_logo?
    return false if blog_logo.blank?
    File.exists?(File.join('source', images_dir, blog_logo))
  end

  def twitter_url
    "https://twitter.com/share?text=#{current_article.title}" \
      "&amp;url=#{current_article_url}"
  end
  def facebook_url
    "https://www.facebook.com/sharer/sharer.php?u=#{current_article_url}"
  end
  def google_plus_url
    "https://plus.google.com/share?url=#{current_article_url}"
  end

  def feed_path
    '/feed.xml'
  end
end