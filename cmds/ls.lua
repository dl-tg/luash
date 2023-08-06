local lfs = require("lfs")

local ls = {}

ls.args = {
    {1, "string", false, lfs.currentdir(), "dir"}
}

ls.usage = "ls [dir] (default: current directory)"

local WHITE_ANSI = "\27[0m"
local AQUA_ANSI = "\27[36m"

function ls.Handler(dir)
    -- If dir equals ~ (home directory), replace it with environment variable HOME
    -- Else, if dir starts with ~, replace it with environment variable HOME and then get the rest
    -- of the path
    if dir == "~" then
        dir = os.getenv("HOME")
    elseif dir:sub(1, 1) == "~" then
        dir = os.getenv("HOME") .. dir:sub(2)
    end

    -- Check if directory exists by checking it's mode
    local dirExist = lfs.attributes(dir, "mode") == "directory"

    if dirExist then
        for file in lfs.dir(dir) do
            if file ~= "." and file ~= ".." then
                local fullPath = dir .. "/" .. file
                local mode = lfs.attributes(fullPath, "mode")

                if mode == "file" then
                    io.write(WHITE_ANSI .. file .. "\n")
                else
                    io.write(AQUA_ANSI .. file .. "\n")
                end
            end
        end
    else
        io.write("Directory '" .. dir .. "' does not exist\n")
    end

    io.write(WHITE_ANSI)  -- Reset text color
end

return ls
