python = venv/bin/python
pip = venv/bin/pip
IMAGE_NAME = my_fastapi
BUILDER = paketobuildpacks/builder:base

.PHONY: setup run mlflow test clean remove build-image run-image

setup:
	python3 -m venv venv
	$(python) -m pip install --upgrade pip
	$(pip) install -r requirements.txt

run:
	$(python) main.py

mlflow:
	venv/bin/mlflow ui

test:
	$(python) -m pytest

# --- Buildpacks & Container Commands ---

build-image:
	pack build $(IMAGE_NAME) --builder $(BUILDER) --clear-cache

run-image:
	docker run -p 80:80 $(IMAGE_NAME)

clean:
	rm -rf steps/__pycache__
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf tests/__pycache__

remove:
	rm -rf venv
	rm -rf mlruns
