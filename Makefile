.PHONY: update-deps
update-deps:
	pip install --upgrade pip setuptools uv
	uv pip compile --upgrade --build-isolation --generate-hashes --output-file requirements/main.txt requirements/main.in
	uv pip compile --upgrade --build-isolation --generate-hashes --output-file requirements/dev.txt requirements/dev.in

.PHONY: init
init:
	uv pip install --editable .
	uv pip install --upgrade -r requirements/main.txt -r requirements/dev.txt
	rm -rf .tox
	uv pip install --upgrade tox pre-commit
	pre-commit install

.PHONY: update
update: update-deps init

.PHONY: run
run:
	tox -e run
