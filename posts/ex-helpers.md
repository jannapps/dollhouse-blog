---
layout: two-column
title: Helper Functions Demo
sidebar:
  - posts-matching(^ex-, Example Posts)
  - recent-posts(3)
  - post-list
---

# Helper Functions Demo

This page demonstrates the new **framework-specific helper functions** that make widget creation incredibly simple!

## What You'll See

In the sidebar, you'll see **three builtin widgets** that showcase the new function call syntax:

1. **Example Posts** - Uses `posts-matching(^ex-, Example Posts)` to show posts starting with "ex-"
2. **Top 3 Posts** - Uses `recent-posts(3)` to show just the first 3 posts
3. **All Posts** - Uses `post-list` to show every post with dynamic indicators

## The Magic

Instead of writing complex ERB loops or widget files, users can now call builtin widgets directly from YAML:

### Before (Complex Widget File):
```erb
---
title: All Posts
---
# All Posts
<% get_all_posts.each do |post_name, post_info| %>
- [<%= post_info[:title] %>](/<%= post_name %>)<% if post_info[:dynamic] %> ⚡<% end %>
<% end %>
```

### After (Simple YAML Call):
```yaml
sidebar:
  - post-list
```

## Available Builtin Widgets

| Widget Call | Description | Example Usage |
|-------------|-------------|---------------|
| `post-list` | All posts with titles and dynamic indicators | Shows every post |
| `posts-matching(pattern, title)` | Posts matching a regex pattern | `posts-matching(^ex-, Example Posts)` |
| `recent-posts(n)` | First N posts from the sorted list | `recent-posts(3)` |

## Framework Philosophy

These helpers embody the "really really simple but powerful" philosophy:

- ✅ **Simple**: One-line function calls instead of complex loops
- ✅ **Powerful**: Regex patterns, custom counts, dynamic detection
- ✅ **Consistent**: All helpers return clean markdown for processing
- ✅ **Extensible**: Easy to add more helpers as needs arise

## Builtin vs User-Defined Widgets

**Builtin Widgets** (called directly from YAML):
- `post-list`, `recent-posts(5)`, `posts-matching(^ex-, Example Posts)`
- Framework-provided, common use cases
- No separate files needed

**User-Defined Widgets** (custom `.md` files):  
- `site-info`, `test-widget`, custom content
- For specialized content and styling
- Full markdown + YAML frontmatter support

This architecture makes the common cases trivial while keeping custom cases powerful!