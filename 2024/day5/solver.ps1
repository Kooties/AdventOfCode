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

function fix-rule($rule,$order){
    Write-Host "18 Evaluating rule $rule on order $order"
    $orderSplit = $order.split(',')
    $pages = $rule.split('|')
    $workingSTring = [System.Collections.ArrayList]@()
    $indexA = $orderSplit.IndexOf($pages[0])
    Write-Host "23 Page that should be first located at $indexA"
    $indexB = $orderSplit.IndexOf($pages[1])
    Write-Host "25 Page that should be later located at $indexB"
    if($indexA -lt $indexB){
        return $order
    }
    if(!(($indexA -lt 0) -or ($indexB -lt 0))){
        for($index = ($orderSplit.count-1); $index -gt $indexA; $index--){
            Write-Host "27 Inserting "$orderSplit[$index]" at start of line"
            $workingString.Insert(0,$orderSplit[$index])
        }
        $workingSTring.Insert(0,$orderSplit[$indexB])
            Write-Host "31 Inserting "$orderSplit[$indexB]" at start of line"
        $workingString.Insert(0,$orderSplit[$indexA])
            Write-Host "33 Inserting "$orderSplit[$indexA]" at start of line"
        $index = ($indexB - 1)
        Write-Host "35 Index is $index"
        while($index -ge 0){
            Write-Host "37 Inserting "$orderSplit[$index]" at start of line"
            $workingString.Insert(0,$orderSplit[$index])
            $index --
        }
        Write-Host "Corrected line is $workingString"
        return $workingSTring
    }
    
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
$rules.sort() | out-null

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

for($i=0; $i -lt $badOrders.Count; $i++){
    Write-Host "96: Starting work on order" $badOrders[$i]
    [string]$newLine = ""
    [string]$workingRule = ""
    $order = $badOrders[$i].split(',')
    Write-Host "99: New order to be worked on is $order"
    for($x=0; $x -lt $order.count; $x++){
        if($x -eq 0){
            Write-Host "102: X equals $x"
            $applicableRules = $rules -match '^'+$order[$x]
            Write-Host "104: Applicable rules are $applicableRules for "$order[$x]
            $index = 500
            [string]$workingRule = ""
            foreach($rule in $applicableRules){
                 $pages = $rule.split('|')
                 if(($order -contains $pages[0]) -and ($order -contains $pages[1])){
                     if($order.indexOf($pages[1]) -lt $order.indexOf($pages[0])){
                        Write-Host "111: Rule $rule is applicable to line "$badOrders[$i]
                         $workingRule = $rule
                         $index = $order.indexOf($pages[1])
                     }
                 }else{
                    Write-Host "116: Rule $rule is NOT applicable to line "$badOrders[$i]
                 }
            }
            $newLine = fix-rule -rule $workingRule -order $badOrders[$i]
            Write-Host "120: New line is $newLine"
        }else{
            write-Host "121: X equals $x; newline is $newLine"
            $applicableRules = $rules -match $newLine[$x]
            $index = 500
            [string]$workingRule
            foreach($rule in $applicableRules){
                 $pages = $rule.split('|')
                 if(($newLine -contains $pages[0]) -and ($newLine -contains $pages[1])){
                     if($newLine.indexOf($pages[1]) -lt $index){
                         $workingRule = $rule
                         $index = $newLine.indexOf($pages[1])
                     }
                 }
            }
            Write-Host "134: rule $rule is valid on $newLine"
            $newLine = fix-rule -rule $workingRule -order $newLine
            Write-Host "136: Line updated to $newLine"
        }
    }
    Write-Host "139: Line has completed processing. " $badOrders[$i]"became"$newLine
    Write-Host "Corrected string is $newLine"
    $middlePage = [int]$newLine[[Math]::Floor($newLine.count/2)]
    #Write-Host "Adding $middlePage to Sum"
    $sumIncorrect += $middlePage
    $workingSTring.clear()
}


Write-Host "Sum for correctly ordered pages is $sumCorrect"
Write-Host "Sum for incorrectly ordered pages is $sumIncorrect"

$rules.clear()
$orders.clear()
$badOrders.clear()