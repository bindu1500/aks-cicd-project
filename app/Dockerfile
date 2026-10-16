# ---- Build stage: install dependencies ----
FROM python:3.12-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---- Runtime stage: small, non-root image ----
FROM python:3.12-slim
WORKDIR /app
COPY --from=build /install /usr/local
COPY app.py .

RUN useradd --uid 10001 --no-create-home appuser
USER 10001

ENV PYTHONUNBUFFERED=1
EXPOSE 8080
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "app:app"]
