$rawData = get-content test2.txt
$total = 0
#$line = "one2threeight"
$values = "one","two","three","four","five","six","seven","eight","nine","1","2","3","4","5","6","7","8","9"

$rawData = "two1nine"
$rawData = "7one2threeight"
foreach($line in $rawData){
    $numArray = [System.Collections.ArrayList]@()
    [int]$indexOfFirst = -2
    [int]$indexOfLast= -2
    $val = ""
    foreach($value in $values){
        Write-Host "checking for $value in string $line"
        if(($index = $line.IndexOf($value)) -and ($index -ge 0)){
            Write-Host "Found at index $index"
            if($indexOfFirst -eq -2){
                Write-Host "No previous match; setting initial values"
                $indexOfFirst = $index
                $indexOfLast = $index
                Write-Host "Set first index to $indexOfFirst and last index to $indexOfLast"
                switch ($value) {
                    "one"{$val = "1"}
                    "two"{$val = "2"}
                    "three"{$val = "3"}
                    "four"{$val = "4"}
                    "five"{$val = "5"}
                    "six"{$val = "6"}
                    "seven"{$val = "7"}
                    "eight"{$val = "8"}
                    "nine"{$val = "9"}
                    "1"{$val = "1"}
                    "2"{$val = "2"}
                    "3"{$val = "3"}
                    "4"{$val = "4"}
                    "5"{$val = "5"}
                    "6"{$val = "6"}
                    "7"{$val = "7"}
                    "8"{$val = "8"}
                    "9"{$val = "9"}
                }
                $null = $numArray.Add($val)
                $null = $numArray.Add($val)
                Write-Host "numArray is currently $numArray"
            }elseif($index -gt $indexOfLast){
                $indexOfLast = $index
                Write-Host "Last index updated to $indexOfLast"
                switch ($value) {
                    "one"{$val = "1"}
                    "two"{$val = "2"}
                    "three"{$val = "3"}
                    "four"{$val = "4"}
                    "five"{$val = "5"}
                    "six"{$val = "6"}
                    "seven"{$val = "7"}
                    "eight"{$val = "8"}
                    "nine"{$val = "9"}
                    "1"{$val = "1"}
                    "2"{$val = "2"}
                    "3"{$val = "3"}
                    "4"{$val = "4"}
                    "5"{$val = "5"}
                    "6"{$val = "6"}
                    "7"{$val = "7"}
                    "8"{$val = "8"}
                    "9"{$val = "9"}
                }
                $numArray[1] = $val
                Write-Host "numArray is currently $numArray"
            }elseif($index -lt $indexOfFirst){
                $indexOfFirst = $index
                Write-Host "First index updated to $indexOfFirst"
                switch ($value) {
                    "one"{$val = "1"}
                    "two"{$val = "2"}
                    "three"{$val = "3"}
                    "four"{$val = "4"}
                    "five"{$val = "5"}
                    "six"{$val = "6"}
                    "seven"{$val = "7"}
                    "eight"{$val = "8"}
                    "nine"{$val = "9"}
                    "1"{$val = "1"}
                    "2"{$val = "2"}
                    "3"{$val = "3"}
                    "4"{$val = "4"}
                    "5"{$val = "5"}
                    "6"{$val = "6"}
                    "7"{$val = "7"}
                    "8"{$val = "8"}
                    "9"{$val = "9"}
                }
                $numArray[0] = $val
                Write-Host "numArray is currently $numArray"
            }
        }
    }
    $numString = ""
    foreach($num in $numArray){
        $numString += [string]$num
    }
    $total += [int]$numString
}

