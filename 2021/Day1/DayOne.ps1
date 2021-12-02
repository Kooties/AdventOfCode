$increase = 0
$decrease = 0

$numbers = @()
Import-CSV -Path "C:\Users\kkyle\Downloads\AoCInputDayOnePuzzleOne.csv" | Select-Object @{Name="0";Expression={[int32]$_.0}}| ForEach-Object{$numbers += $_.0}

foreach ($number in $numbers){
    if($number -gt $previousNumber){
        $increase++
        $previousNumber = $number
    }
    if($number -lt $previousNumber){
        $decrease++
        $previousNumber = $number
    }
}

Write-Host "The data shows an increase $increase times"
$increase = 0
$decrease = 0

$currentIteration = 3
$comparisonSum = $numbers[0] + $numbers[1] + $numbers[2]


while($currentIteration -le $numbers.count){
    $newSum = ($numbers[$currentIteration] + $numbers[$currentIteration - 1] + $numbers[$currentIteration -2])
    if($newSum -gt $comparisonSum){
        $increase++
    }
    $comparisonSum = $newSum
    $currentIteration++
}

Write-Host "The number of times the sum increases is $increase"