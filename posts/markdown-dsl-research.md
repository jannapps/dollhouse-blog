# Markdown DSL Research - October 2024

Research into existing tools that expand markdown functionality for potential DSL development.

## Well-Maintained Core Processors (2024)

### JavaScript Ecosystem - Excellent Maintenance
- **Remark/Unified**: "World's most popular markdown parser" with 150+ plugins, actively maintained with Node.js 16+ compatibility, part of unified collective
- **MDX**: JSX in markdown, actively maintained with 2024 ECMAScript support, widely used in React/Next.js ecosystem

### Ruby Ecosystem - Good Maintenance
- **Redcarpet**: Version 3.6.1 (March 2025), 106 contributors, 104k+ dependent repos, maintained by Robin Dupret and Matt Rogers
- **Kramdown**: Pure Ruby, supports Markdown-in-HTML (unlike Redcarpet), good for mixed content
- **CommonMarker**: C implementation, faster than pure Ruby solutions

## Approaches to Markdown Extensions

### 1. Shortcode/Macro Systems
- **Hugo Shortcodes**: `{{< shortcode >}}` syntax, pre-built templates for figures, gists, syntax highlighting
- **Jekyll Liquid Tags**: `{% tag %}` syntax, full templating language integration
- **Both are mature, widely-used approaches for content creators**

### 2. Plugin-Based Processors
- **markdown-it**: Fast, 100% CommonMark support, configurable syntax, npm ecosystem
- **Python-Markdown**: Extension API for custom processors (block/inline processors)

### 3. Preprocessors
- **MarkdownPP**: Python-based, focus on technical documents, table of contents generation
- **Gitdown**: GitHub-flavored, variables and document inclusion
- **markedpp**: Extended image-tag-like syntax `!command[options]`

### 4. Framework-Integrated Solutions
- **mdsvex** (Svelte): Svelte components in markdown, zero-config TypeScript support
- **Sveltek Markdown**: Rewritten for Svelte 5, component-based approach

## Maintenance Status Assessment

### Excellent (Active Development)
- Remark/Unified ecosystem
- MDX and React integration
- Hugo/Jekyll (backed by large communities)

### Good (Stable, Regular Updates)
- Redcarpet (Ruby standard)
- Kramdown
- markdown-it

### Moderate (Working but Limited)
- Python-Markdown extensions
- Standalone preprocessors

## Key Trends for Custom DSL Development

1. **Component Integration**: Modern tools blur the line between markdown and interactive components
2. **Framework-Specific**: Best tools are tightly integrated with specific ecosystems (Hugo, React, Svelte)
3. **Plugin Architecture**: Successful tools provide extension APIs rather than monolithic solutions
4. **Performance Focus**: C/Rust implementations gaining popularity for speed

## Technical Implementation Patterns

### Block and Inline Processors
- **Block processors**: Parse blocks of text separated by blank lines, excellent for code formatting, equation layouts, and tables
- **Inline processors**: Replace matched patterns with new element tree nodes, excellent for adding new inline tag syntax

### Custom Renderer Architecture
- **Redcarpet**: Custom renderers by inheriting from existing renderers or extending `Redcarpet::Render::Base`
- **Kramdown**: Define render method accepting markdown text with `Kramdown::Document` instance

### Extension Points
- **Preprocessors**: Alter source before parser (variable substitution, includes)
- **Syntax Extensions**: Add new markdown syntax elements
- **Post-processors**: Transform rendered output

## Real-World Examples

### Hugo Shortcodes
```markdown
{{< figure src="/images/example.jpg" title="Example" >}}
{{< highlight ruby >}}
puts "Hello World"
{{< /highlight >}}
```

### Jekyll Liquid Tags
```markdown
{% highlight ruby %}
puts "Hello World"
{% endhighlight %}

{% include footer.html %}
```

### MDX Components
```markdown
# Hello World

<CustomComponent prop="value">
This is **markdown** inside a component!
</CustomComponent>
```

### Custom Link Syntax Example
```markdown
See ~l:here!In Depth~ for more detail
```
Where `l:` indicates hyperlink, `!` separates payload from display text.

## Recommendations for Rails Integration

Given the goal of extending beyond ERB templates, consider:

1. **Building on Redcarpet**: Already in stack, excellent performance, custom renderer API
2. **Shortcode-style syntax**: Hugo/Jekyll approach is proven and familiar to users
3. **Block/Inline processor pattern**: Allows surgical insertion of custom syntax
4. **Component-based approach**: Like mdsvex but for Rails - embed Rails partials/components in markdown

## Success Patterns

Most successful markdown extensions either:
- Use familiar syntactic patterns (shortcodes, liquid tags)
- Integrate deeply with their host framework
- Provide clear extension APIs for custom functionality
- Focus on specific domains rather than general-purpose DSLs

## Performance Considerations

- **Redcarpet**: C-based renderers provide "several degrees of magnitude faster" performance than pure Ruby
- **Kramdown**: More flexible parsing but slower than Redcarpet
- **Preprocessing vs Runtime**: Consider whether extensions should process at build time or request time

## Conclusion

The landscape shows mature, well-maintained tools across multiple ecosystems. The most successful approaches integrate tightly with their host frameworks while providing familiar syntax patterns. For a Rails-based markdown DSL, building on Redcarpet with shortcode-style syntax would leverage existing performance and familiarity while allowing for powerful Rails integration.

---

*Research conducted October 29, 2024*