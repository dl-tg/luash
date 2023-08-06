local touch = {}

touch.args = {
    {1, "string", true, nil, "filename"}
}

touch.usage = "touch filename"

function touch.Handler(filename)
    local file = io.open(filename, "rb")
    if file then
        file:close()
        print("File " .. filename .. " already exists")
    else
        file = io.open(filename, "wb")
        if file then
            file:close()
        else
            print("Failed to create the file.")
        end
    end
end


return touch