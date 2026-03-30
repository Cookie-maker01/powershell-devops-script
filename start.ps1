param(
  [string]$env = "dev"
  [string]$project = "all" #frontend, backend, all
  [string]$target = "run" #run / build

)

Set-Location $PSScriptBoot

#====== log =======

function Write-Log {
  param([string]$Message)

  $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $LogFile = "$PsscriptBoot\project.log"

  $msg = "$time - $Message"

  Add-Content -Path $LogFile -Value $msg
  Write-Output $msg
}

#===== check port  ======

function  Test-Port {
  param ([int]$Port)

  $connection = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
  return $connection -ne $null
}

#==== Git Update ======

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

#==== Install Dependencies ======

function Install-Node {
  try {
    if (Test-Path "package.json") {
        Write-Log "Installing Node dependencies..."
        if (!(Test-Path "node_modules")) {
        npm install
    }
  }
  catch {
    Write-Log "Dependency installation failed."
  }
 }
}

#==== Frontend ======

function Start-Frontend {
  $port = 3000
  
  if(Test-Port $port) {
     Write-Log "Port $port already in use."
  } else {
    Write-Log "Starting Frontend on Port $port..."
    Satrt-Process powershell -ArgumentList "npm run dev"
    Start-Sleep 3
    Start-Process "http://localhost:$port"
  }
}

#==== Backend ======

function Start-Backend {
  $port = 5000
  
  if (Test-Port $port) {
    Write-Log "Port $port already in use."
  } else {
    Write-Log "Starting Backend on Port $port..."
    Start-Process powershell -ArgumentList "dotnet run"
  }
}

#==== Build (CI/CD) ======

function Build-Project {
  if (Test-Path "package.json") {
    Write-Log "Building Frontend..."
    npm run build
  }

  if (Get-ChildItem *.csproj -ErrorAction SilentlyContinue) {
    Write-Log "Building Backend..."
    dotnet build
  }
}

#==== Main Execution ======

Write-Log "Script started: project=$project, env=$env, target=$target"

Update-Code
Install-Node

if ($target -eq "build") {
  Build-Project
  exit
}

if ($project -eq "frontend" -or $project -eq "all") {
  Start-Frontend
}

if ($project -eq "backend" -or $project -eq "all") {
  Start-Backend
}

Write-Log "All tasks triggered"