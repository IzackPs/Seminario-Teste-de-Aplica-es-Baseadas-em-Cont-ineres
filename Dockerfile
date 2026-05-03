# 1. Usando a imagem estável mais recente e de alta performance cravada na versão exata
FROM python:3.14.4-slim

# 2. Segurança DevSecOps: Usuário sem privilégios
RUN adduser --disabled-password --gecos '' apiapp

# 3. Configurando o diretório de trabalho
WORKDIR /app
RUN chown apiapp:apiapp /app

# Mudamos para o usuário seguro ANTES de instalar as dependências
USER apiapp

# 4. Boas Práticas: Ambiente virtual isolado para não corromper o SO (PEP 668)
ENV VIRTUAL_ENV=/app/venv
RUN python -m venv $VIRTUAL_ENV

# Colocamos o ambiente virtual no "PATH" para o terminal usá-lo por padrão
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 5. Copiamos os arquivos do projeto
COPY --chown=apiapp:apiapp . /app

# 6. Instalamos as dependências de forma limpa e segura
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

# 7. Servidor de Produção (Gunicorn)
CMD ["gunicorn", "-w", "1", "--threads", "2", "-b", "0.0.0.0:8080", "app:app"]