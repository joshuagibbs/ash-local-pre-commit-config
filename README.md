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
- [Enhanced Features](#enhanced_features)
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

When you commit code changes, the pre-commit hook automatically scans your code using [ASH](https://github.com/awslabs/automated-security-helper). The code must pass all ASH security checks before the commit is accepted.

### Enhanced Scan Output

The hook now provides detailed, color-coded output with comprehensive information:

#### During Scanning
- **Real-time Progress**: Live updates showing scan progress and file counts
- **Visual Indicators**: Spinner or detailed progress monitoring based on configuration
- **Current Activity**: Display of files being processed (when real-time monitoring enabled)

#### Scan Results Display
When security issues are found, the hook displays:

1. **Detailed File Information**: 
   - Specific file paths with security issues
   - Line numbers where problems are detected
   - Precise issue descriptions

2. **Severity-based Grouping** (when enabled):
   - 🚨 **Critical Issues** - Immediate security threats
   - 🔴 **High Severity** - Significant security risks  
   - 🟡 **Medium Severity** - Moderate security concerns
   - 🔵 **Low Severity** - Minor security improvements
   - ℹ️ **Informational** - Security best practice suggestions

3. **Summary Statistics**:
   - Total number of files scanned
   - Count of issues by severity level
   - Overall scan completion status

#### Example Enhanced Output
```
🔍 Real-time scan progress:
[15 files] 3 issues found...
✅ Scan completed! Processed 15 items.

📊 Detailed Security Scan Results:

🚨 CRITICAL ISSUES (1):
📁 File: src/config.py
   ⚠️  Line 23: Hardcoded secret key detected

🟡 MEDIUM SEVERITY ISSUES (2):
📁 File: app/auth.py  
   ⚠️  Line 45: Weak password validation
📁 File: utils/crypto.py
   ⚠️  Line 12: Deprecated cryptographic function

📈 SCAN SUMMARY:
   Total findings: 3
   Critical: 1
   High: 0
   Medium: 2
   Low: 0
   Info: 0
```

<p align="center">
  <a href="" rel="noopener">
 <img width=854px height=661px src="/images/ash-scan.png" alt="ASH scan example"></a>
</p>

<p align="center">
  <a href="" rel="noopener">
 <img width=854px height=661px src="/images/ash-success.png" alt="ASH success example"></a>
</p>

### Successful Scans
When no security issues are found:
```
✅ ASH security check passed!
```

All scan activity is automatically logged to `.git/logs/pre-commit.log` with timestamps for audit purposes.

### Bypassing the Hook

In emergency situations, you can bypass the ASH check by setting the `SKIP_ASH` environment variable:

```bash
SKIP_ASH=1 git commit -m "Emergency fix"
```

## ⚙️ Configuration <a name = "configuration"></a>

### ASH Configuration Script Options

The `ash-config.sh` script supports several command-line options:

```bash
# Show all available options
./ash-config.sh --help

# Install with custom Git folder location
./ash-config.sh --git-folder /custom/path/to/git/folder /path/to/your/repo

# Enable verbose output during installation
./ash-config.sh --verbose /path/to/your/repo
```

Available options:
- `-g, --git-folder <path>`: Specify Git folder path (default: `${HOME}/Documents/Git`)
- `-v, --verbose`: Enable verbose output during installation
- `-h, --help`: Display help message

### Pre-commit Hook Configuration

The pre-commit hook includes comprehensive configuration options at the top of the file:

#### Basic Configuration
```bash
# Configuration (can be customized)
ASH_REPO_DIR="${HOME}/Documents/Git"
ASH_REPO_NAME="automated-security-helper"
ASH_OUTPUT_DIR="${PWD}/.git/logs"
RESULTS_FILE="${ASH_OUTPUT_DIR}/aggregated_results.txt"
SKIP_ASH_ENV_VAR="SKIP_ASH"
COLORIZE_OUTPUT=true
```

#### Enhanced Output Options
```bash
# Enhanced output options
VERBOSE_OUTPUT=true
OUTPUT_FORMAT="json"  # "text" or "json"
SHOW_DEBUG_INFO=false
GROUP_BY_SEVERITY=true
REAL_TIME_PROGRESS=true
```

### Configuration Options Explained

#### Basic Settings
- `ASH_REPO_DIR`: Directory where ASH repository is located
- `ASH_REPO_NAME`: Name of the ASH repository folder
- `ASH_OUTPUT_DIR`: Directory for ASH output and logs
- `RESULTS_FILE`: Path to the aggregated results file
- `SKIP_ASH_ENV_VAR`: Environment variable name used to bypass ASH checks
- `COLORIZE_OUTPUT`: Enables/disables colored terminal output

#### Enhanced Output Features
- `VERBOSE_OUTPUT`: Enables detailed file-level findings display with line numbers
- `OUTPUT_FORMAT`: Choose between "json" or "text" format for ASH output
- `SHOW_DEBUG_INFO`: Enables ASH debug mode for troubleshooting
- `GROUP_BY_SEVERITY`: Groups security findings by severity level (Critical, High, Medium, Low, Info)
- `REAL_TIME_PROGRESS`: Shows real-time scan progress with file counts and issue detection

### Advanced Features

#### Comprehensive Logging
The pre-commit hook automatically logs all activity to `.git/logs/pre-commit.log` with timestamps for audit purposes.

#### Enhanced Results Display
When `VERBOSE_OUTPUT=true`, the hook provides:
- File-specific findings with line numbers
- Severity-based color coding and grouping
- Summary statistics (total files scanned, issues by severity)
- Detailed parsing of both text and JSON output formats

#### Real-time Progress Monitoring
With `REAL_TIME_PROGRESS=true`, the hook shows:
- Live scan progress with file counts
- Current scanning activity
- Running count of security issues discovered
- Visual progress indicators

#### JSON Output Support
When `OUTPUT_FORMAT="json"` is enabled:
- Structured data parsing with `jq` (if available)
- Enhanced finding categorization
- Machine-readable output for integration

#### Severity-based Issue Grouping
Security findings are automatically categorized and color-coded:
- 🚨 **Critical Issues** (Red)
- 🔴 **High Severity** (Red)
- 🟡 **Medium Severity** (Yellow)  
- 🔵 **Low Severity** (Blue)
- ℹ️ **Informational** (Green)

### Robust Error Handling and Validation

The system includes comprehensive checks for:
- Docker runtime availability and functionality
- ASH installation and version verification
- Git repository validation
- Directory permissions and access
- Automatic backup of existing pre-commit hooks

## 🚀 Enhanced Features <a name = "enhanced_features"></a>

### Installation Script Enhancements

The `ash-config.sh` script now includes:

#### Interactive Validation
- **Prerequisites Check**: Validates ASH repository presence at expected location
- **Docker Runtime Verification**: Confirms Docker is running before installation
- **Interactive Prompts**: Allows continuation with warnings for missing components
- **Automatic Backup**: Creates timestamped backups of existing pre-commit hooks

#### Improved User Experience
- **Command-line Options**: Support for `--help`, `--verbose`, and `--git-folder` flags
- **Comprehensive Error Messages**: Clear feedback for common installation issues
- **Permission Validation**: Checks directory write permissions before attempting installation

### Pre-commit Hook Advanced Features

#### Multi-format Output Support
The hook supports both text and JSON output formats:
```bash
OUTPUT_FORMAT="json"  # For structured, machine-readable output
OUTPUT_FORMAT="text"  # For human-readable text output
```

#### Intelligent Results Parsing
- **File-Level Detail**: Shows specific files and line numbers for security issues
- **Severity Classification**: Automatically categorizes findings by security impact
- **Smart Formatting**: Adapts display based on available parsing tools (jq for JSON)

#### Progress Monitoring
Two levels of progress indication:
1. **Simple Spinner**: Basic visual feedback during scanning
2. **Real-time Monitoring**: Live updates showing files processed and issues found

#### Enhanced Logging System
- **Timestamped Logs**: All activity logged with precise timestamps
- **Audit Trail**: Complete record of hook execution in `.git/logs/pre-commit.log`
- **Debug Support**: Optional debug mode for troubleshooting ASH issues

#### Flexible Bypass Mechanism
Multiple ways to handle emergency situations:
```bash
# Temporary bypass for single commit
SKIP_ASH=1 git commit -m "Emergency fix"

# Custom environment variable (configurable)
export SKIP_ASH_ENV_VAR="MY_CUSTOM_BYPASS"
```

### Security and Reliability Enhancements

#### Robust Validation Chain
1. **Environment Validation**: Confirms all prerequisites before execution
2. **Version Checking**: Verifies ASH installation and retrieves version info
3. **Path Validation**: Ensures ASH executable is accessible
4. **Output Directory Setup**: Creates necessary directories with proper permissions

#### Error Recovery
- **Graceful Degradation**: Falls back to simpler output formats when advanced tools unavailable
- **Clear Exit Codes**: Proper status reporting for CI/CD integration
- **Helpful Error Messages**: Specific remediation steps for common failures

## ✍️ Authors <a name = "authors"></a>

- [@joshuagibbs](https://github.com/joshuagibbs) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [@awslabs](https://github.com/awslabs) - AWS Labs and those that contributed to the creation of [ASH](https://github.com/awslabs/automated-security-helper)
