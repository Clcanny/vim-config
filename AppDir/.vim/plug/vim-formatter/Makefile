# Refer to davidhalter/jedi-vim.
BUILD_VIRTUAL_ENV:=build/venv

$(dir $(BUILD_VIRTUAL_ENV)):
	mkdir -p $@

$(BUILD_VIRTUAL_ENV): | $(dir $(BUILD_VIRTUAL_ENV))
	python3 -m venv $@
	# $|/bin/python -m pip upgrade

$(BUILD_VIRTUAL_ENV)/bin/isort: | $(BUILD_VIRTUAL_ENV)
	$|/bin/python -m pip install -q isort==4.3.21

$(BUILD_VIRTUAL_ENV)/bin/yapf: | $(BUILD_VIRTUAL_ENV)
	$|/bin/python -m pip install -q yapf==0.30.0

$(BUILD_VIRTUAL_ENV)/bin/beautysh: | $(BUILD_VIRTUAL_ENV)
	$|/bin/python -m pip install -q beautysh==6.0.1

docker-clang-format:
	docker pull unibeautify/clang-format

$(BUILD_VIRTUAL_ENV)/bin/cmake-format: | $(BUILD_VIRTUAL_ENV)
	$|/bin/python -m pip install -q cmake-format==0.6.10

$(BUILD_VIRTUAL_ENV)/bin/sqlformat: | $(BUILD_VIRTUAL_ENV)
	$|/bin/python -m pip install -q sqlparse==0.3.1

isort: $(BUILD_VIRTUAL_ENV)/bin/isort
	$(BUILD_VIRTUAL_ENV)/bin/isort --help

yapf: $(BUILD_VIRTUAL_ENV)/bin/yapf
	$(BUILD_VIRTUAL_ENV)/bin/yapf --help
	mkdir -p config
	$(BUILD_VIRTUAL_ENV)/bin/yapf --style="google" --style-help > config/yapf.cfg

beautysh: $(BUILD_VIRTUAL_ENV)/bin/beautysh
	$(BUILD_VIRTUAL_ENV)/bin/beautysh --help

clang-format: docker-clang-format
	docker run --rm -i unibeautify/clang-format "-help"

cmake-format: $(BUILD_VIRTUAL_ENV)/bin/cmake-format
	$(BUILD_VIRTUAL_ENV)/bin/cmake-format --help

sqlformat: $(BUILD_VIRTUAL_ENV)/bin/sqlformat
	$(BUILD_VIRTUAL_ENV)/bin/sqlformat --help

check: isort yapf beautysh clang-format cmake-format sqlformat

clean:
	rm -rf build

.PHONY: check clean isort yapf
