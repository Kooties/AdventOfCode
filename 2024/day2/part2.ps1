Function Compare-Line([string]$line){
    ##Write-Host "Parsing next line"
    $lastNumber = 0
    $nextNumber = 0
    $reports = $line.split(" ")
    $isSafe = $true
    $increasing = $false
    $decreasing = $false
   $i = 0
   while(($i -lt ($reports.length)) -and ($isSafe)){
    ##Write-Host "On value $i"
    if($i -eq 0){
        $lastNumber = [int]$reports[$i]
        $i++
        #"Value 1 of line is $lastNumber "
    }elseif($i -eq 1){
        ##Write-Host "Parsing second value"
        $nextNumber = [int]$reports[$i]
        ##Write-Host "Last value is $lastNumber"
        ##Write-Host "Next value is $nextNumber"
        if($nextNumber -gt $lastNumber){
            ##Write-Host "Line is increasing"
            $increasing = $true
            $decreasing = $false
            if([Math]::Abs($nextNumber - $lastNumber) -gt 3){
                
                    $isSafe = $false
                
                ##Write-Host "Jump of more than 3"
                
            }
        }elseif($nextNumber -lt $lastNumber){
            ##Write-Host "Line is decreasing"
            $decreasing = $true
            $increasing = $false
            if([Math]::Abs($nextNumber - $lastNumber) -gt 3){
                ##Write-Host "Jump of more than 3"
                
                    $isSafe = $false
                
            }
        }elseif($nextNumber -eq $lastNumber){
            ##Write-Host "Numbers are equal"
            
                $isSafe = $false
            
        }
        $lastNumber = [int]$reports[$i]
        $i++
    }elseif($increasing){
        ##Write-Host "increasing elseif"
        $nextNumber = [int]$reports[$i]
        ##Write-Host "next number is $nextNumber"
        if($nextNumber -le $lastNumber){
            
                $isSafe = $false
            
        }elseif([Math]::Abs($nextNumber - $lastNumber) -gt 3){
            ##Write-Host "Jump of more than 3"
            
                $isSafe = $false
            
        }elseif($i -eq ($reports.length - 1)){
            ##Write-Host "Line is safe"
            $safeLines ++
            $i = 50
        }else{
            $lastNumber = [int]$reports[$i]
            $i++
        }
    }elseif($decreasing){
        ##Write-Host "decreasing elseif"
        $nextNumber = [int]$reports[$i]
        ##Write-Host "next number is $nextNumber"
        if($nextNumber -ge $lastNumber){
            
                $isSafe = $false
            
        }elseif([Math]::Abs($nextNumber - $lastNumber) -gt 3){
            
                $isSafe = $false
            
        }elseif($i -eq ($reports.length - 1)){
            $safeLines ++
            $i = 50
        }else{
            $lastNumber = [int]$reports[$i]
            $i++
        }
    }
   }
   return $isSafe
}

Function Create-ArrayList([string]$thing,[int]$y){
    $data = $thing.split(" ")
    $returnValue = [System.Collections.ArrayList]@()
    for($x=0; $x -lt $data.count; $x++){
        #Write-Host "X is $x and Y is $y"
        if($x -ne $y){
            $returnValue.Add($data[$x]) | Out-Null
        }else{
            ##Write-Host "Removing " $data[$x] " from array"
        }
    }
    return $returnValue
}

$rawData = Get-Content input.txt
 <#Safe reports are lines where the numbers are either increasing or decreasing by between 1 and 3 through the whole line
 but you can remove ONE SINGLE REPORT to render the line safe#>
$safeLines = 0
$linesSafeWithChanges = 0

foreach($line in $rawData){
    if(Compare-Line($line)){
        $safeLines++
        #Write-Host "Line $line is safe with no changes"
    }else{
        $isSafe = $false
        $reports = [string]$line.split(" ")
        $i=0
        while($i -lt $reports.length){
            #Write-Host "I is currently $i"
            if(!$isSafe){
                $testLine = Create-ArrayList -thing $line -y $i
                #Write-Host "Checking change to $testLine"
                $isSafe = Compare-Line($testLine)
                #Write-Host "$testLine safety is currently $isSafe"
                $i++
            }else{
                $i = $reports.length
                $linesSafeWithChanges++
                #Write-Host "Line $line is safe WITH changes"
                #Write-Host "Changed to $testLine"
            }
        }
    }
}
$totalSafe = $safeLines + $linesSafeWithChanges
Write-Host "No Changes: $safelines; One change: $linesSafeWithChanges; Total safe: $totalSafe"