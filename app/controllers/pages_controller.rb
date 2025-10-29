require "redcarpet"

class PagesController < ApplicationController
  def show
    # Get the path from the route parameter and validate it through whitelist
    requested_page = sanitized_page_param
    return render_not_found unless requested_page

    # Get the safe file path from pre-approved whitelist
    markdown_path = allowed_pages[requested_page]
    return render_not_found unless markdown_path

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
    @page_title = requested_page.titleize
  end

  private

  def sanitized_page_param
    # Extract and validate page parameter through strict whitelist
    raw_param = params[:path]
    return nil if raw_param.blank?

    # Only allow safe characters: letters, numbers, hyphens, underscores
    return nil unless raw_param.match?(/\A[a-zA-Z0-9\-_]+\z/)

    # Additional length check
    return nil if raw_param.length > 100

    # Only return if it exists in our pre-approved whitelist
    return raw_param if allowed_pages.key?(raw_param)

    nil
  end

  def allowed_pages
    # Static mapping of page names to file paths - completely isolates user input
    # This method scans for existing markdown files and creates a safe mapping
    @allowed_pages ||= begin
      pages = {}
      posts_dir = Rails.root.join("posts")

      # Only scan files that exist and are within the posts directory
      Dir.glob(posts_dir.join("*.md")).each do |file_path|
        next unless File.file?(file_path)
        next unless file_path.start_with?(posts_dir.to_s)

        page_name = File.basename(file_path, ".md")
        next unless page_name.match?(/\A[a-zA-Z0-9\-_]+\z/)

        pages[page_name] = file_path
      end

      pages
    end
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
