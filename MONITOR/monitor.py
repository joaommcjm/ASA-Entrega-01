import requests
import socket
import time
import os

# Configurações
DNS_NAME = "web.asa.br"  # Nome a ser resolvido via DNS
WEB_URL = f"http://{DNS_NAME}"  # URL do Web Server
CHECK_INTERVAL = 5  # Verificação a cada 5 segundos

def log(message):
    """Formata logs com timestamp."""
    print(f"[{time.strftime('%H:%M:%S')}] {message}")

def check_dns():
    """Testa se o DNS resolve o nome corretamente."""
    try:
        output = os.popen(f"nslookup {DNS_NAME}").read()
        log(f"DNS nslookup:\n{output}")
        ip = socket.gethostbyname(DNS_NAME)
        log(f"DNS OK: {DNS_NAME} → {ip}")
        return True
    except Exception as e:
        log(f"DNS FALHOU: {str(e)}")
        return False

def check_web():
    """Testa se o Web Server responde."""
    try:
        response = requests.get(WEB_URL, timeout=3)
        log(f"WEB OK: HTTP {response.status_code}")
        return True
    except Exception as e:
        log(f"WEB FALHOU: {str(e)}")
        return False

if __name__ == "__main__":
    log("Monitor iniciado (Ctrl+C para parar)...")
    try:
        while True:
            dns_ok = check_dns()
            web_ok = check_web()
            
            if not all([dns_ok, web_ok]):
                log("ALERTA: Serviço crítico offline!")
            
            time.sleep(CHECK_INTERVAL)
    except KeyboardInterrupt:
        log("Monitor encerrado.")