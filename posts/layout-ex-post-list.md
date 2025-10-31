---
layout: two-column
title: Post List Widget Example
sidebar: post-list
---

# Post List Widget Example

This page demonstrates the new **post-list** widget, which automatically displays links to all posts in the directory.

## Features

The post-list widget:

- ✅ **Automatically discovers** all `.md` and `.md.erb` files
- ✅ **Extracts titles** from YAML frontmatter when available
- ✅ **Shows file type** with ERB badges for dynamic content
- ✅ **Sorts alphabetically** by title for consistent ordering
- ✅ **Uses clean URLs** that match the routing system

## Dynamic Content Detection

Files ending in `.md.erb` get a special "ERB" badge to indicate they contain dynamic content.

## Implementation

The widget uses the same file discovery logic as the routing system, ensuring consistency between what's displayed and what's accessible.

Check out the sidebar to see all available posts! →