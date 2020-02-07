# Fyde Documentation

![Fyde](imgs/fyde-logo.png)

- Website: <https://fyde.com>
- Documentation: <https://fyde.github.io/docs>

## Test locally

This documentation uses [Jekyll](https://jekyllrb.com/) as a static website
generator. Changes to `master` automatically get deployed to github pages.

### Docker

To build and start the docker container run:

```sh
yarn start
```

Open your browser on <http://localhost:4000/docs/>.

### macOS

First, install the required dependencies.
This installation requires [brew](https://brew.sh/):

```sh
brew install rbenv ruby-build
rbenv install 2.5.1
rbenv local 2.5.1
gem install bundler
bundle install
```

Next, serve the project:

```sh
bundle exec jekyll serve --livereload
```

Open your browser on <http://localhost:4000/docs/>.
