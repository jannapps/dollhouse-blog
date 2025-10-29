require "redcarpet"

class HomeController < ApplicationController
  def index
    # Read and render the home.md file
    home_path = Rails.root.join("posts", "home.md")

    if File.exist?(home_path)
      markdown_content = File.read(home_path)

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
    else
      @content = "<p>Home page not found. Please create posts/home.md</p>".html_safe
    end
  end
end
