param(
  $env = "dev"
)

Set-Location $PSScriptBoot

function Update-Code {
  if (Test-Path ".git") {
    Write-Output "Pulling latest code..."
    git pull
  }
}

function Install-Dependencies {
  if (Test-Path "package.json") {
    Write-Output "Installing dependencies..."
    if (!(Test-Path "node modules")) {
      npm install
    }
  }
}

function Start-App {
  if (Test-Path "package.json") {
    if ($env -eq "dev") {
      Write-Output "Starting dev server..."
      npm run dev
      Start-Process "http://localhost:3000"
    }
    elseif ($env -eq "prod") {
      Write-Output "Starting production..."
      npm sratr
    }
  }
}

Update-Code
Install-Dependencies
Start-App