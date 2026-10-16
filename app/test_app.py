from app import app


def client():
    app.config["TESTING"] = True
    return app.test_client()


def test_index_returns_message():
    resp = client().get("/")
    assert resp.status_code == 200
    body = resp.get_json()
    assert body["message"] == "Hello from AKS - v2!"
    assert "version" in body and "environment" in body


def test_health_endpoint():
    resp = client().get("/health")
    assert resp.status_code == 200
    assert resp.get_json()["status"] == "healthy"


def test_unknown_route_returns_404():
    assert client().get("/does-not-exist").status_code == 404
