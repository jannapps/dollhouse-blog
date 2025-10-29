require "redcarpet"
require "yaml"

class PagesController < ApplicationController
  helper_method :render_widget
  def show
    # Get the path from the route parameter and validate it through whitelist
    requested_page = sanitized_page_param
    return render_not_found unless requested_page

    # Get the safe file path from pre-approved whitelist
    markdown_path = allowed_pages[requested_page]
    return render_not_found unless markdown_path

    # Read and parse the file content
    raw_content = File.read(markdown_path)
    frontmatter, content = parse_frontmatter(raw_content)

    # Set page metadata
    @page_title = frontmatter["title"] || requested_page.titleize
    @layout_name = frontmatter["layout"]
    @widget_config = extract_widget_config(frontmatter)

    # Process content through ERB if needed
    if markdown_path.end_with?(".md.erb")
      content = process_erb(content)
    end

    # Render markdown content
    @content = render_markdown(content).html_safe

    # Use custom layout if specified, otherwise default
    if @layout_name && layout_exists?(@layout_name)
      render template: "layouts/content/#{@layout_name}", layout: "application"
    end
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

  def parse_frontmatter(content)
    # Check if content starts with YAML frontmatter
    if content.start_with?("---\n")
      # Find the closing ---
      end_marker = content.index("\n---\n", 4)
      if end_marker
        frontmatter_text = content[4...end_marker]
        remaining_content = content[end_marker + 5..-1] || ""

        begin
          frontmatter = YAML.safe_load(frontmatter_text) || {}
        rescue Psych::SyntaxError
          frontmatter = {}
        end

        return [ frontmatter, remaining_content ]
      end
    end

    # No frontmatter found
    [ {}, content ]
  end

  def extract_widget_config(frontmatter)
    # Extract widget configuration from frontmatter
    config = {}
    frontmatter.each do |key, value|
      # Any key that doesn't start with reserved prefixes becomes a widget slot
      unless %w[layout title].include?(key)
        config[key] = value
      end
    end
    config
  end

  def layout_exists?(layout_name)
    # Check if the layout template exists
    layout_path = Rails.root.join("app", "views", "layouts", "content", "#{layout_name}.html.erb")
    File.exist?(layout_path)
  end

  def render_widget(widget_name, options = {})
    # Render a widget partial with error handling
    return "" if widget_name.blank?

    widget_path = "widgets/#{widget_name}"
    if lookup_context.exists?(widget_path, [], true)
      render(partial: widget_path, locals: options)
    else
      # Graceful fallback for missing widgets
      content_tag(:div, "Widget '#{widget_name}' not found", class: "widget-error")
    end
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
