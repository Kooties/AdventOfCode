class Knot{
    [int]$x
    [int]$y
    [void]MoveRope([string]$dir,[int]$num,[int]$hx,[int]$hy,[System.Collections.ArrayList]$spots){
        $tx = $this.x
        $ty = $this.y
        switch($dir){
            {$_ -match "R"}{
                #$hx += $num
                $lrDistance = ($hx-$this.x)
                $udDistance = ($hy-$this.y)
                for($i=0; $i -lt $num; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
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
                    $tcurrentPoint = "$tx,$ty"
                    if(!$spots.Contains($tcurrentPoint)){
                        $null = $spots.Add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "L"}{
                #$hx -= $num
                $lrDistance = ($hx-$this.x)
                $udDistance = ($hy-$this.y)
                for($i=0; $i -lt $num; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
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
                    $tcurrentPoint = "$tx,$ty"
                    if(!$spots.Contains($tcurrentPoint)){
                        $null = $spots.Add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "U"}{
                #$hy += $num
                $lrDistance = ($hx-$tx)
                $udDistance = ($hy-$ty)
                for($i=0; $i -lt $num; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
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
                    $tcurrentPoint = "$tx,$ty"
                    if(!$spots.Contains($tcurrentPoint)){
                        $null = $spots.Add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
            {$_ -match "D"}{
                #$hy -= $num
                $lrDistance = ($hx-$this.x)
                $udDistance = ($hy-$this.y)
                for($i=0; $i -lt $num; $i++){
                    $lrDistance = ($hx-$this.x)
                    $udDistance = ($hy-$this.y)
                    if(([Math]::Abs($lrDistance) + ([Math]::Abs($udDistance))) -gt 1){
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
                    $tcurrentPoint = "$tx,$ty"
                    if(!$spots.Contains($tcurrentPoint)){
                        $null = $spots.Add($tcurrentPoint)
                    }
                    #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
                }
                break
            }#end of switch case
        }
     
    }
}

<#function Move-Rope{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$dir,
        [int]$num,
        [int]$hx,
        [int]$hy,
        [int]$tx,
        [int]$ty,
        [System.Collections.ArrayList]$ropevisitedSpots
    )
    switch($dir){
        {$_ -match "R"}{
            #$hx += $num
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
                if(!$ropevisitedSpots.Contains($tcurrentPoint)){
                    $null = $ropevisitedSpots.Add($tcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "L"}{
            #$hx -= $num
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
                if(!$ropevisitedSpots.Contains($tcurrentPoint)){
                    $null = $ropevisitedSpots.Add($tcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "U"}{
            #$hy += $num
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
                if(!$ropevisitedSpots.Contains($tcurrentPoint)){
                    $null = $ropevisitedSpots.Add($tcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
        {$_ -match "D"}{
            #$hy -= $num
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
                if(!$ropevisitedSpots.Contains($tcurrentPoint)){
                    $null = $ropevisitedSpots.Add($tcurrentPoint)
                }
                #Write-Host "H moved to $hx,$hy; T moved to $tx,$ty"
            }
            break
        }#end of switch case
    }
}#>

$rawData = Get-Content test2input.txt
$rope1 = [Knot]::new()
$rope2 = [Knot]::new()
$rope3 = [Knot]::new()
$rope4 = [Knot]::new()
$rope5 = [Knot]::new()
$rope6 = [Knot]::new()
$rope7 = [Knot]::new()
$rope8 = [Knot]::new()
$rope9 = [Knot]::new()
$ropeKnots = $rope1,$rope2,$rope3,$rope4,$rope5,$rope6,$rope7,$rope8,$rope9
$r1array = [System.Collections.ArrayList]@()
$r2array = [System.Collections.ArrayList]@()
$r3array = [System.Collections.ArrayList]@()
$r4array = [System.Collections.ArrayList]@()
$r5array = [System.Collections.ArrayList]@()
$r6array = [System.Collections.ArrayList]@()
$r7array = [System.Collections.ArrayList]@()
$r8array = [System.Collections.ArrayList]@()
$r9array = [System.Collections.ArrayList]@()
$arrays = $r1array,$r2array,$r3array,$r4array,$r5array,$r6array,$r7array,$r8array,$r9array

foreach($rope in $ropeKnots){
    $rope.x = "1"
    $rope.y = "1"
    $x=1
    $y=1
    $currentPoint = "$x,$y"
    $null=$rope.VisitedSpots.Add($currentPoint)
}

foreach($line in $rawData){
    $split = $line.split(" ")
    $dir = $split[0]
    $num = $split[1]
    $i=0
    foreach($rope in $ropeKnots){
        if($i -eq 0){
            switch($dir){
                {$_ -match "R"}{
                    $rope.x += $num
                }
                {$_ -match "L"}{
                    $rope.x -= $num
                }
                {$_ -match "U"}{
                    $rope.y += $num
                }
                {$_ -match "D"}{
                    $rope.y -= $num
                }
            }
            $i++
        }else{
            $hx = $rope[$i-1].x
            $hy = $rope[$i-1].y
            $rope.MoveRope($dir, $num, $hx, $hy,$arrays[$i])
            $i++
        }
    }
}