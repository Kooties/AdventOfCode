function verify-order([System.Collections.ArrayList]$rules,[string]$order){
    $print = $true
    $orderSplit = $order.split(',')
    foreach($rule in $rules){
        ##Write-Host "Checking rule $rule"
        $pages = $rule.split('|')
        if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
            if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                ##Write-Host "Rule Broken; setting print to False"
                $print = $false
            }
        }
    }
    return $print
}

function fix-rule($rule,$order){
    Write-Host "18 Evaluating rule $rule on order $order"
    $orderSplit = $order.split(',').split(' ')
    $pages = $rule.split('|')
    $workingSTring = [System.Collections.ArrayList]@()
    $indexA = $orderSplit.IndexOf($pages[0])
    Write-Host "23 Page that should be first located at $indexA"
    $indexB = $orderSplit.IndexOf($pages[1])
    Write-Host "25 Page that should be later located at $indexB"
    if(($indexA -eq -1) -or ($indexB -eq -1)){
        Write-Host "27 One+ of the pages isn't valid; returning input order"
        return $order
    }
    if($indexA -lt $indexB){
        return $order
    }
    if(!(($indexA -lt 0) -or ($indexB -lt 0))){
        if($indexA -eq ($orderSplit.count -1)){
            for($i = ($orderSplit.count-2); $i -ge $indexB; $i--){
                $workingSTring.Insert(0,$orderSplit[$i])
            }
            $workingSTring.Insert(0,$orderSplit[$indexA])
        }else{
            for($index = ($orderSplit.count-1); $index -gt $indexA; $index--){
                Write-Host "41 Inserting "$orderSplit[$index]" at start of line"
                $workingString.Insert(0,$orderSplit[$index])
            }
            $workingSTring.Insert(0,$orderSplit[$indexB])
                Write-Host "45 Inserting "$orderSplit[$indexB]" at start of line"
            $workingString.Insert(0,$orderSplit[$indexA])
                Write-Host "47 Inserting "$orderSplit[$indexA]" at start of line"
        }
        
        $index = ($indexB - 1)
        Write-Host "51 Index is $index"
        while($index -ge 0){
            Write-Host "53 Inserting "$orderSplit[$index]" at start of line"
            $workingString.Insert(0,$orderSplit[$index])
            $index --
        }
        Write-Host "Corrected line is $workingString"
        return $workingSTring
    }
    
}

#first section is rules, second section is orders
#result should be middle printed page numbers of each correct order summed
#second section: 5647 too high; 5374 too high
$rawData = Get-Content input.txt

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
    ##Write-Host "Parsing order $order"
    $print = $true
    $orderSplit = $order.split(',')
    foreach($rule in $rules){
        ##Write-Host "Checking rule $rule"
        $pages = $rule.split('|')
        if(($orderSplit -contains $pages[0]) -and ($orderSplit -contains $pages[1])){
            if($orderSplit.indexof($pages[1]) -lt $orderSplit.indexof($pages[0])){
                ##Write-Host "Rule Broken; setting print to False"
                $print = $false
            }
        }
    }
    if($print){
        ##Write-Host "Order $order succeeds"
        $middlePage = [int]$orderSplit[[Math]::Floor($orderSplit.length/2)]
        ##Write-Host "Adding $middlePage to Sum"
        $sumCorrect += $middlePage
    }else{
        $badOrders.Add($order) | Out-Null
    }
}

for($i=0; $i -lt $badOrders.Count; $i++){
    Write-Host "100: Starting work on order" $badOrders[$i]
    [string]$newLine = ""
    [string]$workingRule = ""
    [bool]$validRule = $false
    $applicableRules = [System.Collections.ArrayList]@()
    #$correctedStrings = [System.Collections.ArrayList]@()
    $order = $badOrders[$i].split(',')
    #Write-Host "107: New order to be worked on is $order"
    for($x=1; $x -lt $order.count; $x++){
        if($x -eq 1){
            #Write-Host "108: X equals $x"
            foreach($rule in $rules){
                if($rule -match '^'+$order[$x]){
                    $applicableRules.Add($rule) | Out-Null
                }
            }
            #Write-Host "114: Applicable rules are $applicableRules for "$order[$x]
            $index = 500
            [string]$workingRule = ""
            foreach($rule in $applicableRules){
                #Write-Host "118: Evaluating if rule $rule is applicable to line "$badOrders[$i]
                 $pages = $rule.split('|')
                 if(($order -contains $pages[0]) -and ($order -contains $pages[1])){
                     if($order.indexOf($pages[1]) -lt $order.indexOf($pages[0])){
                        #Write-Host "122: Rule $rule is applicable to line "$badOrders[$i]
                         $workingRule = $rule
                         $validRule = $true
                         $index = $order.indexOf($pages[1])
                     }
                 }else{
                    #Write-Host "127: Rule $rule is NOT applicable to line "$badOrders[$i]
                 }
            }
            if($validRule){
                $newLine = fix-rule -rule $workingRule -order $badOrders[$i]
                #Write-Host "131: New line is $newLine"
            }else{
                $newLine = $badOrders[$i]
                #Write-Host "New line not changed"
            }
            $validRule = $false
            $applicableRules.clear() | Out-Null
        }else{
            #Write-Host "142: X equals $x; newline is $newLine"
            foreach($rule in $rules){
                if(($rule -match '^'+$order[$x])){
                    $applicableRules.Add($rule) | Out-Null
                }
            }
            #Write-Host "148: Applicable rules are $applicableRules for "$newLine
            $index = 500
            foreach($rule in $applicableRules){
                 $pages = $rule.split('|')
                 #Write-Host "152: Pages referenced are" $pages[0]"and"$pages[1]
                 if(($newLine -match $pages[0]) -and ($newLine -match $pages[1])){
                    #Write-Host "154: Line contains both pages"
                    #Write-Host "155: Index of page 0 is "$newLine.indexOf($pages[0])"and page 1 is"$newLine.IndexOf($pages[1])"and index is $index"
                     if($newLine.indexOf($pages[1]) -lt $index){
                         $workingRule = $rule
                         $index = $newLine.indexOf($pages[1])
                         $validRule = $True
                     }
                 }
            }
            if($validRule){
                #Write-Host "152: rule $workingRule is valid on $newLine"
                $newLine = fix-rule -rule $workingRule -order $newLine
                #Write-Host "154: Line updated to $newLine"
                $validRule = $false
            }
            $applicableRules.clear() | Out-Null
        }
    }
    #Write-Host "157: Line has completed processing. " $badOrders[$i]"became"$newLine
    #Write-Host "Corrected string is $newLine"
    #$correctedStrings.Add($newLine) | Out-Null
    $applicableRules.clear() | Out-Null
    $middlePage = [int]$newLine.split(" ")[[Math]::Floor($newLine.split(" ").count/2)]
    #Write-Host "Adding $middlePage to Sum"
    $sumIncorrect += $middlePage
}


Write-Host "Sum for correctly ordered pages is $sumCorrect"
Write-Host "Sum for incorrectly ordered pages is $sumIncorrect"

$rules.clear()
$orders.clear()
$badOrders.clear()