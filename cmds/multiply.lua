local multiply = {}

multiply.args = {
    {1, "number", true, nil, "num1"},
    {2, "number", true, nil, "num2"}
}

multiply.usage = "multiply num1 num2"

function multiply.Handler(num1, num2)
    print(num1 * num2)
end

return multiply
