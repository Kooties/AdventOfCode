$rawData = get-content input.txt
$total = 0

foreach($line in $rawData){
    $numArray = [System.Collections.ArrayList]@()
    $i=0
    while($i -lt $line.Length){
        if($line[$i] -match "\d"){
            #$numArray += $line[$i]
            if($numArray.length -eq 2){
                $numArray[1] = $line[$i]
            }else{
                $numArray += $line[$i]
            }
        }
        if($numArray.length -eq 1){
            $numArray += $numArray
        }
        $i++
    }
    #Write-Host "Value of line is $numArray as an array"
    $numString = ""
    foreach($num in $numArray){
        $numString += [string]$num
    }
    #Write-Host "Value of line is $numString as a string"
    $total += [int]$numString
    #Write-Host "New value of total is $total"
}
Write-Host "The full total is $total"