local add = {}

add.args = {
    {1, "number", true, nil, "num1"},
    {2, "number", true, nil, "num2"}
}
add.usage = "add num1 num2"

function add.Handler(num1, num2)
    print(num1 + num2)
end

return add