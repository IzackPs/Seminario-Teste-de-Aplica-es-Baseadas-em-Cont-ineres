Repositório destinado ao seminário de testes de aplicações conteinerizadas.

🛠️ Stack Tecnológica
Linguagem: Python 3.14.4 (Flask 3.1.3)

Servidor WSGI: Gunicorn 25.3.0

Orquestração: K3s (Kubernetes)

Testes de Carga: Grafana k6

Observabilidade: Grafana + Dashboard 15757

Segurança: Aqua Security Trivy

🚀 Arquitetura e Limites
HPA: Escalonamento horizontal (1 a 20 réplicas) baseado em 70% de uso de CPU.

Resources: Requests de 30m e Limits de 60m por Pod.

Probes: * Readiness: Verifica /health a cada 2s (tolerância de 3 falhas).

Liveness: Verifica /health a cada 5s (tolerância de 5 falhas).

📊 Principais Resultados
Cenário Estável (600 VUs): 0% de falha, latência média de 240ms e throughput de ~249 req/s.

Cenário de Saturação (750 VUs): Identificação de Provisioning Lag com 2,12% de falhas de conexão recusada.

Resiliência: Recuperação automática (Self-healing) após falha induzida via /crash em menos de 30 segundos.

🔒 Segurança (DevSecOps)
A imagem Docker foi construída seguindo o princípio do menor privilégio:

Imagem de base slim (Debian 13.4).

Execução via usuário api-app (non-root).

Varredura de vulnerabilidades CVE via Trivy integrada ao workflow.
