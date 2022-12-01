$data = Get-Content input.txt

$days = 1..256

$splitInput = $data.split(',')

$sanitizedInput = [System.Collections.ArrayList]@()

[double]$zeroes = 0
[double]$ones = 0
[double]$twos = 0
[double]$threes = 0
[double]$fours = 0
[double]$fives = 0
[double]$sixes = 0
[double]$sevens = 0
[double]$eights = 0
$numbers = $zeroes,$ones,$twos,$threes,$fours,$fives,$sixes,$sevens,$eights

foreach($thing in $splitInput){
    $null = $sanitizedInput.Add(([int]::parse($thing)))
}

foreach($thing in $sanitizedInput){
    switch ($thing)
    {
        0 {($zeroes ++)}
        1 {($ones ++)}
        2 {($twos ++)}
        3 {($threes ++)}
        4 {($fours ++)}
        5 {($fives ++)}
        6 {($sixes ++)}
        7 {($sevens ++)}
        8 {($eights ++)}
    }
}

foreach($day in $days){
    [double]$newFish = 0
    [double]$buffer = 0
    foreach($num in $numbers){
        $newFish = $zeroes
        $buffer = $zeroes
        $zeroes = $ones
        $ones = $twos
        $twos = $threes
        $threes = $fours
        $fours = $fives
        $fives = $sixes
        $sixes = $sevens
        $sixes += $buffer
        $sevens = $eights
        $eights = $newFish
    }
}

[double]$totalFish = ($zeroes + $ones + $twos + $threes + $fours + $fives + $sixes + $sevens + $eights)

Write-host "Total fish count is $totalFish"