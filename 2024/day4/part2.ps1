#example is 9
#trying to find 'MAS' that makes an 'X'

$rawData = Get-Content input.txt
$runningCount = 0
for($i=0; $i -lt $rawData.count; $i++){
    $lineNumber = $i+1
    $line = $rawData[$i]
    Write-Host "Checking line number $lineNumber with value $line"
    for($x =0; $x -lt $line.length; $x++){
        if($line[$x] -like 'A'){
            if(($i -gt 0) -and ($x -gt 0) -and ($i -lt $rawData.count) -and ($x -lt $line.length)){
                if(($rawData[$i-1][$x-1] -like 'M') -and ($rawData[$i+1][$x-1] -like 'M') -and ($rawData[$i-1][$x+1] -like 'S') -and ($rawData[$i+1][$x+1] -like 'S')){
                    $runningCount++
                }
                if(($rawData[$i-1][$x-1] -like 'S') -and ($rawData[$i+1][$x-1] -like 'S') -and ($rawData[$i-1][$x+1] -like 'M') -and ($rawData[$i+1][$x+1] -like 'M')){
                    $runningCount++
                }
                if(($rawData[$i-1][$x-1] -like 'S') -and ($rawData[$i+1][$x-1] -like 'M') -and ($rawData[$i-1][$x+1] -like 'S') -and ($rawData[$i+1][$x+1] -like 'M')){
                    $runningCount++
                }
                if(($rawData[$i-1][$x-1] -like 'M') -and ($rawData[$i+1][$x-1] -like 'S') -and ($rawData[$i-1][$x+1] -like 'M') -and ($rawData[$i+1][$x+1] -like 'S')){
                    $runningCount++
                }
            }
        }
    }
    Write-Host "Current number of matches is $runningCount after row $lineNumber"
}

Write-Host "$runningCount X-Mases found"