<#Good hiking trail starts at 0; ends at 9, goes up/down/left/right, and increases by 1 each time
Trail heads have height 0 and start a trail; Trailhead score is number of 9-height positions reachable from a single trailhead
Looking for the sum of the scores of all trailheads#>

class Trailhead{
    [int]$score
}

Function Read-Left($y,$x){
    if($x -eq 0){
        return $false
    }else{
        $zint = [int]$rawData[$y][$x-1]
        $compInt = [int]$rawData[$y][$x]
        if(($compInt+1) -eq $zint){
            return $true
        }else{
            return $false
        }
    }
}

Function Read-Right($y,$x){
    if($x -eq $rawData[[int]$y].length){
        return $false
    }else{
        $zint = [int]$rawData[[int]$y][[int]$x+1]
        $compInt = [int]$rawData[[int]$y][[int]$x]
        if(($compInt+1) -eq $zint){
            return $true
        }else{
            return $false
        }
    }
}

Function Read-Up($y,$x){
    if($y -eq 0){
        return $false
    }else{
        $zint = [int]$rawData[$y-1][$x]
        $compInt = [int]$rawData[$y][$x]
        if(($compInt+1) -eq $zint){
            return $true
        }else{
            return $false
        }
    }
}

Function Read-Down($y,$x){
    if($y -eq $rawData.count){
        return $false
    }else{
        $zint = [int]$rawData[$y+1][$x]
        $compInt = [int]$rawData[$y][$x]
        if(($compInt+1) -eq $zint){
            return $true
        }else{
            return $false
        }
    }
}

$rawData = Get-content example1.txt
for($y = 0; $y -lt $rawData.count; $y++){
    for($x=0; $x -lt $rawData[$y].count; $x++){
        if($rawData[$y][$x] -match '0'){

        }
    }
}