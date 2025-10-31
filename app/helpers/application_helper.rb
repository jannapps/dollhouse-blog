require "yaml"

module ApplicationHelper
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
