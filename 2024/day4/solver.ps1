#example is 18 times
#trying to find 'XMAS' in any order

$rawData = Get-Content input.txt
$runningCount = 0

for ($i = 0; $i -lt $rawData.count; $i++) {
    #Write-Host "I equals $i"
    $line = $rawData[$i]
    for ($x = 0; $x -lt $line.length; $x++) {
        $characterMatch = $line[$x]
        #Write-Host "X equals $x; I equals $i; current char is $characterMatch"
        if ($line[$x] -like 'X') {
            #forward
            #Write-Host "Looking for Forward"
            if ($line[$x + 1] -like 'M') {
                if ($line[$x + 2] -like 'A') {
                    if ($line[$x + 3] -like 'S') {
                        #Write-Host "Forward match found"
                        $runningCount++
                        #Write-Host "Current count is $runningCount"
                    }
                }#backward
            #Write-Host "Looking for Backward"
            }
            #backward
            if ($line[$x - 1] -like 'M') {
                if ($line[$x - 2] -like 'A') {
                    if ($line[$x - 3] -like 'S') {
                        #Write-Host "Backward match found"
                        $runningCount++
                        #Write-Host "Current count is $runningCount"
                    }
                }  
            }
            #up
            if ($i -ge 3) {
                #Write-Host "Looking for upward match"
                #straight up
                if ($rawData[$i - 1][$x] -like 'M') {
                    if ($rawData[$i - 2][$x] -like 'A') {
                        if ($rawData[$i - 3][$x] -like 'S') {
                            #Write-Host "Found match straight up"
                            $runningCount++
                        #Write-Host "Current count is $runningCount"
                        }
                    }  
                }
                #NE
                #Write-Host "Looking for NE Match"
                if (($x -le ($line.length -3)) -and ($rawData[$i - 1][$x + 1] -like 'M')) {
                    if ($rawData[$i - 2][$x + 2] -like 'A') {
                        if ($rawData[$i - 3][$x + 3] -like 'S') {
                            #Write-Host "Found NE Match"
                            $runningCount++
                        #Write-Host "Current count is $runningCount"
                        }
                    } 
                }
                #NW
                #Write-Host "Looking for NW Match"
                if (($x -ge 3) -and ($rawData[$i - 1][$x - 1] -like "M")) {
                    if ($rawData[$i - 2][$x - 2] -like 'A') {
                        if ($rawData[$i - 3][$x - 3] -like 'S') {
                            #Write-Host "Found NW Match"
                            $runningCount++
                        #Write-Host "Current count is $runningCount"
                        }
                    }
                } #down
            #Write-Host "Looking for downward matches"
            }
            #down
            if ((($i + 3 -lt $rawData.count))) {
                #Write-Host "Looking for straight down match"
                #straight
                if ($rawData[$i + 1][$x] -like 'M') {
                    if ($rawData[$i + 2][$x] -like 'A') {
                        if ($rawData[$i + 3][$x] -like 'S') {
                            #Write-Host "Found straight-down match"
                            $runningCount++
                            #Write-Host "Current count is $runningCount"
                        }
                    }  #SE
                }
                #SE
                #Write-Host "Looking for SE Match"
                if (($rawData[$i + 1][$x + 1] -like 'M') -and ($x -le ($line.length - 3))) {
                    if ($rawData[$i + 2][$x + 2] -like 'A') {
                        if ($rawData[$i + 3][$x + 3] -like 'S') {
                            #Write-Host "Found SE Match"
                            $runningCount++
                        #Write-Host "Current count is $runningCount"
                        }
                    }
                }
                #SW
                #Write-Host "Looking for SW Match"
                if (($rawData[$i+1][$x-1] -like 'M') -and ($x -ge 3)){
                    if($rawData[$i+2][$x-2] -like 'A'){
                        if($rawData[$i+3][$x-3] -like 'S'){
                            #Write-Host "Found SW Match"
                            $runningCount++
                        #Write-Host "Current count is $runningCount"
                        }
                    }
                }   
            }
        }
    }
}

Write-Host "XMAS found $runningCount times"