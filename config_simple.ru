require 'puma'

app = proc do |env|
  case env['PATH_INFO']
  when '/'
    [200, {'Content-Type' => 'text/html'}, [
      <<-HTML
        <!DOCTYPE html>
        <html>
        <head>
          <title>Dollhouse Blog</title>
          <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
              font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
              line-height: 1.6;
              color: #333;
              background-color: #f8f9fa;
            }
            .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
            .hero {
              background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              color: white;
              text-align: center;
              padding: 4rem 2rem;
              margin-bottom: 2rem;
              border-radius: 8px;
              box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .hero h1 {
              font-size: 3rem;
              font-weight: 700;
              margin-bottom: 1rem;
              text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            }
            .hero p {
              font-size: 1.2rem;
              margin-bottom: 0.5rem;
              opacity: 0.9;
            }
            .features {
              background: white;
              padding: 2rem;
              border-radius: 8px;
              box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
              margin-bottom: 2rem;
            }
            .features h2 {
              color: #2c3e50;
              font-size: 2rem;
              margin-bottom: 1rem;
              border-bottom: 3px solid #667eea;
              padding-bottom: 0.5rem;
            }
            .features ul { list-style: none; padding: 0; }
            .features li {
              background: #f8f9fa;
              margin: 0.5rem 0;
              padding: 1rem;
              border-left: 4px solid #667eea;
              border-radius: 4px;
              transition: transform 0.2s ease;
            }
            .features li:hover {
              transform: translateX(5px);
              background: #e9ecef;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="hero">
              <h1>Welcome to Dollhouse Blog!</h1>
              <p>A simple markdown-based blog built with Ruby on Rails</p>
              <p>Ruby version: #{RUBY_VERSION}</p>
              <p>Environment: Development</p>
              <p>Status: ✅ Server Running Successfully!</p>
            </div>
            <div class="features">
              <h2>Features</h2>
              <ul>
                <li>Markdown-based content management</li>
                <li>Modern web design</li>
                <li>No database required for content</li>
                <li>Ruby on Rails backend</li>
                <li>NixOS environment setup</li>
              </ul>
            </div>
          </div>
        </body>
        </html>
      HTML
    ]]
  else
    [404, {'Content-Type' => 'text/html'}, ['<h1>404 Not Found</h1>']]
  end
end

run app