class Pixel{
    [bool]$isLit
    [void]TurnOn(){
        $this.isLit = $true
    }
    [void]TurnOff(){
        $this.isLit = $false
    }
}

class Display{
    [System.Collections.ArrayList]$pixels
    [void]Print([int]$width){
        $strings = [System.Collections.ArrayList]@()
        $string = ""
        for($i=0; $i -lt $this.pixels.count; $i++){
            if(($i)%$width -eq 0){
                $string += "`n"
                $null = $strings.Add($string)
                $string = ""
            }elseif($i -eq ($this.pixels.count -1)){
                $string += "`n"
                $null = $strings.Add($string)
            }
            if($this.pixels[$i].isLit){
                $string += "#"
            }else{
                $string += "."
            }
        }
        Write-Host $strings
    }
}

$rawData = Get-Content input.txt

$x = 1
$width = 40
$g = 0

$display = [Display]::new()
$display.pixels = [System.Collections.ArrayList]@()

for($j=0; $j -lt ($width*6); $j++){
    $newPixel = [Pixel]::new()
    $null = $display.pixels.add($newPixel)
}
$cycle = 0
$numLitPixels = 0
foreach($line in $rawData){
    $data = $line.split(" ")
    $command = [string]$data[0]
    Write-Host "Parsing $line"
    switch($command){
        {$_.StartsWith("addx")}{
            $number = [int]$data[1]
            $cycle++
            $mod = ($cycle-1)%($width)
            $row = [int]($cycle/$width)
            $abso = ([Math]::Abs($mod - $x))
            Write-Host "Absolute value is $abso for ($x - $cycle)"
            if($abso -le 1){
                $display.Pixels[$cycle-1].TurnOn()
                $numLitPixels++
            }else{
                $display.Pixels[$cycle-1].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$cycle-1].isLit
            Write-Host "Value of x is $x and cycle is $cycle. Pixel at position $cycle is $pixelValue"
            
            $cycle++
            $mod = ($cycle-1)%($width)
            $abso = ([Math]::Abs($mod - $x))
            Write-Host "Absolute value is $abso for ($x - $cycle)"
            if($abso -le 1){
                $display.Pixels[$cycle-1].TurnOn()
                $numLitPixels++
            }else{
                $display.Pixels[$cycle-1].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$cycle-1].isLit
            Write-Host "Value of x is $x and cycle is $cycle. Pixel at position $cycle is $pixelValue"
            $x += $number
            Write-Host "X changed to to $x"
            
        }
        {$_.StartsWith("noop")}{
            $cycle++
            $mod = ($cycle-1)%($width)
            $abso = ([Math]::Abs($mod - $x))
            Write-Host "Absolute value is $abso for ($x - $cycle)"
            if($abso -le 1){
                $display.Pixels[$cycle-1].TurnOn()
                $numLitPixels++
            }else{
                $display.Pixels[$cycle-1].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$cycle-1].isLit
            Write-Host "Value of x is $x and cycle is $cycle. Pixel at position $cycle is $pixelValue"
        }
    }
    $g++
}
$display.print($width)
Write-Host "Number of pixels lit should be $numLitPixels"
