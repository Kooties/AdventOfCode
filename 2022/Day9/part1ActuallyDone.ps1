$rawData = Get-Content input.txt
$hvisitedSpots = [System.Collections.ArrayList]@()
$tvisitedSpots = [System.Collections.ArrayList]@()
$hx=1
$hy=1
$tx=1
$ty=1
$g=1
$hcurrentPoint = "$hx,$hy"
$tcurrentPoint = "$tx,$ty"

$null = $tvisitedSpots.Add($tcurrentPoint)
$null = $hvisitedSpots.Add($hcurrentPoint)

foreach($line in $rawData){
    $split = $line.split(" ")
    #Write-Host "`nParsing $line at line $g"
    $g++
    #Write-Host "Starting Coordinates are $hx,$hy for the head and $tx,$ty for the tail"
    $dir = $split[0]
    $num = $split[1]
    switch($dir){
        {$_ -match "R"}{
            $hx += $num
            $lrDistance = ($hx-$tx)
            $udDistance = ($hy-$ty)
            for($i=0; $i -lt $num; $i++){
                $lrDistance = ($hx-$tx)
                $udDistance = ($hy-$ty)
                if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
                    if(($lrDistance -gt 1)){
                        $tx++
                        $ty = $hy
                    }elseif($lrDistance -lt -1){
                        $tx--
                        $ty = $hy
                    }
                }
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null = $tvisitedSpots.Add($tcurrentPoint)
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "L"}{
            $hx -= $num
            $lrDistance = ($hx-$tx)
            $udDistance = ($hy-$ty)
            for($i=0; $i -lt $num; $i++){
                $lrDistance = ($hx-$tx)
                $udDistance = ($hy-$ty)
                if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
                    if(($lrDistance -gt 1)){
                        $tx++
                        $ty = $hy
                    }elseif($lrDistance -lt -1){
                        $tx--
                        $ty = $hy
                    }
                }
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null = $tvisitedSpots.Add($tcurrentPoint)
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "U"}{
            $hy += $num
            $lrDistance = ($hx-$tx)
            $udDistance = ($hy-$ty)
            for($i=0; $i -lt $num; $i++){
                $lrDistance = ($hx-$tx)
                $udDistance = ($hy-$ty)
                if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
                    if(($udDistance -gt 1)){
                        $ty++
                        $tx = $hx
                    }elseif($udDistance -lt -1){
                        $ty--
                        $tx = $hx
                    }
                }
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null = $tvisitedSpots.Add($tcurrentPoint)
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "D"}{
            $hy -= $num
            $lrDistance = ($hx-$tx)
            $udDistance = ($hy-$ty)
            for($i=0; $i -lt $num; $i++){
                $lrDistance = ($hx-$tx)
                $udDistance = ($hy-$ty)
                if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
                    if(($udDistance -gt 1)){
                        $ty++
                        $tx = $hx
                    }elseif($udDistance -lt -1){
                        $ty--
                        $tx = $hx
                    }
                }
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null = $tvisitedSpots.Add($tcurrentPoint)
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
    }

}
$countt = $tvisitedSpots.count
$counth = $hvisitedSpots.count


Write-Host "T visited $countt`nH visited $countH"


$tvisitedSpots.clear()
$hvisitedSpots.clear()


<#
5156 - too low
5960 - just right
6252 - too high
#>

