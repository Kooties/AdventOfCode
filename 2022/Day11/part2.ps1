class Monkey{
    [int]$divisor
    [int]$trueMonkey
    [int]$falseMonkey
    [int]$numInspections
    [System.Collections.ArrayList]$inventory
    [string]$operand
    [string]$num
    [void]DoFunction([int]$int,[System.Collections.ArrayList]$monkeys,[int]$modulo){
        #Write-Host "Monkey inspects an item with a worry level of $int"
        if(($this.num).StartsWith("old")){
            [int]$workingNumber = $int
        }else{
            [int]$workingNumber = [int]$this.num
        }
        $result = 0
        switch($this.operand){
            {$_ -like "*"} {
                [int]$result = (($int * $workingNumber)%$modulo)
            }
            {$_ -like "/"} {
                [int]$result = ($int / $workingNumber)
            }
            {$_ -like "+"} {
                [int]$result = ($int + $workingNumber)
            }
            {$_ -like "-"} {
                [int]$result = ($int - $workingNumber)
            }
        }
        #Write-Host "This causes our worry to spike to $result"
        $this.numInspections ++
        while($result -gt $modulo){
            $result = $result%$modulo
        }
        [int]$newWorryLevel = $result
        #Write-Host "Monkey gets bored and worry level drops to $newWorryLevel"
        if(($newWorryLevel%$this.divisor) -eq 0){
            $monk = $this.truemonkey
            $null = $monkeys[$this.truemonkey].inventory.add($newWorryLevel)
            #Write-Host "Threw item with worry level $newWorryLevel to $monk"
        }else{
            $monk = $this.falsemonkey
            $null = $monkeys[$this.falsemonkey].inventory.add($newWorryLevel)
            #Write-Host "Threw item with worry level $newWorryLevel to $monk"
        }
        $index = $this.inventory.IndexOf($int)
        $null = $this.inventory[$index] = 0
    }
    [void]fixinventory(){
        $zero = 0
        while($this.inventory -contains $zero){
            $this.inventory.Remove($zero)
        }
    }
    [void]AddInventory([int]$thing){
        $null = $this.inventory.Add($thing)
    }
}


$rawData = Get-Content input.txt
$rounds = 10000
$monkeys = [System.Collections.ArrayList]@()
$iteration = 0

foreach($line in $rawData){
    if($line.StartsWith("Monkey")){
        $split = $line.split(" ")
        $iteration = ([int]$split[1][0] -48)
        $newMonkey = [Monkey]::New()
        $null = $monkeys.add($newMonkey)
        $monkeys[$iteration].inventory = [System.Collections.ArrayList]@()
        $monkeys[$iteration].numInspections = 0
    }elseif($line.StartsWith("  Starting items:")){
        $subby = $line.substring(18,$line.length-18)
        $split = $subby.split(",\s")
        foreach($thing in $split){
            [int]$thingx = $thing
            [int]$thingy = $thingx
            $monkeys[$iteration].AddInventory($thingy)
        }
    }elseif($line.startswith("  Operation")){
        $split = $line.split(" ") 
        $monkeys[$iteration].Operand = $split[-2]
        $monkeys[$iteration].num = $split[-1]
    }elseif($line.startswith("  Test")){
        $split = $line.split(" ")
        $monkeys[$iteration].divisor = [int]$split[5]
    }elseif($line.Startswith("    If true")){
        $split = $line.split(" ")
        $monkeys[$iteration].truemonkey = $split[-1]
    }elseif($line.Startswith("    If false")){
        $split = $line.split(" ")
        $monkeys[$iteration].falsemonkey = $split[-1]
    }else{
        
    }
}

$modulo=1
foreach($monkey in $monkeys){
    $modulo *= $monkey.divisor
}

for($i=0; $i -lt $rounds; $i++){
    for($j=0; $j -lt $monkeys.count; $j++){
        for($k=0; $k -lt $monkeys[$j].inventory.count; $k++){
            [int]$intput = $monkeys[$j].inventory[$k]
            #Write-Host "Monkey $j item $k is $intput; starting inspection"
            $monkeys[$j].DoFunction($intput,$monkeys,$modulo)
        }
        $monkeys[$j].fixinventory()
    }
}
$mostInspections = 0
$secondMost = 0
for($l = 0; $l -lt $monkeys.count; $l++){
    $x = $monkeys[$l].numInspections
    Write-Host "Monkey $l inspected items $x times."
    if($x -gt $secondMost){
        if($x -gt $mostInspections){
            $secondMost = $mostInspections
            $mostInspections = $x
        }else{
            $secondMost = $x
        }
    }
}

$monkeyBusiness = $mostInspections*$secondMost

Write-Host "`nMost monkey business was $monkeyBusiness"

return $monkeyBusiness