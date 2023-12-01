-- Part 1
function SplitLines(s)
    local result = {}
    for line in string.gmatch(s, "[^\r\n]+") do
        table.insert(result, line)
    end
    return result
end

function FirstAndLastDigit(input)
    local digits = string.gsub(input, "[^%d]", "")
    local first = string.sub(digits, 1, 1)
    local last = string.sub(digits, digits:len(), digits:len())
    return first, last
end

function CalibrationValueOfLine(input)
    local a, b = FirstAndLastDigit(input)
    return tostring(a .. b)
end

function Day1(lines)
    local result = 0
    for l in lines do
        result = result + CalibrationValueOfLine(l)
    end

    return result
end

function FirstAndLastIterator(iter)
    local first = iter()
    local last = iter()
    while last ~= nil do
        last = iter()
    end
    return first, last
end

local lines = io.lines("day1_input.txt")
print(Day1(lines))

-- Part 2
local digitReplacements = {
    one = "1",
    two = "2",
    three = "3",
    four = "4",
    five = "5",
    six = "6",
    seven = "7",
    eight = "8",
    nine = "9",
    ten = "10"
}

--[[
-- Turns a string like "asone1two" into "112".
-- Does so by iterating over each character and trying to match either a digit
-- or one of the english language digit replacements.
-- Surprised by the lack of continue statement in Lua but I think I can
-- vibe with this. It standardises usage of goto which is handy for control flow of nested loops
--]]
function ExtractDigits(input)
    local result = ""
    for i = 1, #input do
        local sub = string.sub(input, i)
        local digit = string.match(sub, "^%d")
        if digit ~= nil then
            result = result .. digit
            goto continue
        end

        for stringDig, dig in pairs(digitReplacements) do
            if string.match(sub, "^" .. stringDig) then
                result = result .. dig
                goto continue
            end
        end

        ::continue::
    end
    return result
end

function Day2(input)
    local result = 0
    for l in input do
        local replacedLine = ExtractDigits(l)
        result = result + CalibrationValueOfLine(replacedLine)
    end

    return result
end


lines = io.lines("day1_input.txt")
print(Day2(lines))
