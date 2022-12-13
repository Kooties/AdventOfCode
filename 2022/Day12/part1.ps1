class Node{
    [bool]$isVisited
    [int]$distanceFromStart
    [int]$height
    [bool]$upBlocked
    [bool]$downBlocked
    [bool]$rightBlocked
    [bool]$leftBlocked
    Node(){
        $this.isVisited = $false
        $this.distanceFromStart = 2147483646
        $this.upBlocked = $false
        $this.downBlocked = $false
        $this.leftblocked = $false
        $this.rightblocked = $false
    }
    [void]checkEdges([int]$index,[int]$width,[System.Collections.ArrayList]$nodes){
        #where $index is the location of the node in the arraylist, $width is the width of the map, and $nodes is the Arraylist from the Map class
        if($index -lt $width){
            if(($nodes[$index-1].height - $this.height) -gt 1){
                $this.leftblocked = $true
            }elseif(($nodes[$index+1].height - $this.height) -gt 1){
                $this.rightblocked = $true
            }elseif(($nodes[$index+$width].height - $this.height) -gt 1){
                $this.downBlocked = $true
            }
            $this.upBlocked = $true
        }elseif(($index%$width -eq 0)){
            if(($nodes[$index+1].height - $this.height) -gt 1){
                $this.rightblocked = $true
            }elseif(($nodes[$index+$width].height - $this.height) -gt 1){
                $this.downBlocked = $true
            }elseif(($nodes[$index-$width].height - $this.height) -gt 1){
                $this.upBlocked = $true
            }
            $this.leftblocked = $true
        }elseif((($index+1)%$width) -eq 0){
            if(($nodes[$index-1].height - $this.height) -gt 1){
                $this.leftblocked = $true
            }elseif(($nodes[$index+$width].height - $this.height) -gt 1){
                $this.downBlocked = $true
            }elseif(($nodes[$index-$width].height - $this.height) -gt 1){
                $this.upBlocked = $true
            }
            $this.rightblocked = $true
        }elseif($index -gt ($width - $index)){
            if(($nodes[$index-1].height - $this.height) -gt 1){
                $this.leftblocked = $true
            }elseif(($nodes[$index+1].height - $this.height) -gt 1){
                $this.rightblocked = $true
            }elseif(($nodes[$index-$width].height - $this.height) -gt 1){
                $this.upBlocked = $true
            }
            $this.downBlocked = $true
        }else{
            if(($nodes[$index-1].height - $this.height) -gt 1){
                $this.leftblocked = $true
            }elseif(($nodes[$index+1].height - $this.height) -gt 1){
                $this.rightblocked = $true
            }elseif(($nodes[$index+$width].height - $this.height) -gt 1){
                $this.downBlocked = $true
            }elseif(($nodes[$index-$width].height - $this.height) -gt 1){
                $this.upBlocked = $true
            }
        }
    }
}

class Map{
    [System.Collections.ArrayList]$nodes
}

$rawData = Get-Content testinput.txt
$width = $rawData[0].length
$height = $rawData.length

$values = @{
    Start=0
    "a"=1
    "b"=2
    "c"=3
    "d"=4
    "e"=5
    "f"=6
    "g"=7
    "h"=8
    "i"=9
    "j"=10
    "k"=11
    "l"=12
    "m"=13
    "n"=14
    "o"=15
    "p"=16
    "q"=17
    "r"=18
    "s"=19
    "t"=20
    "u"=21
    "v"=22
    "w"=23
    "x"=24
    "y"=25
    "z"=26
    "End"=27
}


$map = [Map]::new()
$map.nodes = [System.Collections.ArrayList]@()
foreach($line in $rawData){
    for($i=0; $i -lt ($line.length-1); $i++){
        if($line[$i] -clike 'S'){
            $height = 0
        }elseif($line[$i] -clike 'E'){
            $height = 27
        }else{
            $height = $values[[string]$line[$i]]
        }
        $newNode = [Node]::new()
        $newNode.height = $height
        $null = $map.nodes.Add($newNode)
    }
}
#$width
for($i=0; $i -lt $map.nodes.count; $i++){
    $map.nodes[$i].checkEdges($i,$width,$map.nodes)
}
<#for($i=0; $i -lt $this.pixels.count; $i++){
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
        }#>
        $strings.clear()

$strings = [System.Collections.ArrayList]@()
$string = ""
for($i=0; $i -le $map.nodes.count; $i++){
    if(($i)%$width -eq ($width-1)){
        $string += $map.nodes[$i].height
        $string += "`n"
        $null = $strings.Add($string)
        $string = ""
    }elseif($i -eq ($map.nodes.count)){
        $string += $map.nodes[$i].height
        $string += "`n"
        $null = $strings.Add($string)
    }else{
    $string += $map.nodes[$i].height
    $string += ","
    }
}


