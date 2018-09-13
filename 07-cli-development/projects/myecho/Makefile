SCRIPTS := $(wildcard ./spec/*_spec.cr)

.PHONY: $(SCRIPTS)

test: $(SCRIPTS)

$(SCRIPTS):
	crystal spec $@