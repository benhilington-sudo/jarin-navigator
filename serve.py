import http.server
import urllib.request
import urllib.error
import os
import json

PORT = 8080
DIRECTORY = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'build', 'web')

RASP_BASE = 'https://api.rasp.yandex.net/v3.0'
OVERPASS_URL = 'https://overpass-api.de/api/interpreter'


class CORSHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    extensions_map = {
        '.ogg': 'audio/ogg',
        '.mp3': 'audio/mpeg',
        '.wav': 'audio/wav',
        '.js': 'application/javascript',
        '.json': 'application/json',
        '.wasm': 'application/wasm',
        '.html': 'text/html',
        '.css': 'text/css',
        '.png': 'image/png',
        '.jpg': 'image/jpeg',
        '.svg': 'image/svg+xml',
        '.ttf': 'font/ttf',
        '.otf': 'font/otf',
        '': 'application/octet-stream',
    }

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        self.send_header('Cache-Control', 'no-cache')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def do_GET(self):
        if self.path.startswith('/proxy/rasp/'):
            self._proxy_rasp()
        elif self.path.startswith('/proxy/overpass'):
            self._proxy_overpass_get()
        else:
            super().do_GET()

    def do_POST(self):
        if self.path.startswith('/proxy/overpass'):
            self._proxy_overpass_post()
        else:
            self.send_response(404)
            self.end_headers()

    def _proxy_rasp(self):
        try:
            rest = self.path[len('/proxy/rasp/'):]
            url = f'{RASP_BASE}/{rest}'
            req = urllib.request.Request(url)
            with urllib.request.urlopen(req, timeout=30) as resp:
                data = resp.read()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.end_headers()
                self.wfile.write(data)
        except urllib.error.HTTPError as e:
            body = e.read()
            self.send_response(e.code)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(body)
        except Exception as e:
            self.send_response(502)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({'error': str(e)}).encode())

    def _proxy_overpass_get(self):
        try:
            url = f'{OVERPASS_URL}{self.path[len("/proxy/overpass"):]}'
            req = urllib.request.Request(url, headers={
                'User-Agent': 'jarin_navigator/1.0',
                'Accept': 'application/json',
            })
            with urllib.request.urlopen(req, timeout=30) as resp:
                data = resp.read()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.end_headers()
                self.wfile.write(data)
        except urllib.error.HTTPError as e:
            body = e.read()
            self.send_response(e.code)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(body)
        except Exception as e:
            self.send_response(502)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({'error': str(e)}).encode())

    def _proxy_overpass_post(self):
        try:
            content_length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_length)
            req = urllib.request.Request(
                OVERPASS_URL,
                data=body,
                method='POST',
                headers={
                    'User-Agent': 'jarin_navigator/1.0',
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/json',
                },
            )
            with urllib.request.urlopen(req, timeout=30) as resp:
                data = resp.read()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.end_headers()
                self.wfile.write(data)
        except urllib.error.HTTPError as e:
            body = e.read()
            self.send_response(e.code)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(body)
        except Exception as e:
            self.send_response(502)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({'error': str(e)}).encode())

    def log_message(self, format, *args):
        pass


if __name__ == '__main__':
    server = http.server.HTTPServer(('0.0.0.0', PORT), CORSHandler)
    print(f'Server running on http://127.0.0.1:{PORT}')
    server.serve_forever()
