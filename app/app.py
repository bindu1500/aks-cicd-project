"""Sample web API deployed to AKS through Azure DevOps CI/CD."""
import os
import socket

from flask import Flask, jsonify

app = Flask(__name__)

APP_VERSION = os.getenv("APP_VERSION", "local")
ENVIRONMENT = os.getenv("ENVIRONMENT", "local")


@app.get("/")
def index():
    return jsonify(
        message="Hello from AKS - v2!",
        version=APP_VERSION,
        environment=ENVIRONMENT,
        pod=socket.gethostname(),
    )


@app.get("/health")
def health():
    """Liveness/readiness probe endpoint used by Kubernetes."""
    return jsonify(status="healthy"), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
