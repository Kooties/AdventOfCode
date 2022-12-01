$rawData = get-content input1.txt

$elvesData = ($rawData -replace '^$',',' -join [Environment]::NewLine -split ",")
$semiSanitizedInput = [System.Collections.ArrayList]@()
$SanitizedInput = [System.Collections.ArrayList]@()

#$semiSanitizedInput.clear()

foreach($datum in $elvesData){
    $thing = ($datum -replace '^$',',' -join [Environment]::NewLine -split ",")
    $null = $semiSanitizedInput.add($thing)
}

#$SanitizedInput.clear()

foreach($datum in $semiSanitizedInput){
    $things = ($datum -split "`r`n")
    foreach($thing in $things){
        $null = $SanitizedInput.add([int]$thing)
    }
}

$mostCals = 0
$secondMost = 0
$thirdMost = 0
$currentCals = 0
foreach($num in $SanitizedInput){
    if($num -ne 0){
        $currentCals += $num
    }else{
        if($currentCals -gt $mostCals){
            $thirdMost = $secondMost
            $secondMost = $mostCals
            $mostCals = $currentCals
        }elseif($currentCals -gt $secondMost){
            $thirdMost = $secondMost
            $secondMost = $currentCals
        }elseif($currentCals -gt $thirdMost){
            $thirdMost = $currentCals
        }
        $currentCals = 0
    }
}
$top3 = ($mostCals + $secondMost + $thirdMost)
Write-Host "The top 3 elves are carrying $top3 calories"