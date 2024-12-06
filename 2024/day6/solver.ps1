Function Find-Direction{
    foreach($line in $rawData){
        if($line -match '\^'){
            return 1
        }elseif($line -match '>'){
            return 2
        }elseif($line -match 'v'){
            return 3
        }elseif($line -match '<'){
            return 4
        }
    }
    return -1
}

Function Find-Carrot{
    foreach($line in $rawData){
        if($line -match '\^'){
            return $line.indexOf('^'),$rawData.IndexOf($line)
        }elseif($line -match '>'){
            return $line.indexOf('>'),$rawData.IndexOf($line)
        }elseif($line -match 'v'){
            return $line.indexOf('v'),$rawData.IndexOf($line)
        }elseif($line -match '<'){
            return $line.indexOf('<'),$rawData.IndexOf($line)
        }
    }
    return -1
}

Function Find-Path([int]$dir){
    ##Write-Host "Start Finding Path"
    $y = $startingLocation[0]
    $x = $startingLocation[1]  
    $rawdataCount = $rawData.count
    $dir = $dir%4
        ##Write-Host "Direction is $dir; entering Switch statement"
        switch($dir){
            1 {#up
                #Write-Host "Calculating up; x equals $x; y equals $y"
                if($x -lt 0){
                    $dir = -1;
                    Break
                }
                do{
                    $rawData[$x] = $rawData[$x].substring(0,$y) + 'X' + $rawData[$x].substring($y+1)
                    $x--
                    ##Write-Host "Moving up"
                    if($x -lt 0){
                        $dir = -1;
                        Break
                    }
                }while($rawData[$x][$y] -notmatch '#')
                $dir++;
                $x++
                ##Write-Host "line 46; dir now $dir"
                Break
                }
            2 {#right
                #Write-Host "Calculating right"
                if($y -gt ($rawData[$y].Length)){
                    $dir = -1;
                    Break
                }
                while($rawData[$x][$y] -notmatch '#'){
                    $rawData[$x] = $rawData[$x].substring(0,$y) + 'X' + $rawData[$x].substring($y+1)
                    $y++
                    ##Write-Host "Moving right"
                    if($y -gt ($rawData[$y].Length)){
                        $dir = -1;
                        Break
                    }
                }
                $dir++;
                $y--
                ##Write-Host "line 56; dir now $dir"
                Break
                }
            3 {#down
                #Write-Host "Calculating down"
                if($x -ge ($rawDataCount)){
                    #Write-Host "$x larger than " $rawDataCount
                    $dir = -1;
                    Break
                }
                do{
                    $rawData[$x] = $rawData[$x].substring(0,$y) + 'X' + $rawData[$x].substring($y+1)
                    $x++
                    #Write-Host "X is $x at line 89"
                    if($x -ge ($rawDataCount)){
                        #Write-Host "$x larger than " $rawDataCount
                        $dir = -1;
                        Break
                    }
                    ##Write-Host "Moving down"
                }while($rawData[$x][$y] -notmatch '#')
                $dir++
                $x--
                Break
                }
            0 {#left
                #Write-Host "Calculating left"
                if($y -lt 0){
                    $dir = -1;
                    Break
                }
                while($rawData[$x][$y] -notmatch '#'){
                    $rawData[$x] = $rawData[$x].substring(0,$y) + 'X' + $rawData[$x].substring($y+1)
                    $y--
                    ##Write-Host "Moving left"
                    if($y -lt 0){
                        $dir = -1;
                        Break
                    }
                }
                $dir++;
                $y++
                ##Write-Host "line 76; dir now $dir"
                Break
                }
        }
        #Write-Host "out of Switch statment"
        #Write-Host $rawData[5]
        if(($y -gt $rawData.count) -or ($y -lt 0) -or ($x -gt $rawData[$y].length) -or ($x -lt 0)){
            #$rawDataCount = $rawData.Count
            #$rawDataLength = $rawData[$y].Length
            ##Write-Host "rawDataCount is $rawDataCount and rawDataLength is $rawDataLength"
            ##Write-Host "y is $y and x is $x"
            $dir = -1
        }
    $startingLocation[0] = $y
    $startingLocation[1] = $x
    ##Write-Host "Finding function returning $dir"
    return $dir
}

$rawData = Get-Content input.txt
$count = 0

#direction int: 1 for up, 2 for right, 3 for down, 4 for left. Can do a mod 4 and just continue incrementing since only turns right
$direction = Find-Direction

$startingLocation = Find-Carrot
$findNum = 0
while($direction -gt 0){
    $dir = $direction%4
    $direction = Find-Path($dir)
    $findNum ++
    #Write-Host "Finished path $findNum"
}

foreach($line in $rawData){
    $matches = [regex]::Matches($line, 'X')
    $count += $matches.Count
}

Write-Host "Guard visited $count distinct locations"