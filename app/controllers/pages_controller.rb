require "redcarpet"

class PagesController < ApplicationController
  def show
    # Get the path from the route parameter and validate it through whitelist
    requested_page = sanitized_page_param
    return render_not_found unless requested_page

    # Get the safe file path from pre-approved whitelist
    markdown_path = allowed_pages[requested_page]
    return render_not_found unless markdown_path

    # Read the file content
    raw_content = File.read(markdown_path)

    # Check if this is an ERB file and process accordingly
    if markdown_path.end_with?(".md.erb")
      # Process ERB first, then markdown
      erb_content = process_erb(raw_content)
      markdown_content = render_markdown(erb_content)
    else
      # Process as regular markdown
      markdown_content = render_markdown(raw_content)
    end

    @content = markdown_content.html_safe
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

  def process_erb(content)
    # Process ERB content within the controller context to access helpers and instance variables
    ERB.new(content).result(binding)
  end

  def render_markdown(content)
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

    markdown.render(content)
  end

  def allowed_pages
    # Static mapping of page names to file paths - completely isolates user input
    # This method scans for existing markdown files (.md and .md.erb) and creates a safe mapping
    @allowed_pages ||= begin
      pages = {}
      posts_dir = Rails.root.join("posts")

      # Scan for both .md and .md.erb files
      Dir.glob(posts_dir.join("*.{md,md.erb}")).each do |file_path|
        next unless File.file?(file_path)
        next unless file_path.start_with?(posts_dir.to_s)

        # Extract page name (remove .md or .md.erb extension)
        page_name = if file_path.end_with?(".md.erb")
                      File.basename(file_path, ".md.erb")
        else
                      File.basename(file_path, ".md")
        end

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
