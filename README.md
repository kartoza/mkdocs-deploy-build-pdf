# GitHub Action to generate a PDF from an MkDocs site

![GitHub Badge](https://github.com/kartoza/mkdocs-deploy-build-pdf/workflows/Build/badge.svg)

> **Note::** This action is based heavily on https://github.com/mhausenblas/mkdocs-deploy-gh-pages

This GitHub action will build an [MkDocs site](https://www.mkdocs.org/) as [GitHub Pages](https://pages.github.com/), using the [Material](https://github.com/squidfunk/mkdocs-material) theme. It assumes that an `mkdocs-pdf.yml` file is present in the top-level directory and the source files (Markdown, etc.) are in the `docs/` folder. 

### Custom File Pathing of Mkdocs file

This action supports deployment of mkdocs with different file path , if you populate a `CONFIG_FILE` environment variable. This is important if you have mkdocs file in another folder such as if you have `mkdocs-pdf.yml` in a path `docs/mkdocs-pdf.yml`. Without populating this, the deployment assumes that `mkdocs-pdf.yml` is on the root folder.

## Installing extra packages

Some Python packages require C bindings. These packages can be installed using the `EXTRA_PACKAGES` variable. The `EXTRA_PACKAGES` variable will be passed to the `apk add` command of Alpine Linux before running `pip install` to install the Python packages.

## Installing mkdocs plugins

If you use some mkdocs plugins like [`codeinclude`](https://github.com/rnorth/mkdocs-codeinclude-plugin) then you need to define it as dependency in the typical python way with a `requirements.txt` file. In the sample above you need to add the line `mkdocs-codeinclude-plugin`. Then you need to link the file using the `REQUIREMENTS` variable.

## Example usage

```shell
name: Publish docs via GitHub Pages
on:
  push:
    branches:
      - main

jobs:
  build:
    name: Deploy docs
    runs-on: ubuntu-latest
    steps:
      - name: Checkout main
        uses: actions/checkout@v2

      - name: Build docs PDF
        uses: kartoza/mkdocs-deploy-build-pdf@master
        # Or use mhausenblas/mkdocs-deploy-gh-pages@nomaterial to build without the mkdocs-material theme
        env:
          CONFIG_FILE: folder/mkdocs-pdf.yml
          EXTRA_PACKAGES: build-base
          # GITHUB_DOMAIN: github.myenterprise.com
          REQUIREMENTS: folder/requirements.txt
```
