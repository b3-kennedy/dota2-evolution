Queue = {}

-- Constructor for creating a new Queue object
function Queue:new()
    local obj = {items = {}}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- Enqueue: Adds an element to the end of the queue
function Queue:enqueue(item)
    table.insert(self.items, item)  -- Adds item at the end of the table
end

-- Dequeue: Removes and returns the first element from the queue
function Queue:dequeue()
    if #self.items == 0 then
        print("Queue is empty!")
        return nil
    end
    return table.remove(self.items, 1)  -- Removes the item at the front (index 1)
end

-- Peek: Returns the first element without removing it
function Queue:peek()
    return self.items[1]  -- Returns the first item in the queue (if it exists)
end

-- Size: Returns the size of the queue
function Queue:size()
    return #self.items  -- #self.items gives the length of the table
end

function Queue:contains(item)
    for _, queued_item in ipairs(self.items) do
        if queued_item == item then
            return true  -- Item found in the queue
        end
    end
    return false  -- Item not found in the queue
end

-- Check if the queue is empty
function Queue:isEmpty()
    return #self.items == 0
end

-- Print all elements in the queue
function Queue:printAll()
    if self:isEmpty() then
        print("Queue is empty!")
        return
    end
    for i, item in ipairs(self.items) do
        print("Item at position " .. i .. ": " .. tostring(item))
    end
end