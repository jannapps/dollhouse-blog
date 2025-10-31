require "redcarpet"
require "yaml"

class HomeController < ApplicationController
  def index
    # Read and render the home.md file with layout support
    home_path = Rails.root.join("posts", "home.md")

    if File.exist?(home_path)
      raw_content = File.read(home_path)
      frontmatter, content = parse_frontmatter(raw_content)

      # Set page metadata
      @page_title = frontmatter["title"] || "Dollhouse Blog"
      @layout_name = frontmatter["layout"]
      @widget_config = extract_widget_config(frontmatter)

      # Parse content sections and render markdown
      @content_sections = parse_content_sections(content)
      @content = @content_sections["main"] || render_markdown(content).html_safe

      # Use custom layout if specified, otherwise default
      if @layout_name && layout_exists?(@layout_name)
        render template: "layouts/content/#{@layout_name}", layout: "application"
      end
    else
      @content = "<p>Home page not found. Please create posts/home.md</p>".html_safe
    end
  end

  private

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

  def parse_content_sections(content)
    # Parse content sections using ---section: name--- delimiters
    sections = {}

    # Split content by section delimiters
    parts = content.split(/^---section:\s*(\w+)---$/m)

    if parts.length == 1
      # No sections found, treat entire content as main
      sections["main"] = render_markdown(content).html_safe
    else
      # First part (before any section delimiter) is main content
      if parts[0].strip.present?
        sections["main"] = render_markdown(parts[0].strip).html_safe
      end

      # Process named sections
      (1...parts.length).step(2) do |i|
        section_name = parts[i].strip
        section_content = parts[i + 1]&.strip || ""

        if section_content.present?
          sections[section_name] = render_markdown(section_content).html_safe
        end
      end
    end

    sections
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
end
