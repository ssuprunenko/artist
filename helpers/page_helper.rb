module PageHelper
  def site_description
    error_msg = "Site description is missing: add a `description` field in `data/site.yml`"
    data.site.description || (raise error_msg)
  end

  def page_url(page = current_page)
    data.site.host + page.url
  end

  def page_title(page = current_page)
    unless page.data.title
      raise "Page title is missing in: '#{page.source_file}'"
    end
    page.data.title
  end

  def page_long_title(page = current_page)
    page.data.long_title || page_title(page)
  end

  def page_browser_title(page = current_page)
    prefix = "#{page_long_title} | " if page_long_title
    suffix = data.site.title
    unless data.site.title
      raise "Site title is missing: add a `title` field in `data/site.yml`"
    end
    prefix + suffix
  end

  def page_description(page = current_page)
    page.data.tagline || site_description
  end

  def page_image(page = current_page)
    image = page.data.image
    if image
      path = page.url.split("/").reject(&:empty?).join("/")
      image_path("#{path}/#{image}")
    elsif is_project(page)
      project_bg_path(page)
    end
  end

  def page_social_image(page = current_page)
    if page_image
      page_image
    end
  end

  def page_author(page = current_page)
    if page.data.author
      return find_team_member_by_name(page.data.author)
    end
  end

  def page_short_url(page = current_page)
    page.data.short_url
  end

  def page_fb_type(page = current_page)
    if is_blog_post(page)
      return "article"
    end
    "website"
  end

  private

  def is_blog_post(page)
    page.respond_to?(:blog_data) && page.blog_options.name == "blog"
  end

  def is_project(page)
    page.respond_to?(:blog_data) && page.blog_options.name == "projects"
  end
end
