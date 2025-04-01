<h2 align="center">ASH git pre-commit configuration</h2>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/joshuagibbs/ash-local-pre-commit-config.svg)](https://github.com/joshuagibbs/ash-local-pre-commit-config/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/joshuagibbs/ash-local-pre-commit-config.svg)](https://github.com/joshuagibbs/ash-local-pre-commit-config/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

A short script that can be run locally on your machine that will configure a Git pre-commit hook in your repo to use the AWS Automated Security Helper (ASH) tool to scan your code before any commit is accepted.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine so you can have automated scanning of your code repos before committing changes.

### Prerequisites

This project is designed to run on MACOS and assumes the following pre-requisites are in place.

- You have a folder name 'Git' in your Documents folder where you are cloning your repos to.
- You have cloned the repo for the [AWS Automated Security Helper (ASH)](https://github.com/awslabs/automated-security-helper) tool into the 'Git' folder.
- You have [Docker Desktop](https://www.docker.com/products/docker-desktop/) running locally.
- The repo where you want to implement the git pre-commit hook is also cloned into your 'Git' folder.

### Installing

Clone this repo into your 'Git' folder.

```
cd "${HOME}"/Documents/Git
git clone https://github.com/joshuagibbs/ash-local-pre-commit-config.git
```

Make sure that ash-config.sh is executable

```
chmod +x /ash-local-pre-commit-config/ash-config.sh
```

Execute ash-config.sh against your repo

```
./ash-local-pre-commit-config/ash-config.sh "${HOME}"/Documents/Git/<REPO_NAME>
```

## 🎈 Usage <a name="usage"></a>

Add notes about how to use the system.

## ✍️ Authors <a name = "authors"></a>

- [@kylelobo](https://github.com/kylelobo) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References
