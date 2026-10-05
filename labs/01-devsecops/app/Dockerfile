FROM python:3.12-slim
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --only-upgrade libpcre2-8-0 \
 && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
 && useradd --system --no-create-home --uid 10001 appuser
COPY app.py .
USER appuser
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD ["python", "-c", "import urllib.request as u; u.urlopen('http://127.0.0.1:8080/', timeout=2)"]
CMD ["python", "app.py"]
