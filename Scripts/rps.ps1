# Rock, Paper, Scissors

# Welcome the user and get their name
Write-Host "Welcome to Rock, Paper, Scissors!"
$name = Read-Host "What is your name? "

# Set the number of games to play
$games = Read-Host "How many games would you like to play? "

# Initialize the game variables
$computerWins = 0
$userWins = 0
$ties = 0

# Start the game loop
do {

    # Reset the round variables
    $computerChoice = ""
    $userChoice = ""

    # Generate a random computer choice
    $computerChoice = Get-Random -InputObject ('rock', 'paper', 'scissors')

    # Prompt the user to make a choice
    Write-Host "It's your turn, $name. Choose rock, paper, or scissors."
    $userChoice = Read-Host "Your choice? "

    # Compare the choices and determine the winner
    if ($computerChoice -eq 'rock') {
        if ($userChoice -eq 'scissors') {
            Write-Host "You win!"
            $userWins += 1
        }
        elseif ($userChoice -eq 'paper') {
            Write-Host "The computer wins!"
            $computerWins += 1
        }
        else {
            Write-Host "It's a tie!"
            $ties += 1
        }
    }
    elseif ($computerChoice -eq 'paper') {
        if ($userChoice -eq 'rock') {
            Write-Host "The computer wins!"
            $computerWins += 1
        }
        elseif ($userChoice -eq 'scissors') {
            Write-Host "You win!"
            $userWins += 1
        }
        else {
            Write-Host "It's a tie!"
            $ties += 1
        }
    }
    else {
        if ($userChoice -eq 'rock') {
            Write-Host "You win!"
            $userWins += 1
        }
        elseif ($userChoice -eq 'paper') {
            Write-Host "The computer wins!"
            $computerWins += 1
        }
        else {
            Write-Host "It's a tie!"
            $ties += 1
        }
    }

    # Display the current score
    Write-Host "The score is: $computerWins to $userWins"

    # Ask the user if they want to play another game
    $playAgain = Read-Host "Would you like to play another game? (y/n) "

    # If the user doesn't want to play another game, end the loop
    if ($playAgain -ne "y") {
        break
    }
} while ($games -gt 0)

# Display the final score and declare the winner
if ($userWins -gt $computerWins) {
    Write-Host "Congratulations, $name! You won the game!"
}
elseif ($userWins -lt $computerWins) {
    Write-Host "The computer won the game!"
}
else {
    Write-Host "The game was a tie!"
}

 Write-Host "Thanks for playing!"
