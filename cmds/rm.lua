local lfs = require("lfs")

local rm = {}

rm.args = {
    {1, "string", true, nil, "fileordir"}
}

rm.usage = "rm fileordir"

function rm.Handler(fileordir)
    local fileType = lfs.attributes(fileordir, "mode")

    -- Check if it exists
    if fileType then
        -- Check if it's a directory
        if fileType.mode == "directory" then
            lfs.rmdir(fileordir)
        else
            os.remove(fileordir)
        end
    else
        print("File or directory doesn't exist")
    end
end

return rm