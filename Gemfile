source :gemcutter

gem 'rails', '2.3.5'

# ActiveRecord requires a database adapter.
gem "postgres"

# An alternative form builder
gem "formtastic"

# Basic authentication
gem "clearance"

# GIS functionality
gem "GeoRuby"
gem "spatial_adapter"
gem "ym4r"

# Geocoding
gem "geokit"

# Place hierarchy
gem "ancestry"

# Required for rails_xss plugin, which turns on XSS protection by default;
# remove this (and the plugin) for Rails 3
gem "erubis"

group :development do
   # Get TextMate links in development views
   gem "rails-footnotes"
end

## Bundle gems used only in certain environments:
group :test, :cucumber do
   gem "cucumber-rails"
   gem "database_cleaner"
   gem "webrat"
   gem "rspec"
   gem "rspec-rails"
   gem "shoulda"
   gem "factory_girl"
end