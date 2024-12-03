function Compare-Line{
    param (
        [string[]]$line
    )
    [bool]$safe=$true
    [int]$errors=0
    [int]$movement=0
    Write-Host "Parsing line of $line"
    for($i=1; $i -lt $line.Length; $i++){
        Write-Host "Line 10; in for loop"
        while($continue -and $safe){
            if([int]$string[$i] -gt [int]$string[$i-1]){
                Write-Host "Line 14; see increase"
                $movement++
            }elseif([int]$string[$i] -lt [int]$string[$i-1]){
                Write-Host "line 17; see decrease"
                $movement--
            }
            if([Math]::Abs($string[$i]-$string[$i-1]) -gt 3){
                Write-Host "line 21; see movement of more than 3"
                $errors++
            }
        }
        if($errors -gt 1){
            Write-Host "line 26; more than 1 error"
            $safe = $false
        }
        if(([Math]::Abs($movement) - $line.length) -ne 1){
            Write-Host "movement in wrong direction"
            $safe = $false
        }
        if($i -eq $line.length){
            if($safe){
                return $true
            }else{
                return $false
            }
        }
    }
}

$rawData = Get-Content example.txt
 <#Safe reports are lines where the numbers are either increasing or decreasing by between 1 and 3 through the whole line#>
$safeLines = 0

 foreach($line in $rawData){
    if(Compare-Line $line){
        $safeLines++
    }
    
 }
 Write-Host "Total number of safe lines is $safeLines"