<#class Pixel{
    [bool]$isLit
    [void]TurnOn(){
        $this.isLit = $true
    }
    [void]TurnOff(){
        $this.isLit = $false
    }
}#>

$rawData = Get-Content testinput.txt
$cycle = 0
$x = 1
$width = 40
$g = 0
<#[System.Collections.ArrayList]$widePixels = @{}
[System.Collections.ArrayList]$display = @{}#>
$row1 = New-Object string[] $width
$row2 = New-Object string[] $width
$row3 = New-Object string[] $width
$row4 = New-Object string[] $width
$row5 = New-Object string[] $width
$row6 = New-Object string[] $width

<#for($j=0; $j -lt ($width*6); $j++){
    $newPixel = [Pixel]::new()
    $null = $display.Add($newPixel)
}#>

foreach($line in $rawData){
    $data = $line.split(" ")
    $command = [string]$data[0]
    switch($command){
        {$_.StartsWith("addx")}{
            $number = [int]$data[1]
            $cycle++
            Write-Host "Start cycle $cycle; begin executing $line"
            $xcoordinate = (($cycle%$width) -1)
            $ycoordinate = [int]($x/$width)
            $cyclex = $cycle%$width
            $cycley = [int]($cycle/$width)
            $xdiff = $cyclex - $xcoordinate

            Write-Host "Cycle's X Coordinate is $cyclex and Y Coordinate is $cycley`nCenter of Sprite is at $xcoordinate,$ycoordinate"
            if(($cycley -eq $ycoordinate) -and ([Math]::Abs($xdiff) -le 1)){
                Write-Host "Write cycle is within Sprite - writing # at $xcoordinate,$ycoordinate"
                switch([int]($cycley)){
                    0 {
                        $row1[$xcoordinate] = '#'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '#'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '#'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '#'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '#'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '#'
                        break
                    }
                }
            }else{
                Write-Host "Write cycle is not within Sprite - writing ."
                switch([int]($cycle/$width)){
                    0 {
                        $row1[$xcoordinate] = '.'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '.'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '.'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '.'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '.'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '.'
                        break
                    }
                }
            }
            $cycle++
            Write-Host "Start cycle 2 - continuing to execute $line"
            
            $cyclex = $cycle%$width
            $cycley = [int]($cycle/$width)
            $xdiff = $cyclex - $xcoordinate
            Write-Host "Cycle's X Coordinate is $cyclex and Y Coordinate is $cycley`nCenter of Sprite is at $xcoordinate,$ycoordinate"
            
            if(($cycley -eq $ycoordinate) -and ([Math]::Abs($xdiff) -le 1)){
                Write-Host "Write cycle is within Sprite - writing #"
                switch([int]($cycle/$width)){
                    0 {
                        $row1[$xcoordinate] = '#'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '#'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '#'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '#'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '#'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '#'
                        break
                    }
                }
            }else{
                Write-Host "Write cycle is not within Sprite - writing ."
                switch([int]($cycle/$width)){
                    0 {
                        $row1[$xcoordinate] = '.'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '.'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '.'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '.'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '.'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '.'
                        break
                    }
                }
            }
            $x += $number
        }
        {$_.StartsWith("noop")}{
            $cycle++
            
            if(($cycley -eq $ycoordinate) -and ([Math]::Abs($xdiff) -le 1)){
                Write-Host "Write cycle is within Sprite - writing #"
                switch([int]($cycle/$width)){
                    0 {
                        $row1[$xcoordinate] = '#'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '#'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '#'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '#'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '#'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '#'
                        break
                    }
                }
            }else{
                Write-Host "Write cycle is not within Sprite - writing ."
                switch([int]($cycle/$width)){
                    0 {
                        $row1[$xcoordinate] = '.'
                        break
                    }
                    1 {
                        $row2[$xcoordinate] = '.'
                        break
                    }
                    2 {
                        $row3[$xcoordinate] = '.'
                        break
                    }
                    3 {
                        $row4[$xcoordinate] = '.'
                        break
                    }
                    4 {
                        $row5[$xcoordinate] = '.'
                        break
                    }
                    5 {
                        $row6[$xcoordinate] = '.'
                        break
                    }
                }
            }
        }
    }
    $g++
}

$r1string = ""
$r2string = ""
$r3string = ""
$r4string = ""
$r5string = ""
$r6string = ""

foreach($char in $row1){
    $r1string += $char
}
foreach($char in $row2){
    $r2string += $char
}
foreach($char in $row3){
    $r3string += $char
}
foreach($char in $row4){
    $r4string += $char
}
foreach($char in $row5){
    $r5string += $char
}
foreach($char in $row6){
    $r6string += $char
}

Write-Host "$r1string`n$r2string`n$r3string`n$r4string`n$r5string`n$r6string"

