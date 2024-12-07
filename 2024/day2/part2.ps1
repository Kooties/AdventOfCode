Function Compare-Line([string]$line){
    #Write-Host "Parsing next line"
    $lastNumber = 0
    $nextNumber = 0
    $allowedErrors = 1
    $reports = $line.split(" ")
    $isSafe = $true
    $increasing = $false
    $decreasing = $false
   $i = 0
   while(($i -lt ($reports.length)) -and ($isSafe)){
    #Write-Host "On value $i"
    if($i -eq 0){
        $lastNumber = [int]$reports[$i]
        $i++
        #"Value 1 of line is $lastNumber "
    }elseif($i -eq 1){
        #Write-Host "Parsing second value"
        $nextNumber = [int]$reports[$i]
        #Write-Host "Last value is $lastNumber"
        #Write-Host "Next value is $nextNumber"
        if($nextNumber -gt $lastNumber){
            #Write-Host "Line is increasing"
            $increasing = $true
            $decreasing = $false
            if([Math]::Abs($nextNumber - $lastNumber) -gt 3){
                if($allowedErrors -ne 0){
                    $allowedErrors--
                }else{
                    $isSafe = $false
                }
                #Write-Host "Jump of more than 3"
                
            }
        }elseif($nextNumber -lt $lastNumber){
            #Write-Host "Line is decreasing"
            $decreasing = $true
            $increasing = $false
            if([Math]::Abs($nextNumber - $lastNumber) -gt 3){
                #Write-Host "Jump of more than 3"
                if($allowedErrors -ne 0){
                    $allowedErrors--
                }else{
                    $isSafe = $false
                }
            }
        }elseif($nextNumber -eq $lastNumber){
            #Write-Host "Numbers are equal"
            if($allowedErrors -ne 0){
                $allowedErrors--
            }else{
                $isSafe = $false
            }
        }
        $lastNumber = [int]$reports[$i]
        $i++
    }elseif($increasing){
        #Write-Host "increasing elseif"
        $nextNumber = [int]$reports[$i]
        #Write-Host "next number is $nextNumber"
        if($nextNumber -le $lastNumber){
            if($allowedErrors -ne 0){
                $allowedErrors--
            }else{
                $isSafe = $false
            }
        }elseif([Math]::Abs($nextNumber - $lastNumber) -gt 3){
            #Write-Host "Jump of more than 3"
            if($allowedErrors -ne 0){
                $allowedErrors--
            }else{
                $isSafe = $false
            }
        }elseif($i -eq ($reports.length - 1)){
            #Write-Host "Line is safe"
            $safeLines ++
            $i = 50
        }else{
            $lastNumber = [int]$reports[$i]
            $i++
        }
    }elseif($decreasing){
        #Write-Host "decreasing elseif"
        $nextNumber = [int]$reports[$i]
        #Write-Host "next number is $nextNumber"
        if($nextNumber -ge $lastNumber){
            if($allowedErrors -ne 0){
                $allowedErrors--
            }else{
                $isSafe = $false
            }
        }elseif([Math]::Abs($nextNumber - $lastNumber) -gt 3){
            if($allowedErrors -ne 0){
                $allowedErrors--
            }else{
                $isSafe = $false
            }
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
Function New-Arraylist([string]$line,[int]$integer){
    $newLine = [System.Collections.ArrayList]@()
    for($i=0; $i -lt $line.length; $i++){
        if($i -ne $integer){
            $newLine.Add($value) | Out-Null
        }
    }
    return $newLine
}

$rawData = Get-Content example.txt
 <#Safe reports are lines where the numbers are either increasing or decreasing by between 1 and 3 through the whole line
 but you can remove ONE SINGLE REPORT to render the line safe#>
$safeLines = 0
$linesSafeWithChanges = 0

foreach($line in $rawData){
    if(Compare-Line($line)){
        $safeLines++
        Write-Host "Line $line is safe with no changes"
    }else{
        $isSafe = $false
        $reports = $line.split(" ")
        for($i = 0; $i -lt $reports.length; $i++){
            if(!$isSafe){
                $testLine = New-Arraylist($reports,$i)
                $isSafe = Compare-Line($testLine)
            }
        }
        if($isSafe){
            $linesSafeWithChanges++
        Write-Host "Line $line is safe WITH changes"
        }
    }
}
$totalSafe = $safeLines + $linesSafeWithChanges
Write-Host "No Changes: $safelines; One change: $linesSafeWithChanges; Total safe: $totalSafe"