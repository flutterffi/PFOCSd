ROOT := $(CURDIR)
BUILD_DIR := $(ROOT)/.build
LESSON_FILE ?= foundations/01_nsstring_nsarray_nsdictionary.m
FILE ?= $(LESSON_FILE)
ARGS ?=
LESSONS := $(shell find foundations intermediate advanced -name '*.m' | sort)
PROJECT_ENTRIES := $(shell find projects -name 'main.m' | sort)
RUNNABLES := $(LESSONS) $(PROJECT_ENTRIES)

.PHONY: list run check clean

list:
	@printf '%s\n' $(RUNNABLES)

run:
	@if [ ! -f "$(FILE)" ]; then \
		echo "Missing file: $(FILE)"; \
		exit 1; \
	fi
	@mkdir -p "$(BUILD_DIR)"
	@set -e; \
	if [ "$$(basename "$(FILE)")" = "main.m" ]; then \
		clang -fobjc-arc -framework Foundation "$$(dirname "$(FILE)")"/*.m -o "$(BUILD_DIR)/run-target"; \
	else \
		clang -fobjc-arc -framework Foundation "$(FILE)" -o "$(BUILD_DIR)/run-target"; \
	fi
	@"$(BUILD_DIR)/run-target" $(ARGS)

check:
	@mkdir -p "$(BUILD_DIR)"
	@set -e; \
	for file in $(RUNNABLES); do \
		output_name=$$(echo "$$file" | tr '/' '_' | sed 's/\.m$$//'); \
		echo "checking $$file"; \
		if [ "$$(basename "$$file")" = "main.m" ]; then \
			clang -fobjc-arc -framework Foundation "$$(dirname "$$file")"/*.m -o "$(BUILD_DIR)/$$output_name"; \
		else \
			clang -fobjc-arc -framework Foundation "$$file" -o "$(BUILD_DIR)/$$output_name"; \
		fi; \
	done

clean:
	@rm -rf "$(BUILD_DIR)"
