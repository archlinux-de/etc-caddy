default:
	just --list

# Validate Caddy configuration
test:
	@docker run -v {{justfile_directory()}}:/etc/caddy:ro caddy:2-alpine caddy --config /etc/caddy/Caddyfile validate

# Format Caddy configuration files
fmt:
	#!/usr/bin/env bash
	for f in Caddyfile conf.d/*caddy vhosts.d/*caddy; do
		docker run -u `id -u`:`id -g` --userns host -v {{justfile_directory()}}:/test -w /test caddy:2-alpine caddy fmt --overwrite $f
	done

# vim: set ft=make :
