# python_sandbox_testscala

Python-тесты для gRPC-сервиса из [scala-grpc-sandbox](https://github.com/forPetProject/scala-grpc-sandbox).

## Docker (рекомендуется)

Поднимает Scala-сервер и прогоняет pytest одной командой:

```bash
git clone --recurse-submodules https://github.com/forPetProject/python_sandbox_testscala.git
cd python_sandbox_testscala
docker compose up --build
```

Что происходит:
1. **`scala-server`** — контейнер со Scala gRPC-сервером на `:9091`
2. **`python-tests`** — ждёт сервер, вызывает `SayHello`, проверяет ответ

Только сервер (для отладки с хоста):

```bash
docker compose up --build scala-server
# grpcurl / pytest с GRPC_HOST=localhost
```

## Локальный запуск

### Предварительные условия

1. Запущен Scala-сервер:
   ```bash
   cd ../scala-grpc-sandbox-main   # или клон scala-grpc-sandbox
   sbt run
   ```
   Сервер слушает `localhost:9091`.

2. Python 3.10+

### Установка

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# подтянуть контракт из Scala-репы
git submodule update --init --recursive

# сгенерировать Python-клиент из .proto
bash scripts/generate_proto.sh
```

### Запуск тестов

```bash
pytest -v
```

Переменные окружения (опционально):
- `GRPC_HOST` — по умолчанию `localhost` (в Docker: `scala-server`)
- `GRPC_PORT` — по умолчанию `9091`

## Структура

```
proto/scala-grpc-sandbox/   # git submodule — источник .proto + Dockerfile сервера
docker-compose.yml          # orchestration: server + tests
scripts/generate_proto.sh   # генерация grpcio-кода
scripts/wait_for_server.sh  # ожидание готовности сервера в Docker
generated/                  # сгенерированный клиент (не в git)
tests/test_say_hello.py     # проверка SayHello
```
