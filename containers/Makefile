# (c) Mihai Chiroiu - CDCI
.PHONY: containers
containers:
	make -C cdci_base
	docker pull ghcr.io/digininja/dvwa:latest
	docker tag ghcr.io/digininja/dvwa:latest dvwa
