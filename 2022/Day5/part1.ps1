$rawData = Get-Content input.txt
$stack1 = [System.Collections.ArrayList]@()
$stack2 = [System.Collections.ArrayList]@()
$stack3 = [System.Collections.ArrayList]@()
$stack4 = [System.Collections.ArrayList]@()
$stack5 = [System.Collections.ArrayList]@()
$stack6 = [System.Collections.ArrayList]@()
$stack7 = [System.Collections.ArrayList]@()
$stack8 = [System.Collections.ArrayList]@()
$stack9 = [System.Collections.ArrayList]@()

$length =8
for($i=0;$i -lt $length; $i++){
    if($rawData[$i][1] -like '[A-Z]'){$thing = $rawData[$i][1]
        $null = $stack1.Add($thing)}
    if($rawData[$i][5] -like '[A-Z]'){$thing = $rawData[$i][5]
        $null = $stack2.Add($thing)}
    if($rawData[$i][9] -like '[A-Z]'){$thing = $rawData[$i][9]
        $null = $stack3.Add($thing)}
    if($rawData[$i][13] -like '[A-Z]'){$thing = $rawData[$i][13]
        $null = $stack4.Add($thing)}
    if($rawData[$i][17] -like '[A-Z]'){$thing = $rawData[$i][17]
        $null = $stack5.Add($thing)}
    if($rawData[$i][21] -like '[A-Z]'){$thing = $rawData[$i][21]
        $null = $stack6.Add($thing)}
    if($rawData[$i][25] -like '[A-Z]'){$thing = $rawData[$i][25]
        $null = $stack7.Add($thing)}
    if($rawData[$i][29] -like '[A-Z]'){$thing = $rawData[$i][29]
        $null = $stack8.Add($thing)}
    if($rawData[$i][33] -like '[A-Z]'){$thing = $rawData[$i][33]
        $null = $stack9.Add($thing)}
}
$stacks = $stack1,$stack2,$stack3,$stack4,$stack5,$stack6,$stack7,$stack8,$stack9

for($i=($length+2);$i -lt $rawData.length; $i++){
    $split = $rawData[$i] -split " "
    $number = [int]$split[1]
    $startingStack = (([int]$split[3]-1))
    $endingStack = (([int]$split[5]-1))
    for($j=0;$j-lt $number; $j++){
        $value1 = $stacks[$startingStack][0]
        $null = $stacks[$endingStack].Insert(0,$value1)
        $null = $stacks[$startingStack].RemoveAt(0)
    }
}
$answer = ""
foreach($stack in $stacks){
    $answer += $stack[0]
}

Write-Host "The top back of each stack is: $answer"

<#$stack1.clear()
$stack2.clear()
$stack3.clear()
$stack4.clear()
$stack5.clear()
$stack6.clear()
$stack7.clear()
$stack8.clear()
$stack9.clear()#>