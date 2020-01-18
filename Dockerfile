FROM jekyll/jekyll:3.8

# Note: keep versions compatible with https://pages.github.com/versions/

ADD Gemfile Gemfile.lock /srv/jekyll/

RUN set -ex \
    && gem install bundler \
    && bundler install
