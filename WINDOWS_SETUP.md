# Windows Setup Guide

This guide will help you set up and run the **Stock Price Tracking** project on a Windows machine.

## Prerequisites

Before starting, ensure you have the following installed:

1.  **Node.js**: [Download and install](https://nodejs.org/) the LTS version (v18 or higher recommended).
2.  **Git**: [Download and install](https://git-scm.com/download/win) Git for Windows.
3.  **Visual Studio Code** (Optional but recommended): [Download and install](https://code.visualstudio.com/).

## Getting Started

### 1. Clone the Repository

Open **PowerShell** or **Git Bash** and run:

```bash
git clone <repository-url>
cd solo-unicorn
```

### 2. Install Dependencies

Install the project dependencies using `npm`:

```bash
npm install
```

### 3. Environment Configuration

Copy the example environment file to create your local config:

```powershell
cp .env.example .env.local
```

Open `.env.local` in your editor and add your actual API keys.

### 4. Run the Development Server

Start the Next.js development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser to see the application.

## Common Windows Issues

### PowerShell Execution Policy
If you get an error like `scripts is disabled on this system`, run PowerShell as Administrator and execute:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Line Endings (CRLF vs LF)
Git for Windows usually handles this automatically, but if you see linting errors related to `Delete `␍` (prettier/prettier)`, run:
```bash
git config --global core.autocrlf true
```

## Troubleshooting
If `npm install` fails, try clearing the cache:
```bash
npm cache clean --force
```
