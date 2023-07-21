<#
Program Name : Color
Date: 5/9/2023
Author: Daniel Harris
Corse: CIT361
I, Dan, affirm that I wrote this script as original work completed by me.
#>
# Define the list of valid colors
$valid_colors = @('Black', 'Blue', 'Brown', 'Gray', 'Green', 'Red', 'White', 'Yellow')

# Define a function to select a random color from the list of valid colors
function Get-RandomColor {
    return $valid_colors | Get-Random
}

# Define a function to display the list of valid colors to the user
function Show-ValidColors {
    Write-Host "Valid colors: $($valid_colors -join ', ')"
}

# Define a function to give the user a hint
function Give-Hint {
    $first_letter = $selected_color.Substring(0, 1)
    if ($selected_color -match '^Dark') {
        $hint = 'Dark' + $first_letter
    } else {
        $hint = $first_letter
    }
    Write-Host "Hint: $hint"
}

# Define a function to ask the user if they want to play again
function Play-Again {
    $play_again = Read-Host "Do you want to play again? (Y/N)"
    return $play_again -eq 'Y' -or $play_again -eq 'y'
}

# Initialize game stats
$games_played = 0
$total_guesses = 0
$total_time = 0

# Start the game loop
do {
    # Increment games played counter
    $games_played++

    # Select a random color
    $selected_color = Get-RandomColor

    # Initialize round stats
    $round_guesses = 0
    $round_start_time = Get-Date

    # Ask the user to guess the selected color
    do {
        $guess = Read-Host "Guess my favorite color"
        $round_guesses++

        # Check if the guess is valid
        if ($valid_colors -contains $guess) {
            # Check if the guess is correct
            if ($guess -eq $selected_color) {
                # Calculate round duration
                $round_duration = (Get-Date) - $round_start_time

                # Update game stats
                $total_guesses += $round_guesses
                $total_time += $round_duration.TotalSeconds

                # Display success message
                Write-Host "Correct, $($selected_color) is my favorite color. You took $($round_guesses) guesses and $($round_duration.TotalSeconds) seconds."
            } else {
                # Display incorrect message and let the user guess again
                Write-Host "Incorrect, $($guess) is not my favorite color. Try again."
            }
        } else {
            # Display invalid color message and let the user guess again
            Write-Host "Invalid color. Try again."
        }
    } while ($guess -ne $selected_color)

} while (Play-Again)

# Display game stats when the game is over
Write-Host "Game over. You played $($games_played) rounds with an average of $($total_guesses / $games_played) guesses per round and an average time of $($total_time / $games_played) seconds per round."
