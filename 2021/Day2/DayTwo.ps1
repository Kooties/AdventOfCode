$horizontal = 0
$vertical = 0
$aim = 0

$instructions = (get-content Day2Input.txt)

foreach($instruction in $instructions){
    $whiteSpace = $instruction.IndexOf(" ")
    $whitespacePlus = ($instruction.IndexOf(" ") + 1)
    $direction = $instruction.substring(0,$whitespace)
    $number = $instruction.substring($whitespacePlus)
    switch ($direction){
        "forward" {$horizontal += $number
            $vertical += ($aim * $number)}
        "down" {$aim += $number}
        "up" {$aim -= $number}
        "back" {$horizontal -= $number}
    }
}
$total = $horizontal * $vertical
Write-Host "Answer is $total"