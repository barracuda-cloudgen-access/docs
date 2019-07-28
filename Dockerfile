FROM jekyll/jekyll:3.8

# Note: keep versions compatible with https://pages.github.com/versions/

ADD Gemfile Gemfile.lock /srv/jekyll/

RUN bundler install
