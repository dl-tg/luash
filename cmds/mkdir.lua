local lfs = require("lfs")

local mkdir = {}

mkdir.args = {
    {1, "string", true, nil, "dir"}
}

mkdir.usage = "mkdir dir"

function mkdir.Handler(dir)
    local success, err = lfs.mkdir(dir)
    if not success then
        print(err)
    end
end

return mkdir
