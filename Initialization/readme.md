# Project Prerequisites & Setup

This project uses **Azure Functions Core Tools v4** (for PowerShell functions) and a minimal container agent. Below are PowerShell-only installation steps.

> **Assumption:** You have PowerShell 7.5.1 installed. Run everything from an **elevated** (Admin) prompt.

# Environment Setup

We have already run the initialization script. Now, we need to install the prerequisites. You can choose one of the following installation methods:

## Prerequisites

- Windows PowerShell 5.1 or higher  
- Internet connection  
- Administrator privileges  

## Installation Options

1. **Automatic Installation via PowerShell**  
2. **Manual Installation**  

---

## 1. Automatic Installation via PowerShell

Run the following command in an elevated PowerShell prompt from the project root directory:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\install-prereqs.ps1
```

This script will automatically:

- Install Git  
- Install Node.js (LTS)  
- Install Python 3.10  
- Install Visual Studio Code  
- Install Docker Desktop  
- Configure necessary environment variables  

### Usage Steps

1. Open PowerShell as Administrator.  
2. Navigate to the project root directory.  
3. Execute the commands above.  

---

## 2. Manual Installation

Download and install each prerequisite manually using the following links:

| Software               | Version     | Download Link                                                         |
|------------------------|-------------|-----------------------------------------------------------------------|
| Git                    | Latest      | https://git-scm.com/downloads                                         |
| Node.js                | LTS (v16.x) | https://nodejs.org/en/download/                                       |
| Python                 | 3.10.x      | https://www.python.org/downloads/                                     |
| Visual Studio Code     | Latest      | https://code.visualstudio.com/download                                |
| Docker Desktop         | Latest      | https://www.docker.com/products/docker-desktop                        |

### Manual Installation Steps

1. Download each installer from the links above.  
2. Run each installer as Administrator.  
3. Follow the on-screen instructions for each installer.  
4. Verify installation by running in PowerShell:

   ```powershell
   git --version