local multiply = {}

multiply.args = {
    {1, "number", true, "num1"},
    {2, "number", true, "num2"}
}

multiply.usage = "multiply num1 num2"

function multiply.Handler(...)
    local args = {...}
    local num1 = args[1]
    local num2 = args[2]

    print(num1 * num2)
end

return multiply