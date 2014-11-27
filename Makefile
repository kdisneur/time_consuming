REBAR_SCRIPT=$(CURDIR)/rebar

all: get-deps compile

clean:
	@$(REBAR_SCRIPT) -C test.config skip_deps=true clean

clean-deps:
		@rm -rvf $(CURDIR)/deps/*

compile: clean
	$(REBAR_SCRIPT) -C rebar.config skip_deps=true compile

distclean: clean clean-deps

get-deps:
	@$(REBAR_SCRIPT) -C test.config get-deps

test: get-deps compile
	@$(REBAR_SCRIPT) -C test.config compile
	@$(REBAR_SCRIPT) -C test.config skip_deps=true eunit
