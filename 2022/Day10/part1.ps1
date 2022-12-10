$rawData = Get-Content input.txt
$currentSum = 0
$cycle = 1
$x = 1
$cycleNumber = 40
$g = 1
foreach($line in $rawData){
    $data = $line.split(" ")
    $command = [string]$data[0]
    Write-Host "$g line is $line"
    switch($command){
        {$_.StartsWith("addx")}{
            $number = [int]$data[1]
            Write-Host "Adding $number to x"
            $cycle++
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
                Write-Host "Cycle $cycle x value is $x; thing is $thing; to make the current sum $currentSum"
            }
            $cycle++
            $x += $number
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
                $thing = ($x*$cycle)
                Write-Host "Cycle $cycle x value is $x; thing is $thing; to make the current sum $currentSum"
            }
            Write-Host "Value of x is $x"
        }
        {$_.StartsWith("noop")}{
            $cycle++
            if(($cycle -eq 20) -or (($cycle-20)%$cycleNumber -eq 0)){
                $currentSum += ($x*$cycle)
                $thing = ($x*$cycle)
                Write-Host "Cycle $cycle x value is $x; thing is $thing; to make the current sum $currentSum"
            }
            Write-Host "Value of x is $x"
        }
    }
    $g++
}

Write-Host $currentSum