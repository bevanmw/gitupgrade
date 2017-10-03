VENV=venv
SRC=src
DIST=dist

all: init lint test

init: install

install:
	virtualenv -p python3 $(VENV) \
	&& . $(VENV)/bin/activate \
	&& pip install -r requirements.txt

lint:
	. $(VENV)/bin/activate && flake8 $(SRC)/grpcutil

test:
	. $(VENV)/bin/activate && PYTHONPATH="$(SRC)" pytest -v

dist:
	. $(VENV)/bin/activate && python setup.py sdist

upload:
	twine upload dist/*

clean:
	rm -rf $(DIST) $(VENV) \
	; find . -type f -name "*.py[co]" -delete \
	-or -type d -name "__pycache__" -delete \
	-or -type d -name ".cache" -delete
