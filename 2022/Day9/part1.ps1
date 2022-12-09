$rawData = Get-Content input.txt
$hvisitedSpots = [System.Collections.ArrayList]@()
$tvisitedSpots = [System.Collections.ArrayList]@()
$hcurrentPoint = "1,1"
$tcurrentPoint = "1,1"
$hx=1
$hy=1
$tx=1
$ty=1
$g=1
$null = $tvisitedSpots.Add($tcurrentPoint)
$null = $hvisitedSpots.Add($tcurrentPoint)
foreach($line in $rawData){
    $split = $line.split(" ")
    Write-Host "`nParsing $line at line $g"
    $g++
    Write-Host "Starting Coordinates are $hx,$hy for the head and $tx,$ty for the tail"
    $dir = $split[0]
    $num = $split[1]
    switch($dir){
        {$_ -match "R"} {
            for($i=0; $i -lt $num; $i++){
                $hx += 1
                $diffx = ($hx - $tx)
                $diffy = ($hy - $ty)
                Write-Host "DiffX is $diffx and DiffY is $diffy"
                if((($diffx -eq 1) -or ($diffx -eq 0) -or ($diffx -eq -1)) -and (($diffy -eq 1) -or ($diffy -eq 0) -or ($diffy -eq -1))){

                }elseif(($diffx -ge 2) -or ($diffx -le -2) -or ($diffy -ge 2) -or ($diffy -le -2)){
                    switch($diffy){
                        {$_ -gt 1} {
                            #Write-Host "Diffy is greater than 1"
                            switch($diffx){
                                {$_ -ge 1} {
                                    $tx++
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -le -1} {
                                    $ty++
                                    $tx--
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -eq 0} {
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                            }
                            }
                        {$_ -lt -1} {
                            switch($diffx){
                                {$_ -ge 1} {
                                    $ty--
                                    $tx++
                                }
                                {$_ -le -1} {
                                    $ty--
                                    $tx--
                                }
                                {$_ -eq 0} 
                                {$tx--
                                }
                            }
                        }
                        {($_ -eq 0) -or ($_ -eq 1) -or ($_ -eq -1)}{
                            switch($diffx){
                                {$_ -ge 1}{
                                    $tx++
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                                {$_ -le -1}{
                                    $tx--
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                            }
                        }
                    }
                }
                Write-Host "Move is $num right for head"
                Write-Host "Head moved to $hx,$hy and tail moved to $tx,$ty"
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null=$tvisitedSpots.Add($tcurrentPoint)
                    Write-Host "Added $tcurrentpoint to Visited Spots"
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
            }
            Break
        }
           
        {$_ -match "L"} {
            for($i=0; $i -lt $num; $i++){
                $hx -= 1
                $diffx = ($hx - $tx)
                $diffy = ($hy - $ty)
                Write-Host "DiffX is $diffx and DiffY is $diffy"
                if((($diffx -eq 1) -or ($diffx -eq 0) -or ($diffx -eq -1)) -and (($diffy -eq 1) -or ($diffy -eq 0) -or ($diffy -eq -1))){

                }elseif(($diffx -ge 2) -or ($diffx -le -2) -or ($diffy -ge 2) -or ($diffy -le -2)){
                    switch($diffy){
                        {$_ -gt 1} {
                            #Write-Host "Diffy is greater than 1"
                            switch($diffx){
                                {$_ -ge 1} {
                                    $tx++
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -le -1} {
                                    $ty++
                                    $tx--
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -eq 0} {
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                            }
                        }
                        {$_ -lt -1} {
                            switch($diffx){
                                {$_ -ge 1} {
                                    $ty--
                                    $tx++
                                }
                                {$_ -le -1} {
                                    $ty--
                                    $tx--
                                }
                                {$_ -eq 0} 
                                {$tx--
                                }
                            }
                        }
                        {($_ -eq 0) -or ($_ -eq 1) -or ($_ -eq -1)}{
                            switch($diffx){
                                {$_ -ge 1}{
                                    $tx++
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                                {$_ -le -1}{
                                    $tx--
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                            }
                        }
                    }
                }
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                Write-Host "Move is $num left for head"
                Write-Host "Head moved to $hx,$hy and tail moved to $tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null=$tvisitedSpots.Add($tcurrentPoint)
                    Write-Host "Added $tcurrentpoint to Visited Spots"
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
            }
            break
        }
        {$_ -match "U"} {
            for($i=0; $i -lt $num; $i++){
                $hy += 1
                Write-Host "Head moved to $hx,$hy"
                $diffx = $hx - $tx
                $diffy = $hy - $ty
                Write-Host "DiffX is $diffx and DiffY is $diffy"
                if((($diffx -eq 1) -or ($diffx -eq 0) -or ($diffx -eq -1)) -and (($diffy -eq 1) -or ($diffy -eq 0) -or ($diffy -eq -1))){

                }elseif(($diffx -ge 2) -or ($diffx -le -2) -or ($diffy -ge 2) -or ($diffy -le -2)){
                    switch($diffy){
                        {$_ -gt 1} {
                            #Write-Host "Diffy is greater than 1"
                            switch($diffx){
                                {$_ -ge 1} {
                                    $tx++
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -le -1} {
                                    $ty++
                                    $tx--
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -eq 0} {
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                            }
                            }
                        {$_ -lt -1} {
                            switch($diffx){
                                {$_ -ge 1} {
                                    $ty--
                                    $tx++
                                }
                                {$_ -le -1} {
                                    $ty--
                                    $tx--
                                }
                                {$_ -eq 0} 
                                {$tx--
                                }
                            }
                        }
                        {($_ -eq 0) -or ($_ -eq 1) -or ($_ -eq -1)}{
                            switch($diffx){
                                {$_ -ge 1}{
                                    $tx++
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                                {$_ -le -1}{
                                    $tx--
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                            }
                        }
                    }
                }
                Write-Host "Move is $num up for head"
                Write-Host "Head moved to $hx,$hy and tail moved to $tx,$ty"
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null=$tvisitedSpots.Add($tcurrentPoint)
                    Write-Host "Added $tcurrentpoint to Visited Spots"
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
            }
            break
        }
        {$_ -match "D"} {
            for($i=0; $i -lt $num; $i++){
                $hy -= 1
                $diffx = $hx - $tx
                $diffy = $hy - $ty
                Write-Host "DiffX is $diffx and DiffY is $diffy"
                if((($diffx -eq 1) -or ($diffx -eq 0) -or ($diffx -eq -1)) -and (($diffy -eq 1) -or ($diffy -eq 0) -or ($diffy -eq -1))){

                }elseif(($diffx -ge 2) -or ($diffx -le -2) -or ($diffy -ge 2) -or ($diffy -le -2)){
                    switch($diffy){
                        {$_ -gt 1} {
                            #Write-Host "Diffy is greater than 1"
                            switch($diffx){
                                {$_ -ge 1} {
                                    $tx++
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -le -1} {
                                    $ty++
                                    $tx--
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                                {$_ -eq 0} {
                                    $ty++
                                    #Write-Host "Tail moved to $tx,$ty"
                                }
                            }
                            }
                        {$_ -lt -1} {
                            switch($diffx){
                                {$_ -ge 1} {
                                    $ty--
                                    $tx++
                                }
                                {$_ -le -1} {
                                    $ty--
                                    $tx--
                                }
                                {$_ -eq 0} 
                                {$tx--
                                }
                            }
                        }
                        {($_ -eq 0) -or ($_ -eq 1) -or ($_ -eq -1)}{
                            switch($diffx){
                                {$_ -ge 1}{
                                    $tx++
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                                {$_ -le -1}{
                                    $tx--
                                    if($diffy -lt 0){
                                        $ty--
                                    }elseif($diffy -gt 0){
                                        $ty++
                                    }
                                }
                            }
                        }
                    }
                }
                Write-Host "Move is $num down for head"
                Write-Host "Head moved to $hx,$hy and tail moved to $tx,$ty"
                $hcurrentPoint = "$hx,$hy"
                $tcurrentPoint = "$tx,$ty"
                if(!$tvisitedSpots.Contains($tcurrentPoint)){
                    $null=$tvisitedSpots.Add($tcurrentPoint)
                    Write-Host "Added $tcurrentpoint to Visited Spots"
                }
                if(!$hvisitedSpots.Contains($hcurrentPoint)){
                    $null = $hvisitedSpots.Add($hcurrentPoint)
                }
            $hcurrentPoint = "$hx,$hy"
            $tcurrentPoint = "$tx,$ty"
            }
            break
        }
    }
    $tcurrentPoint = $tcurrentPoint.split(",")
    $hcurrentPoint = $hcurrentPoint.split(",")
}

$numVisted = $tvisitedSpots.count

Write-Host "Total spots tail visited $numVisted"



$tvisitedSpots.clear()
$hvisitedSpots.clear()


<#
5156 - too low
6252 - too high
#>