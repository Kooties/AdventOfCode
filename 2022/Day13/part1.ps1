class TransmissionPair{
    [Transmission]$leftSide
    [Transmission]$rightSide
    [int]$numOpenRight
    [int]$numOpenLeft
    [bool]compare(){
        $left = $leftSide.packet
        $right = $rightSide.packet
        Write-Host "Compare $left vs $right"
        $index = 0
        $this.numOpenRight = ($rightSide.packet.length - $rightSide.packet.replace("[","").length)
        $this.numOpenLeft = ($leftSide.packet.length - $leftSide.packet.replace("[","").length)
        if($this.numOpenLeft -gt $this.numOpenRight){
            Write-Host "Right side will run out of items first - not in right order"
            return $false
        }

    }
}

class Transmission{
    [string]$packet
    [System.Collections.ArrayList]$values
}



$rawData = Get-Content testinput.txt
$regex = '\[((\d,?){1,}(\s){0,}(,){0,}\],?)'
$numTransmissions = 0
foreach($line in $rawData){
    $side = [Transmission]::new()
    $side.values = [System.Collections.ArrayList]@()
    $side.packet = $line
    while($line match $regex){
        $range = [System.Collections.ArrayList]@()
        $string = $line -match $regex
        foreach($char in $string){
            if(($char -match "[\d]")){
                $null = $range.Add([int]$char)
            }
        }
        $null = $side.values.Add($range)
        $range.clear()
        $line = $line -replace $regex
    }


}