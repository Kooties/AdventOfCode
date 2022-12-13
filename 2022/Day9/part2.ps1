class Knot{
    [int]$x
    [int]$y
    [System.Collections.ArrayList]$visitedSpots
    [void]MoveRope([int]$hx,[int]$hy){
        Write-Host "Into method:"
        $tx = $this.x
        $ty = $this.y
        $lrDistance = ($hx-$this.x)
        $udDistance = ($hy-$this.y)
        $absolute = ([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance)))
        Write-Host "Left/Right difference ($hx-$tx) is $lrDistance"
        Write-Host "Up/Down difference ($hy-$ty) is $udDistance"
        Write-Host "Total difference in knot position is $absolute"
        while($absolute -gt 1){
            if(($hx-1) -gt $this.x){
                Write-Host "moved right 1"
                $this.x++
            }
            if(($hy-1) -gt $this.y){
                Write-Host "moved up 1"
                $this.y++
            }
            if($hx+1 -lt $this.x){
                Write-Host "moved left 1"
                $this.x--
            }
            if($hy+1 -lt $this.y){
                Write-Host "moved down 1"
                $this.y--
            }
            $lrDistance = ($hx-$this.x)
            $udDistance = ($hy-$this.y)
            $absolute = ([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance)))
            Write-Host "After change loop:"
            Write-Host "Left/Right difference is $lrDistance"
            Write-Host "Up/Down difference is $udDistance"
            Write-Host "Total difference in knot position is $absolute"
        }
        <#switch($dir){
            {$_ -match "R"}{
                Write-Host "Match R:"
                Write-Host "Hori distance is $lrDistance; Vert is $udDistance. Absolute is $absolute"
                for($i=0; $i -lt $absolute; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if($absolute -gt 1){
                        Write-Host "Time to move!"
                        if(($lrDistance -gt 1)){
                            $this.x++
                            $this.y = $hy
                        }elseif($lrDistance -lt -1){
                            $this.x--
                            $this.y = $hy
                        }
                    }
                    $hcurrentPoint = "$hx,$hy"
                    $tx = $this.x
                    $ty = $this.y
                    Write-Host "Moved to $tx,$ty"
                    $tcurrentPoint = "$tx,$ty"
                    if(!$this.visitedspots.Contains($tcurrentPoint)){
                        $null = $this.visitedspots.Add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "L"}{
                Write-Host "Match L:"
                Write-Host "Hori distance is $lrDistance; Vert is $udDistance"
                for($i=0; $i -lt $absolute; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if($absolute -gt 1){
                        Write-Host "Time to move!"
                        if(($lrDistance -gt 1)){
                            $this.x++
                            $this.y = $hy
                        }elseif($lrDistance -lt -1){
                            $this.x--
                            $this.y = $hy
                        }
                    }
                    $hcurrentPoint = "$hx,$hy"
                    $tx = $this.x
                    $ty = $this.y
                    Write-Host "Moved to $tx,$ty"
                    $tcurrentPoint = "$tx,$ty"
                    if(!$this.visitedspots.Contains($tcurrentPoint)){
                        $null = $this.visitedspots.add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "U"}{
                Write-Host "Match U:"
                Write-Host "Hori distance is $lrDistance; Vert is $udDistance"
                for($i=0; $i -lt $absolute; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if($absolute -gt 1){
                        Write-Host "Time to move!"
                        if(($udDistance -gt 1)){
                            $this.y++
                            $this.x = $hx
                        }elseif($udDistance -lt -1){
                            $this.y--
                            $this.x = $hx
                        }
                    }
                    $hcurrentPoint = "$hx,$hy"
                    $tx = $this.x
                    $ty = $this.y
                    Write-Host "Moved to $tx,$ty"
                    $tcurrentPoint = "$tx,$ty"
                    if(!$this.visitedspots.Contains($tcurrentPoint)){
                        $null = $this.visitedspots.add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "D"}{
                Write-Host "Match D:"
                Write-Host "Hori distance is $lrDistance; Vert is $udDistance"
                for($i=0; $i -lt $absolute; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if($absolute -gt 1){
                        Write-Host "Time to move!"
                        if(($udDistance -gt 1)){
                            $this.y++
                            $this.x = $hx
                        }elseif($udDistance -lt -1){
                            $this.y--
                            $this.x = $hx
                        }
                    }
                    $hcurrentPoint = "$hx,$hy"
                    $tx = $this.x
                    $ty = $this.y
                    Write-Host "Moved to $tx,$ty"
                    $tcurrentPoint = "$tx,$ty"
                    if(!$this.visitedspots.Contains($tcurrentPoint)){
                        $null = $this.visitedspots.add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
        }#>
     
    }
}

$rawData = Get-Content test2input.txt
$numberOfKnots = 9
$rope = [System.Collections.ArrayList]@()
for($i=0; $i -lt $numberOfKnots; $i++){
    $newKnot = [Knot]::new()
    $newKnot.visitedspots = [System.Collections.ArrayList]@()
    $newKnot.x = 0
    $newKnot.y = 0
    $null = $newKnot.visitedspots.Add("0,0")
    $null = $rope.Add($newKnot)
}

foreach($line in $rawData){
    $split = $line.split(" ")
    $dir = $split[0]
    $num = $split[1]
    $i=0
    foreach($knot in $rope){
        $hori = $knot.x
        $vert = $knot.y
        Write-Host "Knot $i is starting at $hori,$vert"
        if($i -eq 0){
            "First knot in rope"
            switch($dir){
                {$_ -match "R"}{
                    $knot.x += $num
                    $x = $knot.x
                    $y = $knot.y
                    Write-Host "First knot moved $num spaces to $x,$y"
                }
                {$_ -match "L"}{
                    $knot.x -= $num
                    $x = $knot.x
                    $y = $knot.y
                    Write-Host "First knot moved $num spaces to $x,$y"
                }
                {$_ -match "U"}{
                    $knot.y += $num
                    $x = $knot.x
                    $y = $knot.y
                    Write-Host "First knot moved $num spaces to $x,$y"
                }
                {$_ -match "D"}{
                    $knot.y -= $num
                    $x = $knot.x
                    $y = $knot.y
                    Write-Host "First knot moved $num spaces to $x,$y"
                }
                
            }
            $hori = $knot.x
            $vert = $knot.y
            Write-Host "Knot ended at $hori,$vert"
            $i++
        }else{
            $hx = $rope[($i-1)].x
            $hy = $rope[($i-1)].y
            $tx = $knot.x
            $ty = $knot.y
            Write-Host "Starting Coordinates are $hx,$hy for the head and $tx,$ty for the tail"
            $rope.MoveRope($hx, $hy)
            $hori = $knot.x
            $vert = $knot.y
            Write-Host "Knot ended at $hori,$vert"
            $i++
        }
    }
}

return $rope[-1].count