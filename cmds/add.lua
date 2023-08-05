local add = {}

add.args = {
    {1, "number", true},
    {2, "number", true, "num2"} -- num2 is the alias
}
add.usage = "add num1 num2"

function add.Handler(...)
    local args = {...}
    local num1 = args[1]
    local num2 = args[2]

    print(num1 + num2)
end

return add