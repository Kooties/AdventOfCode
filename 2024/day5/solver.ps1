function verify-order([System.Collections.ArrayList]$rules,[string]$order){
    $print = $true
    $orderSplit = $order.split(',')
    foreach($rule in $rules){
        #Write-Host "Checking rule $rule"
        $pages = $rule.split('|')
        if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
            if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                #Write-Host "Rule Broken; setting print to False"
                $print = $false
            }
        }
    }
    return $print
}

#first section is rules, second section is orders
#result should be middle printed page numbers of each correct order summed
#second section: 5647 too high
$rawData = Get-Content example.txt

$rules = [System.Collections.ArrayList]@()
$orders = [System.Collections.ArrayList]@()
$badOrders = [System.Collections.ArrayList]@()
$sumCorrect = 0
$sumIncorrect = 0

foreach($line in $rawData){
    if($line -match '\d?\|\d?'){
        $rules.Add($line)| Out-Null
    }elseif($line -match '\d?,'){
        $orders.Add($line)| Out-Null
    }
}
$rules.sort()

foreach($order in $orders){
    #Write-Host "Parsing order $order"
    $print = $true
    $orderSplit = $order.split(',')
    foreach($rule in $rules){
        #Write-Host "Checking rule $rule"
        $pages = $rule.split('|')
        if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
            if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                #Write-Host "Rule Broken; setting print to False"
                $print = $false
            }
        }
    }
    if($print){
        #Write-Host "Order $order succeeds"
        $middlePage = [int]$orderSplit[[Math]::Floor($orderSplit.length/2)]
        #Write-Host "Adding $middlePage to Sum"
        $sumCorrect += $middlePage
    }else{
        $badOrders.Add($order) | Out-Null
    }
}

foreach($order in $badOrders){
    $orderSplit = $order.split(',')
    [string]$newString
    foreach($number in $orderSplit){
        $applicableRules = $rules -match $number
        foreach($rule in $applicableRules){
            $index = 500
            $pages = $rule.split('|')
            if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
                if($orderSplit.indexof($pages[0]) -gt $orderSplit.indexof($pages[1])){
                    $workingString = $orderSplit
                    for($i=$orderSplit.indexof($pages[0]); $i -gt $orderSplit.indexof($pages[1]); $i--){
                        $workingString[$i] = $workingString[$i-1]
                    }
                    $workingString[$orderSplit.indexof($pages[1])] = $pages[0]
                    if((verify-order -rules $rules -order $workingString) -and ($index -gt $orderSplit.indexof($pages[1]))){
                        $index = $orderSplit.indexof($pages[1])
                        $newString = $workingString
                    }
                }
            }
        }
        $orderSplit = $newString
    }
    
}

Write-Host "Sum for correctly ordered pages is $sumCorrect"
Write-Host "Sum for incorrectly ordered pages is $sumIncorrect"

$rules.clear()
$orders.clear()
$badOrders.clear()
$options.clear()