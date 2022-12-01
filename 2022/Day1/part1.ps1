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
$fewestCals = 0
$currentCals = 0
foreach($num in $SanitizedInput){
    if($num -ne 0){
        $currentCals += $num
    }else{
        if($currentCals -gt $mostCals){
            $mostCals = $currentCals
        }elseif($currentCals -lt $fewestCals){
            $fewestCals = $currentCals
        }
        $currentCals = 0
    }
}

Write-Host "The fewest calories any elf is carrying is $fewestCals while the most in $mostCals"