import os
import sys

import grpc
import pytest

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
GENERATED = os.path.join(ROOT, "generated")
sys.path.insert(0, GENERATED)

from hello.v1 import service_pb2, service_pb2_grpc  # noqa: E402


GRPC_HOST = os.environ.get("GRPC_HOST", "localhost")
GRPC_PORT = os.environ.get("GRPC_PORT", "9091")


@pytest.fixture
def stub():
    channel = grpc.insecure_channel(f"{GRPC_HOST}:{GRPC_PORT}")
    yield service_pb2_grpc.HelloServiceStub(channel)
    channel.close()


def test_say_hello(stub):
    response = stub.SayHello(service_pb2.SayHelloRequest(name="World"))
    assert response.message == "Hello, World!"
