Class Monkey{
    $inventory = [System.Collections.ArrayList]@()
}

$rawData = Get-Content testinput.txt
$rounds = 20

$m0inv = [System.Collections.ArrayList]@()
$m1inv = [System.Collections.ArrayList]@()
$m2inv = [System.Collections.ArrayList]@()
$m3inv = [System.Collections.ArrayList]@()
$m4inv = [System.Collections.ArrayList]@()
$m5inv = [System.Collections.ArrayList]@()
$m6inv = [System.Collections.ArrayList]@()
$m7inv = [System.Collections.ArrayList]@()

foreach($line in $rawData){
    $string = ""
    if($line.StartsWith("Monkey:")){
        $split = $line.split(" ")
        $iteration = [int]$split[1][0]
    }elseif($line.StartsWith("Starting items:")){
        $firstSplit = $line.split(' ')
        $numbers = $firstSplit[2..($firstSplit.length-1)]
        foreach($number in $numbers){
            switch ($iteration){
                0 {
                    $null = $m0inv.Add([int]$number)
                }
                1 {
                    $null = $m1inv.Add([int]$number)
                }
                2 {
                    $null = $m2inv.Add([int]$number)
                }
                3 {
                    $null = $m3inv.Add([int]$number)
                }
                4 {
                    $null = $m4inv.Add([int]$number)
                }
                5 {
                    $null = $m5inv.Add([int]$number)
                }
                6 {
                    $null = $m6inv.Add([int]$number)
                }
                7 {
                    $null = $m7inv.Add([int]$number)
                }
            } #end of switch statement
        }

    }elseif($line.startswith("Operation")){
        $split = $line.split(" ")
    }
}