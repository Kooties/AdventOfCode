Class Monkey{
    $inventory = [System.Collections.ArrayList]@()
    $operand = ''
    $num = ''
    [int]$divisor
    [int]$trueMonkey
    [int]$falseMonkey 

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
        return $result
    }

    [void]throwthing([int]$thing,[int]$monkeyNumber,[System.Collections.ArrayList]$monkeys){
        $null = $monkeys[$monkeyNumber].Inventory.Add($thing)
        $index = $this.inventory.IndexOf($thing)
        $this.inventory[$index] = 0
    }
    [void]fixinventory(){
        $this.inventory.Remove(0)
    }
}

function Get-PostInspectionWorry{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [int]$worryLevel
    )
    return [int]($worryLevel/3)
}

$rawData = Get-Content testinput.txt
$rounds = 20
$monkeys = [System.Collections.ArrayList]@()

for($i=0; $i -lt 7; $i++){
    $newMonkey = [Monkey]::New()
    $null = $monkeys.add($newMonkey)
}

foreach($line in $rawData){
    $string = ""
    if($line.StartsWith("Monkey:")){
        $split = $line.split(" ")
        $iteration = [int]$split[1][0]
    }elseif($line.StartsWith("Starting items:")){
        $firstSplit = $line.split(' ')
        $numbers = $firstSplit[2..($firstSplit.length-1)]
        foreach($number in $numbers){
            $null = $monkeys[$iteration].inventory.add($number)
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
    }
}