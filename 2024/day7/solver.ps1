function Test-Functions($inputData){
    $numbers = $inputData.split(':').split(' ')
    $intendedResult = [bigint]$numbers[0]
    #Write-Host "Starting Test on line $inputData"
    $resultsArray = [System.Collections.ArrayList]@()
    $add = [bigint]$numbers[2] + [bigint]$numbers[3]
    $multiply = [bigint]$numbers[2] * [bigint]$numbers[3]
    $concat = [string]$numbers[2] + [string]$numbers[3]
    #Write-Host "First addition sums to $add"
    #Write-Host "First multiplication results in $multiply"
    #Write-Host "First concat results in $concat"
    $resultsArray.Add($add) | Out-Null
    $resultsArray.Add($multiply) | Out-Null
    $resultsArray.Add($concat) | Out-Null
    #Write-Host "results array is now" $resultsArray
    if($numbers.count -gt 4){
        $workingArray = [System.Collections.ArrayList]@()
        for($i = 4; $i -lt ($numbers.count); $i++){
            #Write-Host "Working on operation number" $i-1
            foreach($value in $resultsArray){
                $workingArray.Add($value) | out-Null
            }
            $resultsArray.clear() | Out-Null
            #Write-Host "working array is now" $workingArray
            #$resultsArray.clear() | Out-Null
            foreach($value in $workingArray){
                #Write-Host "working on value $value and" $numbers[$i]
                $add = ([bigint]$value + [bigint]$numbers[$i])
                $multiply = ([bigint]$value * [bigint]$numbers[$i])
                $concat = [string]$value + [string]$numbers[$i]
                #Write-Host "new add is $add, multiply is $multiply, and concat is $concat"
                if($add -le $intendedResult){
                    $resultsArray.Add($add) | Out-Null
                }
                if($multiply -le $intendedResult){
                    $resultsArray.Add($multiply) | Out-Null
                }
                if([bigint]$concat -le $intendedResult){
                    $resultsArray.Add($concat) | Out-Null
                }
                #Write-Host "results array is now" $resultsArray
            }
            $workingArray.clear() | Out-Null
        }
    }
    
    if($resultsArray -contains $intendedResult){
        return $true
    }else{
        return $false
    }
}

$rawData = Get-Content input.txt
$total=0
foreach($line in $rawData){
    #Write-Host "Testing line $line"
    if(Test-Functions($line)){
        #Write-Host "Line Matches; adding "
        $total += [bigint]$line.split(':').split(' ')[0]
    }
}

Write-Host "total is $total"