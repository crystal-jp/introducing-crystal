SPECS = $(wildcard ./spec/*_spec.cr)

.PHONY: shards test $(SPECS)

shards:
	shards

test: $(SPECS)

$(SPECS):
	crystal spec $@
