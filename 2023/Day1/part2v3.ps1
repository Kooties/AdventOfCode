$rawData = get-content input.txt
$total = 0

foreach($line in $rawData){
    Write-Host "original line is $line"
    $line2 = $line.replace('one','o1ne').replace('two','t2wo').replace('three','th3ree').replace('four','fo4ur').replace('five','f5ive').replace('six','s6ix').replace('seven','sev7en').replace('eight','eig8th').replace('nine','ni9ne')
    
    Write-Host "Re-parsed line is $line2"

    $numArray = [System.Collections.ArrayList]@()
    $i=0
    while($i -lt $line2.Length){
        if($line2[$i] -match "\d"){
            #$numArray += $line[$i]
            if($numArray.length -eq 2){
                $numArray[1] = $line2[$i]
            }else{
                $numArray += $line2[$i]
            }
        }
        if($numArray.length -eq 1){
            $numArray += $numArray
        }
        $i++
    }
    Write-Host "Value of line is $numArray as an array"
    $numString = ""
    foreach($num in $numArray){
        $numString += [string]$num
    }
    $numArray.clear()
    Write-Host "Value of line is $numString as a string"
    $total += [int]$numString
    Write-Host "New value of total is $total"
}

Write-Host "The full total is $total"