.PHONY: docker-run
docker-run:
	docker build -t fyde-docs -f Dockerfile .
	docker run --rm -v "$${PWD}:/srv/jekyll" \
		-p 4000:4000 -p 35729:35729 \
		fyde-docs jekyll serve --incremental --livereload --source docs

.PHONY: macos-run
macos-run:
	@if ! command -v rbenv 1>/dev/null || ! command -v ruby-build 1>/dev/null; then \
		echo "Error - Please run 'brew install rbenv ruby-build' and try again"; fi
	rbenv install "$$(cat .ruby-version)" -s
	rbenv local "$$(cat .ruby-version)"
	gem install bundler
	bundle install
	bundle exec jekyll serve --livereload --source docs
