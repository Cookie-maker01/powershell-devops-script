param(
  [string]$env = "dev"
  [string]$project = "all" #frontend, backend, all

)

Set-Location $PSScriptBoot

function Write-Log {
  param([string]$Message)

  $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $LogFile = "$PsscriptBoot\project.log"

  $output = "$time - $Message"

  Add-Content -Path $LogFile -Value $output
  Write-Output $output
}

function Update-Code {
  if (Test-Path ".git") {
    try {
        Write-Log "Pulling latest code..."
        git pull
    }
    catch {
        Write-Log "Error occurred while pulling code."
    }
  }
}

function Install-Dependencies {
  try {
    if (Test-Path "package.json") {
        Write-Log "Installing dependencies..."
        if (!(Test-Path "node_modules")) {
        npm install
    }
  }
  catch {
    Write-Log "Dependency installation failed."
  }
}

function Start-Frontend {
  if (Test-Path "package.json") {
    try {
        Write-Log "Starting Frontend..."
        npm run dev
    }
    catch {
        Write-Log "Frontend failed: $_"
    }
  }
}

function Start-Backend {
  if (Get-ChildItem *.csproj -ErrorAction SilentlyContinue) {
    try {
        Write-Log "Starting Backend..."
        dotnet run
    }
    catch {
        Write-Log "Backend failed: $_"
    }
  }
}

Write-Log "Starting project in $env mode..."

Update-Code
Install-Dependencies

if ($project -eq "frontend" -or $project -eq "all") {
  Start-Frontend
}

if ($project -eq "backend" -or $project -eq "all") {
  Start-Backend
}

Write-Log "Script finished"