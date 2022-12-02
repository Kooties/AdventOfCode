$rawData = get-content input.txt
$score = 0

#A,X = rock, B,Y = paper, C,Z = scissors
foreach($row in $rawData){
    switch ($row)
    {
        "A X" {$score += (1 + 3)}
        "A Y" {$score += (2 + 6)}
        "A Z" {$score += (3 + 0)}
        "B X" {$score += (1 + 0)}
        "B Y" {$score += (2 + 3)}
        "B Z" {$score += (3 + 6)}
        "C X" {$score += (1 + 6)}
        "C Y" {$score += (2 + 0)}
        "C Z" {$score += (3 + 3)}
    }
}

Write-Host "Final score is $score"
