local multiply = {}

multiply.args = {
    {1, "number", true, "num1"},
    {2, "number", true, "num2"}
}

multiply.usage = "multiply num1 num2"

function multiply.Handler(num1, num2)
    print(num1 * num2)
end

return multiply