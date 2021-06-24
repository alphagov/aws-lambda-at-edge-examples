SHELL := /usr/bin/env bash
DEFAULT_GOAL := test
PHONY = clean

test: clean
	cd origin_response/security_headers && npm test
	cd origin_request/security.txt && npm test
	cd terraform && terraform init
	cd terraform && terraform validate

clean:
	cd terraform && rm .terraform.* || echo "No tf files to clean"
	rm *.zip || echo "No zip files to clean"
