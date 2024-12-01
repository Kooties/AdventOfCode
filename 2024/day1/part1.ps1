$rawData = get-content input.txt
$column1 = [System.Collections.ArrayList]@()
$column2 = [System.Collections.ArrayList]@()

foreach($line in $rawData){
    $split = $line.split(" ")
    $column1.Add($split[0])
    $column2.Add($split[$split.length-1])
}
<#Part 1
$column1.sort()
$column2.sort()

$runningTotal = 0

$i=0
while($i -lt $column1.count){
    if([int]$column1[$i] -gt [int]$column2[$i]){
        $runningTotal += ([int]$column1[$i] - [int]$column2[$i])
    }elseif([int]$column1[$i] -lt [int]$column2[$i]){
        $runningTotal += ([int]$column2[$i] - [int]$column1[$i])
    }elseif([int]$column1[$i] -eq [int]$column2[$i]){
        $runningTotal += 0
    }
    $i ++
}
Write-Host "Total is $runningTotal"
#>

$runningTotal = 0
foreach($x in $column1){
    $count = 0
    foreach($y in $column2){
        if([int]$x -eq [int]$y){
            $count ++
        }
    }
    $runningTotal += ([int]$x * $count)
}
Write-host "total is $runningTotal"


$column1.clear()
$column2.clear()