"""API de supervision de l'Usine HubLabs (charge utile du lab 01)."""
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

import yaml

CONFIG = yaml.safe_load("site: lyo\nusine: HubLabs\n")


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        corps = json.dumps({"statut": "ok", **CONFIG}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(corps)


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
