-- Change directory command
local lfs = require("lfs")

local cd = {}

cd.args = {
    {1, "string", true, nil, "directory"}
}

cd.usage = "cd directory"

function cd.Handler(dir)
    local success, errMsg = lfs.chdir(dir)
    if not success then
        print(errMsg)
    end
end

return cd