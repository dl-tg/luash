local echo = {}

echo.args = {
    {1, "string", true, nil, "msg"},
    {2, "string", false, "", "outputFile"} -- Additional argument for file redirection
}
echo.usage = "echo msg num [outputFile]"

function echo.Handler(msg, outputFile)
    print(msg)

    if outputFile ~= "" then
        local file = io.open(outputFile, "w")
        if file then
            file:write(msg .. "\n")
            file:close()
            print("Output written to " .. outputFile)
        else
            print("Error opening file " .. outputFile)
        end
    end
end

return echo
