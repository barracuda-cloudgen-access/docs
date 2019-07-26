# Fyde Documentation

![Fyde](imgs/fyde-logo.png)

- Website: <https://fyde.com>
- Documentation: <https://fydeinc.github.io/docs>

## Test locally

1. Setup (steps for macOS, requires brew)

    ```sh
    brew install rbenv ruby-build
    rbenv install 2.5.1
    rbenv local 2.5.1
    gem install bundler
    bundle install
    ```

1. Test

    ```sh
    bundle exec jekyll serve
    ```
