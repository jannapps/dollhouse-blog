# Dollhouse Blog

A simple, fast, and maintainable blog system built with Ruby on Rails that uses markdown files for content storage. Perfect for developers who want to write in markdown while having the power of Rails for dynamic features.

## ✨ Features

### 📝 Content Management
- **Markdown-based content** - Write content in simple, readable markdown files
- **Dynamic markdown content** - Use ERB syntax within `.md.erb` files for dynamic content
- **Internal linking** - Seamless navigation between markdown pages
- **No database required for content** - All content stored as files in the filesystem

### 🔧 Dynamic Content Capabilities
- **Real-time data** - Current date, time, Rails version, environment info
- **ERB integration** - Full access to Rails helpers, variables, and environment
- **Conditional content** - Show different content based on environment or conditions
- **Dynamic loops** - Generate lists and repeated content programmatically
- **Rails helpers** - Access to all Rails view helpers within markdown

### 🎨 Design & User Experience
- **Modern web design** - Responsive design with beautiful typography
- **Clean URLs** - Simple routing like `/page-name` for markdown files
- **Fast loading** - File-based content with efficient caching
- **Mobile-friendly** - Responsive design that works on all devices

### 🔒 Security & Quality
- **Security-first design** - Whitelist-based file access prevents path traversal attacks
- **Zero security warnings** - Passes Brakeman security scanning
- **Input validation** - Strict validation of all user inputs
- **CI/CD pipeline** - Automated security scanning, linting, and testing

### ⚡ Performance & Development
- **Fast development** - Hot reloading in development mode
- **Reproducible environment** - NixOS shell.nix for consistent development setup
- **Comprehensive testing** - Full CI pipeline with security, style, and unit tests
- **Git workflow** - Feature branches with squash merges for clean history

## 🛠 Technical Stack

- **Backend**: Ruby on Rails 8.1.1
- **Ruby Version**: 3.2.9
- **Markdown Processing**: Redcarpet gem
- **Template Engine**: ERB for dynamic content
- **Development Environment**: NixOS with shell.nix
- **Web Server**: Puma (port 9955)
- **Database**: SQLite (for Rails features, not content)

## 🚀 Getting Started

### Prerequisites
- NixOS or Nix package manager
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/jannapps/dollhouse-blog.git
   cd dollhouse-blog
   ```

2. **Enter development environment**
   ```bash
   nix-shell
   ```

3. **Install dependencies**
   ```bash
   bundle install
   ```

4. **Start the server**
   ```bash
   bin/rails server --port=9955
   ```

5. **Visit your blog**
   Open http://localhost:9955 in your browser

## 📖 Creating Content

### Static Markdown Pages
Create `.md` files in the `posts/` directory:

```markdown
# My New Page

This is a simple markdown page with **bold text** and [links](/).

## Features
- Lists work great
- So do code blocks
```

### Dynamic Markdown Pages
Create `.md.erb` files for dynamic content:

```markdown
# Welcome Page

Today is: <%= Date.current.strftime("%A, %B %d, %Y") %>

<% if Rails.env.development? %>
## Development Mode
Debug features are available!
<% end %>

## Random Numbers
<% 3.times do |i| %>
<%= i + 1 %>. Lucky number: **<%= rand(1..100) %>**
<% end %>
```

### URL Structure
Files are automatically accessible via clean URLs:
- `posts/about.md` → `/about`
- `posts/contact.md.erb` → `/contact`
- `posts/blog-post.md` → `/blog-post`

## 🔧 Development Workflow

### Local CI Testing
Always run the complete CI suite before pushing:

```bash
# Complete CI pipeline
nix-shell --run "bin/brakeman" && \
nix-shell --run "bin/bundler-audit check --update" && \
nix-shell --run "bin/rubocop -a" && \
nix-shell --run "bin/rails test"
```

### Git Workflow
1. Create feature branches for all changes
2. Run CI locally before committing
3. Use squash merges to main branch
4. Keep commit history clean and descriptive

### Security Guidelines
- Never use user parameters directly in file operations
- Use whitelist-based file access with pre-approved mappings
- Implement strict input validation (alphanumeric, dash, underscore only)
- Always validate file paths are within expected directories

## 📁 Project Structure

```
dollhouse-blog/
├── app/
│   ├── controllers/
│   │   ├── home_controller.rb      # Homepage controller
│   │   └── pages_controller.rb     # Dynamic markdown page handler
│   └── views/
│       ├── home/
│       │   └── index.html.erb      # Homepage template
│       └── pages/
│           └── show.html.erb       # Markdown page template
├── posts/                          # Markdown content directory
│   ├── home.md                     # Homepage content
│   ├── test.md                     # Example static page
│   └── dynamic-example.md.erb      # Example dynamic page
├── config/
│   └── routes.rb                   # Dynamic routing configuration
├── shell.nix                       # NixOS development environment
├── CLAUDE.md                       # Development notes and CI process
└── README.md                       # This file
```

## 🎨 Layout System

The blog supports a flexible layout system using YAML frontmatter to specify different page layouts and widgets.

### Available Layouts
- ✅ **single-column** - Clean single column layout for focused content
- ✅ **two-column** - Main content with sidebar for widgets

### Planned Layouts
- ⭕ **three-column** - Main content with dual sidebars (nav + widgets)
- ⭕ **card-grid** - Grid layout for post listings, galleries, or portfolios
- ⭕ **masonry** - Pinterest-style staggered grid for mixed content sizes
- ⭕ **full-width** - Edge-to-edge content without container constraints
- ⭕ **narrow** - Extra-narrow layout for long-form reading
- ⭕ **split-screen** - Half content, half media layout
- ⭕ **hero-banner** - Large header section with content below
- ⭕ **timeline** - Chronological content with date markers
- ⭕ **comparison** - Side-by-side content blocks
- ⭕ **landing-page** - Multi-section layout with different backgrounds
- ⭕ **mobile-first-stack** - Responsive stacking layout
- ⭕ **sidebar-overlay** - Sidebar becomes slide-out drawer on mobile

### Using Layouts
Add YAML frontmatter to your markdown files:

```yaml
---
layout: two-column
title: My Page Title
sidebar: recent-posts
---

# My Content

This content will be displayed in a two-column layout with a sidebar widget.
```

## 🔍 Example Pages

- **Homepage**: `/` - Static markdown content with feature overview
- **Test Page**: `/test` - Simple static markdown example
- **Dynamic Example**: `/dynamic-example` - Comprehensive ERB features demo
- **Layout Example**: `/layout-example` - Two-column layout with sidebar widget

## 🧪 CI/CD Pipeline

The project includes comprehensive automated testing:

- **Brakeman**: Security vulnerability scanning
- **bundler-audit**: Dependency security checking
- **RuboCop**: Code style and linting
- **Rails Tests**: Application testing

All checks must pass before merging to main branch.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Run CI locally to ensure all checks pass
4. Commit your changes with descriptive messages
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request with squash merge

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🔗 Links

- **Repository**: https://github.com/jannapps/dollhouse-blog
- **Live Demo**: http://localhost:9955 (after running locally)

---

*Built with ❤️ using Ruby on Rails and markdown*
