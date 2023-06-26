
.PHONY: install
install:
	@echo "Building the Dev Image..."
	+docker build -t ucom-html-1:latest .

.PHONY: build
build: install

.PHONY: run
run:
	@echo "Running container on port :3000/tcp ..."
	@+docker run \
		-d \
		--rm \
		--name ucom-html-1 \
		--publish 3000:80 \
		-v ./src:/usr/share/nginx/html \
		-v ./nginx.conf:/etc/nginx/nginx.conf \
		ucom-html-1:latest
	@echo "Done!"
	@echo "Join the party at 0.0.0.0:3000 !!"

.PHONY: terminal
terminal:
	@echo "Creating a terminal session..."
	@-docker exec -i -t ucom-html-1 /bin/sh

.PHONY: clear
clear:
	@printf "Taking out the trash..."
	@sleep 1
	@-docker rm -f ucom-html-1 &>/dev/null
	@printf " Succeed!\n"

.PHONY: cleanup
cleanup: clear

.PHONY: clean
clean: clear
