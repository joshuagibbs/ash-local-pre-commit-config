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
- [Configuration](#configuration)
- [Advanced Features](#advanced_features)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

A robust script that can be run locally on your machine to configure a Git pre-commit hook in your repository. This hook uses the AWS Automated Security Helper (ASH) tool to scan your code for security issues before any commit is accepted, helping you maintain secure coding practices.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine so you can have automated scanning of your code repos before committing changes.

### Prerequisites

This project is designed to run on MacOS and assumes the following pre-requisites are in place:

- You have a Docker compatible runtime running locally on your machine such as:
  * [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  * [Colima](https://github.com/abiosoft/colima) - configured to use Docker runtime
  * [Rancher Desktop](https://rancherdesktop.io/) - configured to use dockerd
  * [Podman](https://podman.io/) - with podman-docker installed
- You have cloned the repo for the [AWS Automated Security Helper (ASH)](https://github.com/awslabs/automated-security-helper) tool.
- The repo where you want to implement the git pre-commit hook is a valid git repository.

### Installing

Clone this repo:

```bash
git clone https://github.com/joshuagibbs/ash-local-pre-commit-config.git
cd ash-local-pre-commit-config
```

Make sure that ash-config.sh is executable:

```bash
chmod +x ./ash-config.sh
```

Execute ash-config.sh against your repo:

```bash
# Basic usage
./ash-config.sh /path/to/your/repo

# With custom Git folder location
./ash-config.sh --git-folder /custom/path/to/git/folder /path/to/your/repo

# Show help
./ash-config.sh --help
```

This copies the pre-commit file into the .git/hooks directory in your repo which creates a git pre-commit hook. Any existing pre-commit hook will be backed up.

<p align="center">
  <a href="" rel="noopener">
 <img width=802px height=551px src="/images/pre-commit.png" alt="pre-commit illustration"></a>
</p>

## 🎈 Usage <a name="usage"></a>

When you commit code changes, before they are accepted the code in the repo will be scanned by [ASH](https://github.com/awslabs/automated-security-helper) and will need to pass all of the ASH security checks before the commit is accepted.

<p align="center">
  <a href="" rel="noopener">
 <img width=854px height=661px src="/images/ash-scan.png" alt="ASH scan example"></a>
</p>

<p align="center">
  <a href="" rel="noopener">
 <img width=854px height=661px src="/images/ash-success.png" alt="ASH success example"></a>
</p>

If one or more of the ASH security checks fail, the log (aggregated_results.txt) will be displayed in the console so you can see which ASH security checks are failing and perform the necessary remediation before attempting your commit again.

### Bypassing the Hook

In emergency situations, you can bypass the ASH check by setting the `SKIP_ASH` environment variable:

```bash
SKIP_ASH=1 git commit -m "Emergency fix"
```

## ⚙️ Configuration <a name = "configuration"></a>

### Pre-commit Hook Configuration

You can customize the behavior of the pre-commit hook by editing the configuration variables at the top of the pre-commit file:

```bash
# Configuration (can be customized)
ASH_REPO_DIR="${HOME}/Documents/Git"
ASH_REPO_NAME="automated-security-helper"
ASH_OUTPUT_DIR="${PWD}/.git/logs"
RESULTS_FILE="${ASH_OUTPUT_DIR}/aggregated_results.txt"
SKIP_ASH_ENV_VAR="SKIP_ASH"
COLORIZE_OUTPUT=true

```

Key options:
- `COLORIZE_OUTPUT`: Enables/disables colored terminal output
- `SKIP_ASH_ENV_VAR`: The environment variable name used to bypass ASH checks



### Progress Indicator

The pre-commit hook now displays a spinner while ASH is running, providing visual feedback during the scan.

### Docker and ASH Checks

The pre-commit hook now checks if a Docker compatible runtime is running and if the ASH repo is cloned locally before attempting to run the scan, providing helpful error messages if either is missing.

## ✍️ Authors <a name = "authors"></a>

- [@joshuagibbs](https://github.com/joshuagibbs) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [@awslabs](https://github.com/awslabs) - AWS Labs and those that contributed to the creation of [ASH](https://github.com/awslabs/automated-security-helper)
