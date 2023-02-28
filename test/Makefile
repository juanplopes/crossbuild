test: info clean helloworld
	file helloworld | grep "$(EXPECTED)" > /dev/null || echo "\033[0;31m> FAIL: `file helloworld`\033[0m"

test-win: info clean helloworld
	file helloworld.exe | grep "$(EXPECTED)" > /dev/null || echo "\033[0;31m> FAIL: `file helloworld.exe`\033[0m"

info:
	@echo "TEST: $(ORIGINAL) (actual: $(CROSS_TRIPLE))"

clean:
	@rm -f helloworld
