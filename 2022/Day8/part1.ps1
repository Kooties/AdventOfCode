function Get-Visibility{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$CheckLine,
        [array]$flippedString,
        [int]$x,
        [int]$y
    )
    $checkValue = ([int]$checkLine[$x] -48)
    $maxLeft = 0
    $maxRight = 0
    $maxUp = 0
    $maxDown = 0
    #Write-Host "Check Value is $checkValue"
    $string = $flippedString.split(' ')


    for($i=($x-1); $i -ge 0; $i--){
        if($maxLeft -lt ($checkLine[$i] -48)){
            $maxLeft = ($checkLine[$i] -48)
        }
    }
    #Write-Host "MaxLeft is $maxLeft"

    for($i=($x+1); $i -lt $checkLine.length; $i++){
        if($maxRight -lt ($checkLine[$i] -48)){
            $maxRight = ($checkLine[$i] -48)
        }
    }
    #Write-Host "MaxRight is $maxRight"

    for($j=($y-1); $j -ge 0; $j--){
        $string2=(([int]$string[$j]) -48)
        #Write-Host "$j $x"
        #Write-Host "Checking $string at position $j, value $string2"
        if($maxUp -lt ($string2)){
            #Write-Host "MaxUp changed from $maxUp to $string2"
            $maxUp = ($string2)
        }
    }
    #Write-Host "MaxUp is $maxUp"

    for($j=($y+1); $j -lt $string.length; $j++){
        $string2=(([int]$string[$j] -48))
        #Write-Host "Checking $string at position $j, value $string2"
        if($maxDown -lt ($string2)){
            $maxDown = ($string2)
            #Write-Host "MaxDown changed from $maxDown to $string2"
        }
    }
    #Write-Host "MaxDown is $maxDown"

    switch ($checkValue){
        {$_ -gt $maxUp}{
            #Write-Host "Visible from top"
            return $true
        }
        {$_ -gt $maxDown}{
            #Write-Host "Visible from bottom"
            return $true
        }{$_ -gt $maxLeft}{
            #Write-Host "Visible from left"
            return $true
        }{$_ -gt $maxRight}{
            #Write-Host "Visible from right"
            return $true
        }
    }
}

function Set-FlippedString{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [array]$string
    )
    $string3 = [System.Collections.ArrayList]@()
    for($i=0;$i -lt $string.count; $i++){
        for($j=0; $j -lt $string[$i].length; $j++){
            $string2 += $string[$j][$i]
        }
        $null = $string3.Add($string2)
        $string2=""
    }
    return $string3
}


$rawData = Get-Content input.txt
$numVisible = 0
$isVisible = $false

$flippedString = Set-FlippedString -string $rawData
$i=0
foreach($line in $rawData){
    for($j=0;$j -lt ($line.length); $j++){
        $isVisible = $false        
        $value = ([int]$line[$j] -48)
        #Write-Host "Checking tree at $i,$j with value $value"
        if(($i-eq 0) -or ($i -eq ($rawData.count-1)) -or ($j -eq 0) -or ($j -eq ($line.length-1))){
            $isVisible = $true
            #Write-Host "Tree at $i $j is on the outer ring"
        }
        if($isVisible -eq $false){
            $isVisible = Get-Visibility -CheckLine $line -FlippedString $flippedString[$j] -x $j -y $i
        }
        if($isVisible -eq $true){
            #Write-Host "Tree at $i $j is visible"
            $numVisible++
        }else{
            #Write-Host "Tree at $i $j is NOT visible"
        }
    }
    $i++
}
return $numVisible

<#9693 - too high
9342 - too high

#>

