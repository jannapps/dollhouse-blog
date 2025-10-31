---
layout: two-column
title: Two-Column Layout with Sidebar
sidebar: recent-posts
---

# Two-Column Layout with Sidebar

This page demonstrates the new layout system with ultra-clean markdown syntax.

## How It Works

Content creators just write normal markdown with minimal frontmatter:

```yaml
---
layout: two-column
sidebar: recent-posts
---
```

That's it! All the complexity is handled by the renderer.

## Features

- **Clean Content**: Writers focus on content, not layout
- **Flexible Layouts**: Grid-based, responsive design
- **Reusable Widgets**: Drop in components anywhere
- **Mobile Responsive**: Automatically adapts to screen size

## The Beauty of Simplicity

Notice how this content file contains no layout code - just pure, readable markdown. The two-column layout and sidebar widget are handled entirely by the rendering system.

This approach makes content **human-readable** and **human-writable** while keeping all the complexity in the renderer where it belongs.

## Technical Implementation

The system uses:
- YAML frontmatter for configuration
- Rails layouts for structure
- Rails partials for widgets
- CSS Grid for responsive design

But content creators never need to know any of that!