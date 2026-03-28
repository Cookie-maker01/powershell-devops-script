# 🚀 PowerShell DevOps Automation Script

A reusable PowerShell script to automate development workflows for different types of projects.

## ✨ Features

* 🔍 Auto-detect project type:
Node.js (React / Vue)
.NET
📦 Automatically install dependencies
🔄 Pull latest Git code
🚀 Start development or production server
⚙️ Environment-based execution (dev / prod)
🧠 DevOps-oriented workflow automation

📁 Project Structure
.
├── start.ps1
├── README.md
├── .gitignore

## ▶️ Usage

Run in development mode
.\start.ps1 -env dev
Run in production mode
.\start.ps1 -env prod

🧪 Example Workflow
git pull → install dependencies → start server

## 🛠️ Tech

PowerShell
Git
Node.js / .NET

💡 DevOps Concept

This script demonstrates basic DevOps practices:

Automation of repetitive tasks
Environment-based configuration
Workflow standardization
Improved developer productivity

🚀 Future Improvements
Logging system (.log)
Error handling (try/catch)
Multi-service startup (frontend + backend)
CI/CD integration

## 📸 Demo

Run the script:

.\start.ps1 -env dev

Output:
🚀 Starting project...
📦 Pulling latest code...
🟢 Node project detected
🚀 Starting dev server...


## 💡 Author

Cookie.Qu
