$rawData = get-content input.txt
$score = 0

#A = rock, B = paper, C = scissors
#x lose, y draw, z win
foreach($row in $rawData){
    switch ($row)
    {
        "A X" {$score += (3)}
        "A Y" {$score += (1 + 3)}
        "A Z" {$score += (2 + 6)}
        "B X" {$score += (1)}
        "B Y" {$score += (2 + 3)}
        "B Z" {$score += (3 + 6)}
        "C X" {$score += (2)}
        "C Y" {$score += (3 + 3)}
        "C Z" {$score += (1 + 6)}
    }
}

Write-Host "Final score is $score"
