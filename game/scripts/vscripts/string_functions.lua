function SplitString(inputstr, delimiter)
    local result = {}
    for match in string.gmatch(inputstr, "([^" .. delimiter .. "]+)") do
        table.insert(result, match)
    end
    return result
end