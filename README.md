# DEPRECATION WARNING

This documentation has moved to https://campus.barracuda.com/product/cloudgenaccess/.

# Barracuda CloudGen Access Documentation

- Product Website: <https://www.barracuda.com/products/cloudgen-access>
- Documentation: <https://campus.barracuda.com/product/cloudgenaccess/>

## Description

This documentation uses [Jekyll](https://jekyllrb.com/) as a static website generator.

Changes to `master` automatically get deployed to github pages.

## Run locally

### Docker

1. Build and run the docker container:

    ```sh
    make docker-run
    ```

1. Open your browser on <http://localhost:4000/docs/>.

### macOS

- Requires [brew](https://brew.sh/)

1. Build and run jekyll:

    ```sh
    make macos-run
    ```

1. Open your browser on <http://localhost:4000/docs/>.
