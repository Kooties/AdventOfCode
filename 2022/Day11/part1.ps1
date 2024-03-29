class Monkey{
    [int]$divisor
    [int]$trueMonkey
    [int]$falseMonkey
    [int]$numInspections
    [System.Collections.ArrayList]$inventory
    [string]$operand
    [string]$num
    [void]DoFunction([int]$int,[System.Collections.ArrayList]$monkeys){
        #Write-Host "Monkey inspects an item with a worry level of $int"
        if(($this.num).StartsWith("old")){
            $workingNumber = $int
        }else{
            $workingNumber = [int]$this.num
        }
        $result = 0
        switch($this.operand){
            {$_ -like "*"} {
                $result = ($int * $workingNumber)
            }
            {$_ -like "/"} {
                $result = ($int / $workingNumber)
            }
            {$_ -like "+"} {
                $result = ($int + $workingNumber)
            }
            {$_ -like "-"} {
                $result = ($int - $workingNumber)
            }
        }
        #Write-Host "This causes our worry to spike to $result"
        $this.numInspections ++
        $newWorryLevel = ($result-$result%3)/3
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
    [void]throwthing([int]$thing,[int]$monkeyNumber,[System.Collections.ArrayList]$monkeys,[int]$int){
        [int]$worryLevel = ($thing-$thing%3)/3
        $null = $monkeys[$monkeyNumber].Inventory.Add($worryLevel)
        #Write-Host "Threw item with worry level $worryLevel to monkey $monkeyNumber"
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
$rounds = 20
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
            $monkeys[$iteration].AddInventory([int]$thing)
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

for($i=0; $i -lt $rounds; $i++){
    #Write-Host "Beginning round $i"
    for($j=0; $j -lt $monkeys.count; $j++){
        for($k=0; $k -lt $monkeys[$j].inventory.count; $k++){
            $monkeys[$j].DoFunction($monkeys[$j].inventory[$k],$monkeys)
        }
        $monkeys[$j].fixinventory()
    }
}
$mostInspections = 0
$secondMost = 0
for($l = 0; $l -lt $monkeys.count; $l++){
    $x = $monkeys[$l].numInspections
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

return $monkeyBusiness