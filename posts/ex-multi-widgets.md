---
layout: two-column
title: Multiple Widgets Demo
sidebar:
  - recent-posts
  - site-info
  - test-widget
---

# Multiple Widgets Demo

This page demonstrates the new **multiple sidebar widgets** feature! 

## What You'll See

In the sidebar (right column), you should see **three different widgets** stacked vertically:

1. **Recent Posts** - Navigation links to recent content
2. **Site Info** - Information about the blog and tech stack  
3. **Test Widget** - Debug widget to verify the system works

## How It Works

In the YAML frontmatter, instead of a single widget:

```yaml
sidebar: post-list
```

You can now specify an **array of widgets**:

```yaml
sidebar:
  - recent-posts
  - site-info  
  - test-widget
```

## Features

- ✅ **Backward Compatible** - Single widgets still work
- ✅ **Multiple Widgets** - Arrays of widgets render in sequence
- ✅ **Consistent Styling** - All widgets use the same beautiful styling
- ✅ **Error Handling** - Missing widgets show helpful error messages
- ✅ **Flexible Ordering** - Widgets appear in the order specified

This makes sidebars much more informative and useful!