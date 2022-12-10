$rawData = Get-Content input.txt
$currentSum = 0
$cycle = 1
$x = 1
$cycleNumber = 40
$g = 1
foreach($line in $rawData){
    $data = $line.split(" ")
    $command = [string]$data[0]
    switch($command){
        {$_.StartsWith("addx")}{
            $number = [int]$data[1]
            $cycle++
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
            }
            $cycle++
            $x += $number
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
                $thing = ($x*$cycle)
            }
        }
        {$_.StartsWith("noop")}{
            $cycle++
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
                $thing = ($x*$cycle)
            }
        }
    }
    $g++
}

Write-Host $currentSum