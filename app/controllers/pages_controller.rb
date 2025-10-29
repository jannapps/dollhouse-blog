require "redcarpet"

class PagesController < ApplicationController
  def show
    # Get the path from the route parameter and sanitize it
    page_name = sanitize_path(params[:path])
    return render_not_found unless page_name

    # Construct the path to the markdown file
    markdown_path = Rails.root.join("posts", "#{page_name}.md")

    # Ensure the path is within the posts directory (prevent path traversal)
    unless markdown_path.to_s.start_with?(Rails.root.join("posts").to_s)
      return render_not_found
    end

    if File.exist?(markdown_path)
      markdown_content = File.read(markdown_path)

      # Initialize Redcarpet markdown processor with HTML rendering
      renderer = Redcarpet::Render::HTML.new(
        filter_html: false,
        no_links: false,
        no_images: false,
        with_toc_data: true,
        hard_wrap: true
      )

      markdown = Redcarpet::Markdown.new(renderer,
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        strikethrough: true,
        superscript: true
      )

      @content = markdown.render(markdown_content).html_safe
      @page_title = page_name.titleize
    else
      render_not_found
    end
  end

  private

  def sanitize_path(path)
    # Remove any path traversal attempts and ensure only alphanumeric, dash, underscore
    return nil if path.blank?

    # Only allow safe characters for filenames
    sanitized = path.gsub(/[^a-zA-Z0-9\-_]/, "")

    # Return nil if the sanitized path is empty or different from original (indicates malicious input)
    return nil if sanitized.blank? || sanitized != path

    sanitized
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
