---
layout: two-column-content-with-sidebar
title: Two-Column Content with Sidebar
sidebar: post-list
---

---section: right---

# Right Column: Implementation Details

This is the **right column** of our three-column layout! This page demonstrates how to have **two columns of actual content** plus a **sidebar widget**.

## Technical Architecture

The layout system now supports:

1. **Left content column** - Primary article content
2. **Right content column** - Supporting details, code examples, or related info  
3. **Sidebar widget** - Dynamic navigation or metadata

### Layout Configuration

```yaml
---
layout: two-column-content-with-sidebar
sidebar: post-list
---
```

This creates a true three-column experience that's responsive and clean.

## Why This Matters

Previously, "two-column with sidebar" was misleading - it was really just main content + sidebar. Now we have:

- ✅ **Two content columns** for rich article layouts
- ✅ **Plus sidebar** for navigation and metadata
- ✅ **Responsive design** that collapses gracefully
- ✅ **Semantic sections** that can be written in any order

---section: left---

# Left Column: Main Content

Welcome to the **true two-column content with sidebar** layout! This demonstrates what the name suggests - two actual content columns plus a sidebar.

## The Power of Three

Unlike the previous version which was really just "main content + sidebar", this layout gives you three distinct areas:

### Content Column 1 (This Column)
Perfect for your main article content, introduction, or primary narrative.

### Content Column 2 (Right Column) 
Great for:
- Technical implementation details
- Code examples and explanations
- Supporting arguments
- Supplementary information

### Sidebar (Far Right)
The sidebar remains dedicated to:
- Navigation elements
- Post lists
- Metadata
- Related links

## Flexible Content Organization

Notice how I can write the right column content first in the file (above), but it still renders in the correct position. This flexibility lets you organize your writing workflow however feels natural.