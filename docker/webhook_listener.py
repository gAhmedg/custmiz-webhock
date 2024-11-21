import os
import subprocess
from http.server import BaseHTTPRequestHandler, HTTPServer

class WebhookHandler(BaseHTTPRequestHandler):
    # Handle GET requests
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"Server is running!")

    # Handle POST requests
    def do_POST(self):
        self.send_response(200)
        self.end_headers()
        
        # Get the absolute path of the script
        script_dir = os.path.dirname(os.path.abspath(__file__))
        script_path = os.path.join(script_dir, "update_repo.sh")
        
        # Run the update script
        subprocess.run([script_path], check=True)
        print("Repository updated successfully!")

# Set up and start the HTTP server
server_address = ('0.0.0.0', 8000)
httpd = HTTPServer(server_address, WebhookHandler)
print("Webhook listener running on port 8000...")
httpd.serve_forever()

