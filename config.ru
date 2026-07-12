# config.ru
#
# Este es el archivo que Rack busca por convencion para saber que app correr.
# "ru" = "rackup". require_relative carga un archivo por RUTA RELATIVA a este.

require_relative "lib/app"

# "run" le dice a Rack: instancia esta clase y usala para responder cada request.
run App.new
