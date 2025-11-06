require "yaml"
require "redcarpet"

module ApplicationHelper
  def render_widget(widget_name, options = {})
    # Render a widget with support for both markdown and ERB formats
    return "" if widget_name.blank?

    # First, check for markdown widgets
    markdown_widget = find_markdown_widget(widget_name)
    if markdown_widget
      return render_markdown_widget(markdown_widget, options)
    end

    # Fall back to ERB partial widgets
    widget_path = "widgets/#{widget_name}"
    if lookup_context.exists?(widget_path, [], true)
      render(partial: widget_path, locals: options)
    else
      # Graceful fallback for missing widgets
      content_tag(:div, "Widget '#{widget_name}' not found", class: "widget-error")
    end
  end

  def styled_content(content)
    # Automatically wrap content in beautiful markdown styling
    content_tag(:div, content.html_safe, class: "markdown-content")
  end

  def get_all_posts
    # Get all posts with metadata for the post-list widget
    posts = {}
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

      # Read file to get title from frontmatter
      begin
        content = File.read(file_path)
        title = extract_title_from_content(content, page_name)

        posts[page_name] = {
          title: title,
          dynamic: file_path.end_with?(".md.erb"),
          path: file_path
        }
      rescue => e
        # Skip files that can't be read
        next
      end
    end

    # Sort by title for consistent display
    posts.sort_by { |_, info| info[:title].downcase }
  end

  def find_markdown_widget(widget_name)
    # Look for markdown widget files in widgets/ directory
    widgets_dir = Rails.root.join("widgets")
    return nil unless Dir.exist?(widgets_dir)

    # Check for both .md and .md.erb files
    [ ".md.erb", ".md" ].each do |ext|
      widget_path = widgets_dir.join("#{widget_name}#{ext}")
      if File.exist?(widget_path) && widget_name.match?(/\A[a-zA-Z0-9\-_]+\z/)
        return {
          path: widget_path,
          name: widget_name,
          dynamic: ext == ".md.erb"
        }
      end
    end

    nil
  end

  def render_markdown_widget(widget_info, options = {})
    # Read and process markdown widget file
    begin
      raw_content = File.read(widget_info[:path])
      frontmatter, content = parse_widget_frontmatter(raw_content)

      # Process ERB if it's a dynamic widget
      if widget_info[:dynamic]
        content = process_widget_erb(content)
      end

      # Render markdown to HTML
      html_content = render_widget_markdown(content)

      # Build CSS classes
      css_classes = [ "widget", "markdown-widget" ]
      css_classes << "widget-#{widget_info[:name]}"
      css_classes << frontmatter["css_class"] if frontmatter["css_class"]

      # Wrap in widget container
      content_tag(:div, html_content.html_safe, class: css_classes.join(" "))

    rescue => e
      # Error handling for widget processing
      content_tag(:div, "Error loading widget '#{widget_info[:name]}': #{e.message}", class: "widget-error")
    end
  end

  def parse_widget_frontmatter(content)
    # Parse YAML frontmatter from widget content (same as posts)
    if content.start_with?("---\n")
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

  def process_widget_erb(content)
    # Process ERB content within helper context to access helper methods
    ERB.new(content).result(binding)
  end

  def render_widget_markdown(content)
    # Render markdown using the same processor as posts
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

  private

  def extract_title_from_content(content, fallback_name)
    # Try to extract title from YAML frontmatter
    if content.start_with?("---\n")
      end_marker = content.index("\n---\n", 4)
      if end_marker
        frontmatter_text = content[4...end_marker]
        begin
          frontmatter = YAML.safe_load(frontmatter_text)
          return frontmatter["title"] if frontmatter && frontmatter["title"]
        rescue Psych::SyntaxError
          # Fall through to fallback
        end
      end
    end

    # Fallback to titleized page name
    fallback_name.titleize
  end
end
