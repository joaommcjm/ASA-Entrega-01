FROM python:3.9-alpine

WORKDIR /app
COPY monitor.py .

# Instala dependências (requests para HTTP + bind-tools para nslookup)
RUN apk add --no-cache bind-tools && \
    pip install --no-cache-dir requests

CMD ["python", "monitor.py"]