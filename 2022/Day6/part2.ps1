$rawData = Get-Content input.txt
$lengthOfMarker = 14
$currentString = [System.Collections.ArrayList]@()
$numMatches = 0
$firstMatch = 0

for($i=($lengthOfMarker - 1); $i -lt $rawData.length; $i++){
    for($j = $i; $j -ge ($i - ($lengthOfMarker - 1)); $j--){
        $null = $currentString.Add($rawData[$j])
    }
    $testString = $currentString | select -unique
    if($testString.count -eq $currentString.count){
        if($firstMatch -eq 0){
            $firstMatch = $i + 1
        }
        $numMatches ++
        $testString.clear()
    }
    $currentString.clear()
}

Write-Host "Total messages are $numMatches. The first match is found at $firstMatch."
