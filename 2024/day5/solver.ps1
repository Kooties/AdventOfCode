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
    [string]$workingRule
    foreach($number in $orderSplit){
        $applicableRules = $rules -match $number
        $index = 500
        foreach($rule in $applicableRules){
            $pages = $rule.split('|')
            if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
                if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                    if($orderSplit.indexof($pages[0]) -lt $index){
                        $index = $orderSplit.indexof($pages[0])
                        $workingRule = $rule
                    }
                }
            }
        }
        Write-Host "Correcting order $order using rule $workingRule"
        $pages = $workingRule.split('|')
        $workingString = $orderSplit
        $indexA = $workingString.Indexof($pages[1])
        $indexB = $workingString.Indexof($pages[0])
        for($i = $indexA; $i -lt $indexB; $i++){
            $workingString[$i] = $workingString[$i + 1]
        }
        $workingString[$indexA] = $pages[1]
        $orderSplit = $workingString
        Write-Host "Corrected to $workingString"
    }
    $middlePage = [int]$orderSplit[[Math]::Floor($orderSplit.length/2)]
    #Write-Host "Adding $middlePage to Sum"
    $sumIncorrect += $middlePage
}

Write-Host "Sum for correctly ordered pages is $sumCorrect"
Write-Host "Sum for incorrectly ordered pages is $sumIncorrect"

$rules.clear()
$orders.clear()
$badOrders.clear()
$options.clear()