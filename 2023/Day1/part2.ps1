$rawData = get-content test2.txt
$total = 0

foreach($data in $rawData){
    $numArray = [System.Collections.ArrayList]@()
    $i=0

    $data -split {$_ -eq "(1)" -or $_ -eq "(2)" -or $_ -eq "(3)" -or $_ -eq "(4)" -or $_ -eq "(5)" -or $_ -eq "(6)" -or $_ -eq "(7)" -or $_ -eq "(8)" -or $_ -eq "(9)"-or $_ -eq "(one)"-or $_ -eq "(two)"-or $_ -eq "(three)"-or $_ -eq "(four)"-or $_ -eq "(five)"-or $_ -eq "(six)"-or $_ -eq "(seven)"-or $_ -eq "(eight)"-or $_ -eq "(nine)"}
    Write-Host "Data split is $data"
    $data -split {"(1)" -or "(2)" -or "(two)" -or "(nine)"}
    Write-Host "Second Data Split is $data"
    
    
    switch ($data.count){
        1{}
        default{    
            while($numArray.Count -eq 0){
                switch ($data[$i]) {
                    "one"{$numArray.Add("1"); Break}
                    "two"{$numArray.Add("2"); Break}
                    "three"{$numArray.Add("3"); Break}
                    "four"{$numArray.Add("4"); Break}
                    "five"{$numArray.Add("5"); Break}
                    "six"{$numArray.Add("6"); Break}
                    "seven"{$numArray.Add("7"); Break}
                    "eight"{$numArray.Add("8"); Break}
                    "nine"{$numArray.Add("9"); Break}
                    "1"{$numArray.Add("1"); Break}
                    "2"{$numArray.Add("2"); Break}
                    "3"{$numArray.Add("3"); Break}
                    "4"{$numArray.Add("4"); Break}
                    "5"{$numArray.Add("5"); Break}
                    "6"{$numArray.Add("6"); Break}
                    "7"{$numArray.Add("7"); Break}
                    "8"{$numArray.Add("8"); Break}
                    "9"{$numArray.Add("9"); Break}
                }
                $i++
            }
            $i=$data.Count
            while($numArray.Count -eq 1){
                switch ($data[$i]) {
                    "one"{$numArray.Add("1"); Break}
                    "two"{$numArray.Add("2"); Break}
                    "three"{$numArray.Add("3"); Break}
                    "four"{$numArray.Add("4"); Break}
                    "five"{$numArray.Add("5"); Break}
                    "six"{$numArray.Add("6"); Break}
                    "seven"{$numArray.Add("7"); Break}
                    "eight"{$numArray.Add("8"); Break}
                    "nine"{$numArray.Add("9"); Break}
                    "1"{$numArray.Add("1"); Break}
                    "2"{$numArray.Add("2"); Break}
                    "3"{$numArray.Add("3"); Break}
                    "4"{$numArray.Add("4"); Break}
                    "5"{$numArray.Add("5"); Break}
                    "6"{$numArray.Add("6"); Break}
                    "7"{$numArray.Add("7"); Break}
                    "8"{$numArray.Add("8"); Break}
                    "9"{$numArray.Add("9"); Break}
                }
                $i--
            }
        }
    }
    







    Write-Host "Value of line is $numArray as an array"
    $numString = ""
    foreach($num in $numArray){
        $numString += [string]$num
    }
    #Write-Host "Value of line is $numString as a string"
    $total += [int]$numString
    #Write-Host "New value of total is $total"
}
Write-Host "The full total is $total"