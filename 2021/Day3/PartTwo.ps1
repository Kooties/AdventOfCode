$data = Get-Content input.txt
$columns = 0..($data[0].Length - 1)

$ones = 0
$zeroes = 0

$oxnum = [System.Collections.ArrayList]@()
$co2num = [System.Collections.ArrayList]@()
$oxnum2 = [System.Collections.ArrayList]@()
$co2num2 = [System.Collections.ArrayList]@()
$finalOx
$finalco2

foreach($datum in $data){
    $null = $oxnum.Add($datum)
    $null = $co2num.Add($datum)
}

foreach($column in $columns){
    foreach($datum in $data){
        if($datum[$column] -like "0"){
            $zeroes++
        }else{
            $ones++
        }
    }
    $num = $column+1
    Write-Host "Bit Location $num has $zeroes 0s and $ones 1s"
    if($zeroes -gt $ones){
        foreach($ox in $oxnum){
            if($ox[$column] -like "0"){
               $null = $oxnum2.Add($ox)
            }
        }
        foreach($co2 in $co2num){
            if($co2[$column] -like "1"){
                $null = $co2num2.Add($co2)
            }
        }
        
        
        <#foreach($datum in $data){
            if($datum[$column] -like "0"){
                if(($co2num.contains($datum)) -and ($co2num.Count -gt 1)){
                    $null = $co2num.Remove($datum)
                }
            }
            if($datum[$column] -like "1"){
                if(($oxnum.Contains($datum)) -and ($oxnum.count -gt 1)){
                    $null = $oxnum.Remove($datum)
                }
            }
        }#>
    }else{
        
        foreach($ox in $oxnum){
            if($ox[$column] -like "1"){
               $null = $oxnum2.Add($ox)
            }
        }
        foreach($co2 in $co2num){
            if($co2[$column] -like "0"){
               $null = $co2num2.Add($co2)
            }
        }
        
        
        
        <#foreach($datum in $data){
            if($datum[$column] -like "1"){
                if(($co2num.contains($datum)) -and ($co2num.Count -gt 1)){
                    $null = $co2num.Remove($datum)
                }
            }
            if($datum[$column] -like "0"){
                if(($oxnum.Contains($datum)) -and ($oxnum.count -gt 1)){
                    $null = $oxnum.Remove($datum)
                }
            }
        }#>
    }
    $ones = 0
    $zeroes = 0
    $co2num.clear()
    $oxnum.clear()
    foreach($thing in $co2num2){
        $null = $co2num.Add($thing)
    }
    foreach($thing2 in $oxnum2){
        $null = $oxnum.Add($thing2)
    }
    $co2num2.clear()
    $oxnum2.clear()
    if($oxnum.count -eq 1){
        $finalOx = [convert]::ToInt32($oxnum[0],2)
    }
    if($co2num.count -eq 1){
        $finalco2 = [convert]::ToInt32($co2num[0],2)
    }
}
  
#$oxygenRating = [Convert]::ToInt32($oxnum[0],2)
#$co2Rating = [Convert]::ToInt32($co2num[0],2)

$lifeSupportRating = $finalOx * $finalco2

Write-Host "Life Support Rating is $lifeSupportRating"