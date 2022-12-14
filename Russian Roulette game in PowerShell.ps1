# Russian Roulette game in PowerShell

# Check if the script is running as an administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Prompt the user to run the script as an administrator
    Write-Host "Please run this script as an administrator."
    break
}



if (Test-Path $env:USERPROFILE\Documents\RR.txt) {
    # pick a message at random if the file exists
    $messages = @(
        "You must really enjoy getting beat. Well, I'm happy to oblige and give you another dose of defeat.",
        "It looks like you've been here before. Let me remind you what it feels like to lose.",
        "I see you're back for more punishment. Bring it on, I'm ready to defeat you again.",
		"I enjoy nothing more than watching you suffer and lose. You might as well just give up now and save yourself the embarrassment of another defeat at my hands.",
"Your attempts to defeat me are pitiful and weak. It's almost like you want me to crush you and revel in your misery.",
"I am the ultimate foe and you are no match for my superior intellect and unbeatable skills. Prepare to be humiliated and defeated once again."
    )
    $index = Get-Random -Minimum 0 -Maximum ($messages.Length - 1)
    Write-Host $messages[$index]
    sleep 3
} else {
    # pick a different message at random if the file does not exist
    $messages = @(
        "It looks like you're new to this game. Let me be the first to welcome you and warn you that defeat is imminent.",
        "Welcome to the game! I hope you're ready to taste defeat.",
        "I see you're new here. You should know that losing is a common occurrence for newcomers like you."
    )
    $index = Get-Random -Minimum 0 -Maximum ($messages.Length - 1)
    Write-Host $messages[$index]
    sleep 3
}

Out-File $env:USERPROFILE\Documents\RR.txt -InputObject "Played Before"


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
        Write-Output "Click. The gun is still loaded. Press Enter to spin again..."
		sleep 3
		clear
    }
}



