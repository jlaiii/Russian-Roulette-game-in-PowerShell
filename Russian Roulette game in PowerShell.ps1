# Russian Roulette game in PowerShell

# Check if the script is running as an administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Prompt the user to run the script as an administrator
    Write-Host "Please run this script as an administrator."
    break
}


# Define the number of chambers in the gun
$chambers = 6

# Loop indefinitely
while ($true) {
    # Prompt the user to spin the gun
	sleep 1
    Write-Host "Press Enter to spin the gun..."
    $null = Read-Host

    # Randomly select a chamber
    $chamber = Get-Random -Minimum 1 -Maximum $chambers

    # Check if the selected chamber is the one with the bullet
    if ($chamber -eq 1) {
        # The user has lost - kill a random process
        $processes = Get-Process | Select-Object -Property Name, Id
        $randomProcess = $processes | Get-Random
        Write-Host "You lost! Killing process '$($randomProcess.Name)'"
        Stop-Process -Id $randomProcess.Id
		sleep 3
		clear
    } else {
        # The user has survived
        Write-Host "You survived! Try again..."
		sleep 3
		clear
    }
}
