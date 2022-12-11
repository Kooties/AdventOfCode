class Monkey{
    [int]$divisor
    [int]$trueMonkey
    [int]$falseMonkey 
    [int]$numInspections
    [System.Collections.ArrayList]$inventory
    [string]$operand
    [string]$num
    [int]DoFunction([int]$iteration){
        if(($this.num).StartsWith("old")){
            $this.num = $this.inventory[$iteration]
        }
        $result = 0
        switch($this.operand){
            {$_ -like "*"} {
                $result = ($this.inventory[$iteration] * [int] $this.num)
            }
            {$_ -like "/"} {
                $result = ($this.inventory[$iteration] / [int] $this.num)
            }
            {$_ -like "+"} {
                $result = ($this.inventory[$iteration] + [int] $this.num)
            }
            {$_ -like "-"} {
                $result = ($this.inventory[$iteration] - [int] $this.num)
            }
        }
        $this.numInspections ++
        return $result
    }
    [void]throwthing([int]$thing,[int]$monkeyNumber,[System.Collections.ArrayList]$monkeys){
        $null = $monkeys[$monkeyNumber].Inventory.Add([int]$thing/3)
        $index = $this.inventory.IndexOf($thing)
        $this.inventory[$index] = 0
    }
    [void]fixinventory(){
        $this.inventory.Remove(0)
    }
    [void]AddInventory([int]$thing){
        $this.inventory.Add($thing)
    }
}


$rawData = Get-Content testinput.txt
$rounds = 20
$monkeys = [System.Collections.ArrayList]@()

for($i=0; $i -lt 7; $i++){
    $newMonkey = [Monkey]::New()
    $null = $monkeys.add($newMonkey)
}
$iteration = 0

foreach($line in $rawData){
    if($line.StartsWith("Monkey:")){
        $split = $line.split(" ")
        $iteration = ([int]$split[1][0] -48)
    }elseif($line.StartsWith("Starting items:")){
        $firstSplit = $line.split(' ')
        foreach($thing in $firstSplit){
            $number = 0
            if(!($thing.StartsWith("Starting")) -and !($thing.StartsWith("items"))){
                if($thing -match ','){
                    $number = [int]$thing.substring(0,$thing.length)
                }else{
                    $number = [int]$thing
                }
                $monkeys[$iteration].AddInventory($number)
            }
        }
    }elseif($line.startswith("Operation")){
        $split = $line.split(" ") #4 and 5 are operand and number, respectively
        $monkeys[$iteration].Operand = $split[4]
        $monkeys[$iteration].num = $split[5]
    }elseif($line.startswith("test")){
        $split = $line.split(" ")
        $monkeys[$iteration].divisor = [int]$split[3]
    }elseif($line.Startswith("If true")){
        $split = $line.split(" ")
        $monkeys[$iteration].truemonkey = $split[5]
    }elseif($line.Startswith("If false")){
        $split = $line.split(" ")
        $monkeys[$iteration].falsemonkey = $split[5]
    }else{
    }
}

return $monkeys