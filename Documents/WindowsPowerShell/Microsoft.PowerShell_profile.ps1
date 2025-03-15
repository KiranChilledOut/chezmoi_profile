Invoke-Expression (&starship init powershell)
Install-GuiCompletion -Key Tab
# Function to check if a command exists
function Command-Exists {
    param (
        [string]$Command
    )
    return Get-Command $Command -ErrorAction SilentlyContinue
}
function activate {
    $venvPaths = @("./venv/bin/activate.ps1", "./.venv/bin/activate.ps1", "./venv/Scripts/activate.ps1")
    foreach ($venvPath in $venvPaths) {
        if (Test-Path $venvPath) {
            $validvenvPath = $venvPath
            break
        }
    }
    if ($validvenvPath) {
        & $validvenvPath
    }
    else {
        Write-Host "Error: activate.ps1 not found in $($venvPaths|Out-String)" -ForegroundColor Red
    }
}

function deactivate {
    Remove-Item function:\deactivate -ErrorAction SilentlyContinue
    if ($env:VIRTUAL_ENV) {
        $env:PATH = $env:PATH -replace [regex]::Escape("$env:VIRTUAL_ENV/bin:"), ""
        Remove-Item Env:\VIRTUAL_ENV
        Write-Output "Deactivated virtual environment."
    }
}

# Determine the OS platform

if ($PSVersionTable.OS -match "Darwin") {
    # Check if Homebrew is installed
    if (-not (Command-Exists brew)) {
        Write-Host "Homebrew is not installed. Please install Homebrew first: https://brew.sh/"
        return
    }

    # Check if Starship is installed
    if (-not (Command-Exists starship)) {
        Write-Host "Starship is not installed. Installing Starship using Homebrew..."
        brew install starship
    }
    else {
        Write-Host "Starship is already installed."
    }
}
elseif (($PSVersionTable.OS -match 'Ubuntu') -or ($PSVersionTable.OS -match 'Linux') ) {
    # Check if Starship is installed
    if (-not (Command-Exists starship)) {
        Write-Host "Starship is not installed. Installing Starship using curl..."
        try {
            # Install Starship with force confirmation
            Invoke-Expression "curl -sS https://starship.rs/install.sh | sh -s -- --yes"
            Write-Host "Starship installed successfully."
        }
        catch {
            Write-Host "Failed to install Starship. Please check your internet connection or permissions."
        }
    }
    else {
        Write-Host "Starship is already installed."
    }
}
else {
    Write-Host "Unsupported operating system. This profile script is designed for macOS and Linux."
    return
}


# Check if PowerShell is running interactively before loading Starship
if ($Host.Name -eq "ConsoleHost" -or $Host.Name -eq "Visual Studio Code Host") {
    # Load Starship prompt
    try {
        Invoke-Expression (&starship init powershell)
        Write-Host "Starship prompt loaded successfully."
    }
    catch {
        Write-Host "Failed to load Starship prompt. Ensure Starship is installed correctly."
    }
}
else {
    Write-Host "Non-interactive session detected. Skipping Starship initialization."
}

