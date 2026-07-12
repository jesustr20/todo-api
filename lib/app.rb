# lib/app.rb
#
# Este archivo define nuestra aplicacion Rack. Rack es la interfaz minima
# entre un servidor HTTP (Puma, en nuestro caso) y el codigo Ruby que
# responde cada request. Rails, Sinatra, etc. estan construidos ENCIMA
# de Rack -- aqui lo usamos directo para entender que hace por debajo.
#
# Conceptos Ruby en este archivo:
# - require: carga codigo de otro archivo/gema
# - class + method call(env): toda app Rack es un objeto que responde a #call
# - hash: env (lo que manda el servidor) y la respuesta que devolvemos
# - simbolos vs strings: :ok es un simbolo (identificador), "GET" es un string (dato)
# - interpolacion de strings: "Hola #{nombre}"
# - convenciones de nombres: snake_case para metodos/variables, CamelCase para clases

require "json"

# Convencion Ruby: las clases van en CamelCase (mayuscula por palabra)
class App
  # Este es el METODO que Rack llama en cada request.
  # "env" es un hash gigante que Rack arma con toda la info del request:
  # metodo HTTP, path, headers, body, etc.
  def call(env)
    # env es un Hash. Las claves de Rack son strings en MAYUSCULAS por convencion
    # (asi lo definio la especificacion de Rack, no es capricho nuestro).
    metodo = env["REQUEST_METHOD"]   # ej: "GET"
    path   = env["PATH_INFO"]        # ej: "/health"

    # case/when es el "switch" de Ruby -- mas legible que una cadena de if/elsif
    case [metodo, path]
    when ["GET", "/health"]
      health_check
    else
      not_found
    end
  end

  private

  # Metodos privados: solo se pueden llamar desde dentro de la propia clase.
  # Buena practica: separar la logica de cada ruta en su propio metodo.
  def health_check
    # Construimos el cuerpo de la respuesta como un Hash con SIMBOLOS de clave.
    # :status es un simbolo (identificador interno, eficiente, inmutable).
    # "ok" es un string (es un DATO que viaja en la respuesta).
    body = { status: "ok", service: "todo-api", timestamp: Time.now.utc.iso8601 }

    json_response(200, body)
  end

  def not_found
    json_response(404, { error: "not_found" })
  end

  # Toda respuesta Rack tiene la misma forma: [status_code, headers, body_array]
  # Lo centralizamos aqui para no repetir esta estructura en cada metodo.
  def json_response(status, body_hash)
    headers = { "content-type" => "application/json" }
    # body.to_json convierte el Hash de Ruby a un string JSON (gema json, stdlib)
    [status, headers, [body_hash.to_json]]
  end
end