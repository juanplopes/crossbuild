test: info clean helloworld
	file helloworld

test-win: info clean helloworld
	file helloworld.exe

info:
	@echo "------------------------------------------------------------------------"
	@echo CROSS_TRIPLE: $(CROSS_TRIPLE)

clean:
	@rm -f helloworld
