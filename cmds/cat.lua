local lfs = require("lfs")

local cat = {}

cat.args = {
    {1, "string", true, nil, "file"}
}

cat.usage = "cat file"

function cat.Handler(file)
    local fileObj, err = io.open(file, "r")
    local fileType = lfs.attributes(file, "mode")

    if not fileObj and file ~= "~" then
        print(err)
    else
        if fileType == "file" then
            local contents
            if fileObj then
                contents = fileObj:read("a")
            end

            if not contents then
                print("Failed to read contents of " .. file)
            elseif contents == "" then
                print(file .. " is empty")
            else
                io.write(contents)
            end

            if fileObj then
                fileObj:close()
            end
            io.write("\n")
        else
            print(file .. " is not a file")
        end
    end
end

return cat
