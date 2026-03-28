Set-Location $PSScriptRoot

#Item name
#$project = "DemoApp"

Write-output "Starting project..."

# Git pull the newest code (if it is a git item)
if (Test-Path ".git") {
  Write-output "Git repo detected, pulling latest code..."
  git pull
}

# Node.js item (React / Vue / Next)
if (Test-Path "package.json") {
  Write-output "Node.js project detected"

  if (Test-Path "Package-lock.json") {
    npm install
  } else {
  npm install
  } 

  npm run dev
}

# .NET item
elseif  (Get-ChildItem *.csproj -ErrorAction SilentlyContinue) {
  Write-output ".NET project detected"
  dotent run
}

# Python item
elseif (Test-Path "requirements.txt") {
  Write-output "Python project detected"
  pip install -r requirements.txt
  Python main.py 
}

# undetected
else {
  Write-output "Unknow project type"
}