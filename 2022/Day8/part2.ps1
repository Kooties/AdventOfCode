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
    $string = $flippedString.split(' ')


    for($i=($x-1); $i -ge 0; $i--){
        if($maxLeft -lt ($checkLine[$i] -48)){
            $maxLeft = ($checkLine[$i] -48)
        }
    }

    for($i=($x+1); $i -lt $checkLine.length; $i++){
        if($maxRight -lt ($checkLine[$i] -48)){
            $maxRight = ($checkLine[$i] -48)
        }
    }$$rawData

    for($j=($y-1); $j -ge 0; $j--){
        $string2=(([int]$string[$j]) -48)
        if($maxUp -lt ($string2)){
            $maxUp = ($string2)
        }
    }

    for($j=($y+1); $j -lt $string.length; $j++){
        $string2=(([int]$string[$j] -48))
        if($maxDown -lt ($string2)){
            $maxDown = ($string2)
        }
    }

    switch ($checkValue){
        {$_ -gt $maxUp}{
            return $true
        }
        {$_ -gt $maxDown}{
            return $true
        }{$_ -gt $maxLeft}{
            return $true
        }{$_ -gt $maxRight}{
            return $true
        }
    }
}

function Get-VisibleField{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$CheckLine,
        [array]$flippedString,
        [int]$x,
        [int]$y
    )
    $checkValue = ([int]$checkLine[$x] -48)
    $leftView = 0
    $rightView = 0
    $upView = 0
    $downView = 0
    $string = $flippedString.split(' ')
    #Write-Host "Check Value is $checkValue"
    for($i=($x-1); $i -ge 0; $i--){
        if(($checkLine[$i] -48) -lt $checkValue){
            $leftView ++
        }elseif(($i -eq ($x-1)) -or (($checkLine[$i] -48) -ge $checkValue)){
            $leftView++
            break
        }else{
            break
        }
    }
    #Write-Host "Left View Score is $leftView"

    for($i=($x+1); $i -le $checkLine.length; $i++){
        if(($checkLine[$i] -48) -lt $checkValue){
            $rightView++
        }elseif(($i -eq ($x+1)) -or (($checkLine[$i] -48) -ge $checkValue)){
            $rightView++
            break
        }else{
            break
        }
    }
    #Write-Host "Right View Score is $rightView"

    for($i=($y-1); $i -ge 0; $i--){
        $string2=(([int]$string[$i]) -48)
        if($string2 -lt $checkValue){
            $upView++
        }elseif($i -eq ($y-1) -or ($string2 -ge $checkValue)){
            $upView++
           break
        }else{
            break
        }
    }
    #Write-Host "Up View Score is $upView"

    for($i=($y+1); $i -le $string.length; $i++){
        $string2=(([int]$string[$i] -48)) 
        if($string2 -lt $checkValue){
            $downView++
        }elseif(($i -eq ($y+1)) -or ($string2 -ge $checkValue)){
            $downView++
           break
        }else{
            break
        }
    }
    #Write-Host "Down View Score is $downView"

    $score = $upView*$downView*$leftView*$rightView
    #Write-Host "Tree's score is $score"

    return $score
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
$maxScore=0
foreach($line in $rawData){
    for($j=0;$j -lt ($line.length); $j++){
        $isVisible = $false        
        $value = ([int]$line[$j] -48)
        if(($i-eq 0) -or ($i -eq ($rawData.count-1)) -or ($j -eq 0) -or ($j -eq ($line.length-1))){
            $treeScore = 0
        }else{
            $treeScore = Get-VisibleField -CheckLine $line -FlippedString $flippedString[$j] -x $j -y $i
            if($treeScore -gt $maxScore){
                #Write-Host "Max score changed from $maxScore to $treeScore on tree $i, $j"
                $maxScore = $treeScore
            }
        ##Write-Host "Score for $i $j is $treeScore"
        }
        if(($i-eq 0) -or ($i -eq ($rawData.count-1)) -or ($j -eq 0) -or ($j -eq ($line.length-1))){
            $isVisible = $true
        }
        if($isVisible -eq $false){
            $isVisible = Get-Visibility -CheckLine $line -FlippedString $flippedString[$j] -x $j -y $i
        }
        if($isVisible -eq $true){
            $numVisible++
        }else{
        }
    }
    $i++
}
return $numVisible
return $maxScore

<#
1997280 = too high
445900 = too low
480200 = not right (no comment on high/low)
#>
