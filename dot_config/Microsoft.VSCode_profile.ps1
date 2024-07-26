
# Check if Chocolatey is installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Check if PSReadLine is installed
if (-not (Get-Module -ListAvailable -Name GuiCompletion )) {
    Write-Host GuiCompletion is not installed. Installing PSReadLine..."
    Install-Module -Name GuiCompletion -Scope CurrentUser
} else {
    Write-Host GuiCompletion is already installed."
}

# Check if Starship is installed
if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Host "Starship is not installed. Installing Starship..."
    choco install starship -y
} else {
    Write-Host "Starship is already installed."
}

# Load Starship prompt
Invoke-Expression (&starship init powershell)

Install-GuiCompletion -Key Tab

