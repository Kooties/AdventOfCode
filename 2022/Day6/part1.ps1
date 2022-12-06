$rawData = Get-Content input.txt
$firstMatch = "???"
$lastMatch = "???"
$numMatches = 0
$indexOfFirstMatch = 0
for($i=3; $i -lt $rawData.length; $i++){
    if(($rawData[$i] -notlike $rawData[($i-1)]) -and ($rawData[$i] -notlike $rawData[($i-2)]) -and ($rawData[$i] -notlike $rawData[($i-3)])){
        if(($rawData[($i-1)] -notlike $rawData[($i-2)]) -and ($rawData[($i-1)] -notlike $rawData[($i-3)])){
            if($rawData[($i-2)] -notlike $rawData[($i-3)]){
                if($firstMatch -like "???"){
                    $firstMatch = ($rawData[($i-3)]) + ($rawData[($i-2)]) + ($rawData[($i-1)]) + ($rawData[($i)])        
                    $indexOfFirstMatch = ($i+1)
                }
            $lastMatch = ($rawData[($i-3)]) + ($rawData[($i-2)]) + ($rawData[($i-1)]) + ($rawData[($i)])
            $numMatches++
            }
        }
    }
}

Write-Host "First match is $firstMatch; last match is $lastMatch; total matches is $numMatches. The first match is found at position $indexOfFirstMatch."