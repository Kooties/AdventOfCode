$rawData = Get-Content input.txt

$sum = 0

for($i=0; $i -lt ($rawData.count - 2); $i++){
    if(($i -eq 0) -or ((($i%3)) -eq 0)){
        Write-Host $i
        $elf1 = $rawData[$i].ToCharArray()
        $elf2 = $rawData[$i+1]
        $elf3 = $rawData[$i+2]
        $match = ''
        foreach($char in $elf1){
            if($elf2.Contains($char)){
                if($elf3.Contains($char)){
                    $match = $char.tostring()
                    break;
                }
            }
        }
        if($match -cmatch "[a-z]"){
            switch ($match) 
                {
                    'a' {$sum += 1; Break}
                    'b' {$sum += 2; Break}
                    'c' {$sum += 3; Break}
                    'd' {$sum += 4; Break}
                    'e' {$sum += 5; Break}
                    'f' {$sum += 6; Break}
                    'g' {$sum += 7; Break}
                    'h' {$sum += 8; Break}
                    'i' {$sum += 9; Break}
                    'j' {$sum += 10; Break}
                    'k' {$sum += 11; Break}
                    'l' {$sum += 12; Break}
                    'm' {$sum += 13; Break}
                    'n' {$sum += 14; Break}
                    'o' {$sum += 15; Break}
                    'p' {$sum += 16; Break}
                    'q' {$sum += 17; Break}
                    'r' {$sum += 18; Break}
                    's' {$sum += 19; Break}
                    't' {$sum += 20; Break}
                    'u' {$sum += 21; Break}
                    'v' {$sum += 22; Break}
                    'w' {$sum += 23; Break}
                    'x' {$sum += 24; Break}
                    'y' {$sum += 25; Break}
                    'z' {$sum += 26; Break}
                }
            }else{
                switch($match){
                    'A' {$sum += 27; Break}
                    'B' {$sum += 28; Break}
                    'C' {$sum += 29; Break}
                    'D' {$sum += 30; Break}
                    'E' {$sum += 31; Break}
                    'F' {$sum += 32; Break}
                    'G' {$sum += 33; Break}
                    'H' {$sum += 34; Break}
                    'I' {$sum += 35; Break}
                    'J' {$sum += 36; Break}
                    'K' {$sum += 37; Break}
                    'L' {$sum += 38; Break}
                    'M' {$sum += 39; Break}
                    'N' {$sum += 40; Break}
                    'O' {$sum += 41; Break}
                    'P' {$sum += 42; Break}
                    'Q' {$sum += 43; Break}
                    'R' {$sum += 44; Break}
                    'S' {$sum += 45; Break}
                    'T' {$sum += 46; Break}
                    'U' {$sum += 47; Break}
                    'V' {$sum += 48; Break}
                    'W' {$sum += 49; Break}
                    'X' {$sum += 50; Break}
                    'Y' {$sum += 51; Break}
                    'Z' {$sum += 52; Break}
                }
    }
}
}