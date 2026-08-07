import http.server
import json
import urllib.request
import urllib.parse
import sys

PROXY_PORT = 8081
YANDEX_API = 'https://api.rasp.yandex.net/v3.0/'
API_KEY = '9d065fef-169f-4ab6-88c9-bd9dc7e90cdf'

class ProxyHandler(http.server.BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.end_headers()

        parsed = urllib.parse.urlparse(self.path)
        params = urllib.parse.parse_qs(parsed.query)

        # Определяем эндпоинт
        endpoint = params.get('endpoint', ['stations'])[0]
        lang = params.get('lang', ['ru_RU'])[0]
        station = params.get('station', [''])[0]

        try:
            if endpoint == 'station_schedule' and station:
                url = f'{YANDEX_API}station_schedule/?apikey={API_KEY}&station={station}&lang={lang}&format=json'
            else:
                url = f'{YANDEX_API}stations/?apikey={API_KEY}&lang={lang}&format=json'

            req = urllib.request.Request(url)
            with urllib.request.urlopen(req, timeout=30) as resp:
                data = resp.read()
                self.wfile.write(data)
        except Exception as e:
            error = json.dumps({'error': str(e)}).encode('utf-8')
            self.wfile.write(error)

    def log_message(self, format, *args):
        pass  # Тихий режим

if __name__ == '__main__':
    server = http.server.HTTPServer(('127.0.0.1', PROXY_PORT), ProxyHandler)
    print(f'Proxy running on http://127.0.0.1:{PROXY_PORT}')
    server.serve_forever()
