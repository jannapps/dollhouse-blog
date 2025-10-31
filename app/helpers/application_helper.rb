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
end
