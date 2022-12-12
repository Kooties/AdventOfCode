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
            if(($i+1)%$width -eq 0){
                $string += "`n"
                $null = $strings.Add($string)
                $string = ""
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

$rawData = Get-Content testinput.txt

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
foreach($line in $rawData){
    $data = $line.split(" ")
    $command = [string]$data[0]

    switch($command){
        {$_.StartsWith("addx")}{
            $number = [int]$data[1]
            $cycle++
            Write-Host "this is where the cycle should go up"
            if(([Math]::Abs($cycle - $x) -le 1)){
                $display.Pixels[$x].TurnOn()
            }else{
                $display.Pixels[$x].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$x].isLit
            Write-Host "Value of x is $x and cycle is $y. Pixel at position x is $pixelValue"
            
            $cycle++
            Write-Host "this is where the cycle should go up"
            if(([Math]::Abs($cycle - $x) -le 1)){
                $display.Pixels[$x].TurnOn()
            }else{
                $display.Pixels[$x].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$x].isLit
            Write-Host "Value of x is $x and cycle is $y. Pixel at position x is $pixelValue"
            $x += $number
            Write-Host "X increased to $x"
            
        }
        {$_.StartsWith("noop")}{
            $cycle++
            Write-Host "this is where the cycle should go up"
            if(([Math]::Abs($cycle - $x) -le 1)){
                $display.Pixels[$x].TurnOn()
            }else{
                $display.Pixels[$x].TurnOff()
            }
            [bool]$pixelValue = $display.Pixels[$x].isLit
            Write-Host "Value of x is $x and cycle is $y. Pixel at position x is $pixelValue"
        }
    }
    $g++
}
$display.print($width)

