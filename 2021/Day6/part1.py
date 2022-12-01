with open('input.txt','r') as f:
    DataInput = f.read()
    
#print(Data)

days = range(80)

splitInput = DataInput.split(',')

goodInput = []

for datum in splitInput:
    goodInput.append(int(datum))

for day in days:
    newFish = []
    for number in goodInput:
        if number == 0:
            newFish.append('x')
            number = 6
        else:
            number = number - 1
    for fish in newFish:
        goodInput.append(8)

print(len(goodInput))
print(goodInput)