local add = {}

add.args = {
    {1, "number", true, "num1"},
    {2, "number", true, "num2"}
}
add.usage = "add num1 num2"

function add.Handler(...)
    local args = {...}
    local num1 = args[1]
    local num2 = args[2]

    print(num1 + num2)
end

return add