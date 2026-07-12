source "https://rubygems.org"

ruby "3.3.11"

# Servidor HTTP minimalista sobre el que construimos a mano
gem "rack", "~> 3.0"

# Servidor de aplicacion para correr Rack en desarrollo
gem "puma", "~> 6.0"

group :development, :test do
  # RuboCop llega con contenido real en el issue 16, pero lo dejamos listo
  gem "rubocop", "~> 1.60", require: false
end
gem "rackup", "~> 2.3"
