"""
Servidor local de desarrollo para el chatbot del Sistema Solar.

Uso: python -m chatbot.servidor
"""

import os
from socketserver import ThreadingMixIn
from wsgiref.simple_server import WSGIServer, make_server

from chatbot.wsgi import application


class ThreadedWSGIServer(ThreadingMixIn, WSGIServer):
    daemon_threads = True


def main():
    host = "127.0.0.1"
    port = int(os.environ.get("PORT", 8000))
    server = make_server(host, port, application, ThreadedWSGIServer)
    print(f"Servidor iniciado en http://{host}:{port}")
    print("Presiona Ctrl+C para detener.")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServidor detenido.")


if __name__ == "__main__":
    main()
