---
layout: two-column
title: Helper Functions Demo
sidebar:
  - example-posts
  - top-posts
  - post-list
---

# Helper Functions Demo

This page demonstrates the new **framework-specific helper functions** that make widget creation incredibly simple!

## What You'll See

In the sidebar, you'll see **three widgets** that showcase different helper functions:

1. **Example Posts** - Uses `posts_matching(/^ex-/)` to show only posts starting with "ex-"
2. **Top 3 Posts** - Uses `recent_posts(3)` to show just the first 3 posts
3. **All Posts** - Uses `post_list()` to show every post with dynamic indicators

## The Magic

Instead of writing complex ERB loops, users can now use simple helper functions:

### Before (Complex ERB):
```erb
<% get_all_posts.each do |post_name, post_info| %>
- [<%= post_info[:title] %>](/<%= post_name %>)<% if post_info[:dynamic] %> ⚡<% end %>
<% end %>
```

### After (Simple Helper):
```erb
<%= post_list %>
```

## Available Helper Functions

| Function | Description | Example |
|----------|-------------|---------|
| `<%= post_list %>` | All posts with titles and dynamic indicators | Shows every post |
| `<%= posts_matching(/pattern/) %>` | Posts matching a regex pattern | `posts_matching(/^ex-/)` |
| `<%= recent_posts(5) %>` | First N posts from the sorted list | `recent_posts(3)` |

## Framework Philosophy

These helpers embody the "really really simple but powerful" philosophy:

- ✅ **Simple**: One-line function calls instead of complex loops
- ✅ **Powerful**: Regex patterns, custom counts, dynamic detection
- ✅ **Consistent**: All helpers return clean markdown for processing
- ✅ **Extensible**: Easy to add more helpers as needs arise

This makes widget creation accessible to **everyone**, not just developers familiar with ERB and Rails patterns!