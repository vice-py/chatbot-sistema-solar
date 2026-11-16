"""
Aplicacion WSGI del chatbot del Sistema Solar.

Sirve la interfaz web y expone la API REST:
  GET  /api/estado  -> disponibilidad de motores
  POST /api/chat    -> enviar pregunta al chatbot
"""

import json
import os

from chatbot import servicio

_BASE = os.path.dirname(os.path.abspath(__file__))
_WEB = os.path.join(_BASE, "web")

_TIPOS_MIME = {
    ".html": "text/html; charset=utf-8",
    ".js": "application/javascript; charset=utf-8",
    ".css": "text/css; charset=utf-8",
}

_ARCHIVOS_PERMITIDOS = {
    "/": "index.html",
    "/index.html": "index.html",
    "/app.js": "app.js",
    "/estilo.css": "estilo.css",
}

_MAX_BODY = 4096


def application(environ, start_response):
    """Punto de entrada WSGI."""
    path = environ.get("PATH_INFO", "/")
    method = environ.get("REQUEST_METHOD", "GET")

    headers_seguridad = [
        ("X-Content-Type-Options", "nosniff"),
        ("Cache-Control", "no-store"),
    ]

    # --- Archivos estaticos ---
    if method == "GET" and path in _ARCHIVOS_PERMITIDOS:
        nombre = _ARCHIVOS_PERMITIDOS[path]
        ruta = os.path.join(_WEB, nombre)
        if os.path.isfile(ruta):
            ext = os.path.splitext(nombre)[1]
            mime = _TIPOS_MIME.get(ext, "application/octet-stream")
            with open(ruta, "rb") as f:
                contenido = f.read()
            start_response("200 OK", [("Content-Type", mime)] + headers_seguridad)
            return [contenido]

    # --- API: estado ---
    if method == "GET" and path == "/api/estado":
        estado = servicio.estado()
        body = json.dumps(estado).encode("utf-8")
        start_response("200 OK", [
            ("Content-Type", "application/json; charset=utf-8"),
        ] + headers_seguridad)
        return [body]

    # --- API: chat ---
    if method == "POST" and path == "/api/chat":
        try:
            content_length = int(environ.get("CONTENT_LENGTH", 0))
        except ValueError:
            content_length = 0

        if content_length > _MAX_BODY:
            start_response("413 Payload Too Large", headers_seguridad)
            return [b'{"error": "Mensaje demasiado largo"}']

        body_raw = environ["wsgi.input"].read(content_length)
        try:
            datos = json.loads(body_raw.decode("utf-8"))
        except (json.JSONDecodeError, UnicodeDecodeError):
            start_response("400 Bad Request", headers_seguridad)
            return [b'{"error": "JSON invalido"}']

        pregunta = datos.get("pregunta", "").strip()
        modo = datos.get("modo", "prolog").strip().lower()

        if not pregunta:
            start_response("400 Bad Request", headers_seguridad)
            return [b'{"error": "Pregunta vacia"}']

        if len(pregunta) > 600:
            start_response("400 Bad Request", headers_seguridad)
            return [b'{"error": "Pregunta demasiado larga (max 600 caracteres)"}']

        if modo not in ("prolog", "llm"):
            modo = "prolog"

        resultado = servicio.responder(pregunta, modo)
        body = json.dumps(resultado, ensure_ascii=False).encode("utf-8")
        start_response("200 OK", [
            ("Content-Type", "application/json; charset=utf-8"),
        ] + headers_seguridad)
        return [body]

    # --- 404 ---
    start_response("404 Not Found", headers_seguridad)
    return [b'{"error": "No encontrado"}']
