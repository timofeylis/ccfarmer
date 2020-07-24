col = tonumber(arg[1])
row = tonumber(arg[2])
cycle = tonumber(arg[3])
seed = arg[4]
till = arg[5]
 
if {col, row, cycle} == nil then
    print("Usage: plant <columns> <rows> <seconds between cycles>")    
    error()
end
 
refuel = function()
turtle.select(1)
if reqFuel>turtle.getFuelLevel() then
    turtle.turnRight()
    while turtle.getFuelLevel()<reqFuel do
        turtle.suck()
        turtle.refuel()
    end
    turtle.turnLeft()
end
end
 
plant = function()
    if not turtle.placeDown() then
        if not till then
        for i=1,15 do
            turtle.select(i)
            if turtle.placeDown() then
                break
            end
        end
        end
    end
end
                   
while true do
 
reqFuel = (col * row) + 2*(col - 1) + 2
refuel()
print("Need: " .. reqFuel)
print("Fuel: " .. turtle.getFuelLevel())
if turtle.getFuelLevel()<reqFuel then
    print("Fuel required. Insert " .. reqFuel - turtle.getFuelLevel() .. " more")
        while turtle.getFuelLevel()<reqFuel do
        local event = os.pullEvent("turtle_inventory")
            refuel()
            if event and turtle.getFuelLevel() > reqFuel then
                print("Starting...")
            end
        end
else
    print("Fueled")
end
turtle.forward()
 
a = function()
for i=1,row do
    local success, data = turtle.inspectDown()    
    if data.metadata == 7 then
        turtle.digDown()
        turtle.suckDown()
        plant()
    elseif success == false then
        turtle.digDown()
        plant()
    end
    if i<row then
        turtle.forward()
        turtle.suckDown()
    else
        turtle.suckDown()
    end
 
end
end
 
fwd = function(n)
    for i=1,n do
        turtle.forward()
    end
end
 
bck = function(n)
    for i=1,n do
        turtle.back()
    end
end            
 
for i=1,col do
    a()
    if i==col and col % 2 ~= 0 then
        bck(row-1)
        turtle.turnLeft()
        fwd(col-1)
        turtle.turnRight()
        turtle.back()
    elseif i==col and col % 2 == 0 then
        turtle.turnRight()
        fwd(col-1)
        turtle.turnRight()
        turtle.back()
    elseif i<col and i % 2 == 0 then
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    elseif i<col and i % 2 ~= 0 then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
   end
end
if turtle.getFuelLevel() == 0 then
    print("dumb bitch juice. call tim")
end
 
for i=1,15 do
    turtle.select(i)
    if seed == ("y" or "yes") then
        if not turtle.compareTo(16) then
            turtle.dropDown()
        end
    else
        turtle.dropDown()    
    end
end
 
turtle.select(16)
extra = turtle.getItemCount() - 1
 
if (seed == "y" or "yes") and (extra>1) then
    turtle.transferTo(2,turtle.getItemCount() - 1)
elseif extra>1 then
    turtle.dropDown(turtle.getItemCount() - 1)
end
 
sleep(cycle)
end
