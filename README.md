# python_sandbox_testscala

Python-тесты для gRPC-сервиса из [scala-grpc-sandbox](https://github.com/forPetProject/scala-grpc-sandbox).

## Предварительные условия

1. Запущен Scala-сервер:
   ```bash
   cd ../scala-grpc-sandbox-main   # или клон scala-grpc-sandbox
   sbt run
   ```
   Сервер слушает `localhost:9091`.

2. Python 3.10+

## Установка

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# подтянуть контракт из Scala-репы
git submodule update --init --recursive

# сгенерировать Python-клиент из .proto
bash scripts/generate_proto.sh
```

## Запуск тестов

```bash
pytest -v
```

Переменные окружения (опционально):
- `GRPC_HOST` — по умолчанию `localhost`
- `GRPC_PORT` — по умолчанию `9091`

## Структура

```
proto/scala-grpc-sandbox/   # git submodule — источник .proto
scripts/generate_proto.sh   # генерация grpcio-кода
generated/                  # сгенерированный клиент (не в git)
tests/test_say_hello.py     # проверка SayHello
```
