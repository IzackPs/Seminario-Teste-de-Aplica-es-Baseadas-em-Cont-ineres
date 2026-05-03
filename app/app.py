from flask import Flask, Response

app = Flask(__name__)
is_healthy = True # Variavel de controle de saude (sem acento para evitar erro de encoding)

@app.route('/')
def hello():
    return "API rodando perfeitamente! Preparada para o caos."

# O Kubernetes vai chamar essa rota a cada 5 segundos
@app.route('/health')
def health_check():
    if is_healthy:
        return Response("OK", status=200)
    else:
        return Response("FALHA CRITICA", status=500)

# Rota do Caos: Onde voce vai "puxar a tomada" ao vivo
@app.route('/crash')
def crash():
    global is_healthy
    is_healthy = False
    return "Bug fatal acionado! A API vai parar de responder ao Health Check."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
