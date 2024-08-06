# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# CSV / XLS Documents
Mime::Type.register "application/xls", :xls

Mime::Type.register "font/otf", :otf, [], %w(otf)
Mime::Type.register "font/ttf", :ttf, [], %w(ttf)
Mime::Type.register "font/woff", :woff, [], %w(woff)
Mime::Type.register "font/woff2", :woff2, [], %w(woff2)
