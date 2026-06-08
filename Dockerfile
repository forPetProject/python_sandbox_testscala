FROM python:3.13-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends bash \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN bash scripts/generate_proto.sh

RUN chmod +x scripts/wait_for_server.sh scripts/docker-entrypoint.sh

ENTRYPOINT ["scripts/docker-entrypoint.sh"]
CMD ["pytest", "-v"]
