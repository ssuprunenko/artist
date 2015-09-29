module ProjectHelper
  # Find case studies
  def find_project_by_title(title)
    unless title
      raise "A title is required to look up a case study"
    end
    project = blog('projects').articles.find { |a| a.title == title }
    unless project
      raise "Could not find a project with the title of: #{title}"
    end
    project
  end

  # Case study image
  def project_image_path(image, article = current_page)
    image_path "#{article_path(article)}#{image}"
  end

  # Image path for case study cover logo
  def project_logo_path(extension, article = current_page)
    filename = article.data.cover_logo || 'cover-logo'
    image_path "#{article_path(article)}#{filename}.#{extension.to_s}"
  end

  def project_logo(options = {}, article = current_page)
    src = project_logo_path(:svg, article)
    options[:alt] = article.title
    options[:onerror] = "this.src='#{project_logo_path(:png, article)}'"
    image_tag src, options
  end

  # Image path for case study cover background
  def project_bg_path(article = current_page)
    image_path "#{article_path(article)}#{article.data.cover_bg || 'cover-bg.jpg'}"
  end

  def project_bg_src(article = current_page)
    "/images/#{article_path(article)}cover-bg.jpg"
  end

  # Slideshow builder
  def project_slideshow(image_names, article = current_page)
    path   = article_path(article)
    slides = image_names.map do |name|
      {
        src: "#{path}slides/#{name}.jpg",
        alt: article.title
      }
    end
    component "slideshow", { slides: slides }
  end
end
