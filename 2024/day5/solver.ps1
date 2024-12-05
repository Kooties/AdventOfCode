#first section is rules, second section is orders
#result should be middle printed page numbers of each correct order summed
$rawData = Get-Content example.txt

$rules = [System.Collections.ArrayList]@()
$orders = [System.Collections.ArrayList]@()
$sum = 0

foreach($line in $rawData){
    if($line -match '\d?\|\d?'){
        $rules.Add($line)
    }elseif($line -match '\d?,'){
        $orders.Add($line)
    }
}

foreach($order in $orders){
    Write-Host "Parsing order $order"
    $print = $true
    $orderSplit = $order.split(',')
    foreach($rule in $rules){
        Write-Host "Checking rule $rule"
        $pages = $rule.split('|')
        if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
            if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                Write-Host "Rule Broken; setting print to False"
                $print = $false
            }
        }
    }
    if($print){
        Write-Host "Order $order succeeds"
        $middlePage = [int]$order[[Math]::Floor($order.length/2)]
        Write-Host "Adding $middlePage to Sum"
        $sum += $middlePage
    }
}

Write-Host "Sum is $sum"

$rules.clear()
$orders.clear()