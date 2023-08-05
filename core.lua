local lfs = require("lfs")
local cmds = {}

-- Get all commands from cmds folder and insert them in cmds dictionary
-- Key is the alias (filename without extension), value is require(command file here)
-- Loop through cmds folder
for file in lfs.dir("./cmds") do
    -- Skip special directory entries (current/parent folder)
    if file ~= "." and file ~= ".." then
        -- Construct the file path for command module
        local filePath = "./cmds/" .. file
        -- Extract the metadata and check if it's a Lua file
        local attr = lfs.attributes(filePath)
        if attr.mode == "file" and filePath:match("%.lua$") then
            -- Extract the file name without the extension (.lua)
            local cmdAlias = file:match("(.+)%.lua$")
            -- Insert the command module into the cmds dictionary
            cmds[cmdAlias] = require("cmds." .. cmdAlias)
        end
    end
end

-- Function to handle usage errors
local function UsageError(error, usage)
    print(error)
    if usage ~= nil then
        print("Usage: " .. usage)
    else
        print("Note: Please, provide usage for the command")
    end
end

-- Function to check arguments and perform type conversion
local function checkArgs(args, requiredArgs, usage)
    for key, value in ipairs(requiredArgs) do
        local argIndex = value[1]
        local argType = value[2]
        local isRequired = value[3]
        local argAlias = value[4]
        local arg = args[key]

        if #value < 4 then
            print("Please fill out the argument definition fully (expected 4 elements in total, got only " .. #value .. " elements)")
            break
        end

        -- Check if the argument is missing
        if arg == nil then
            if isRequired then
                if argAlias ~= nil then
                    UsageError("Missing required argument value (arg index: " .. argIndex .. ", arg alias: " .. argAlias .. ")", usage)
                else
                    UsageError("Missing required argument value (arg index: " .. argIndex .. ")", usage)
                    print("Note: Please, add alias for arguments!")
                end
                return false
            end
        else
            -- Perform type conversion based on argType
            if argType == "number" then
                local convertedArg = tonumber(arg)
                -- Check if the conversion was successful
                if convertedArg == nil then
                    if argAlias ~= nil then
                        UsageError("Invalid argument type, expected number for " .. argAlias .. " (arg index: " .. argIndex .. ")")
                    else
                        UsageError("Invalid argument type, expected number for arg index: " .. argIndex)
                    end
                    return false
                end
                args[key] = convertedArg
            elseif argType == "boolean" then
                -- Convert true/false strings to boolean values
                if arg:lower() == "true" then
                    args[key] = true
                elseif arg:lower() == "false" then
                    args[key] = false
                else
                    if argAlias ~= nil then
                        UsageError("Invalid argument type, expected boolean (true/false) for " .. argAlias .. " (arg index: " .. argIndex .. ")")
                    else
                        UsageError("Invalid argument type, expected boolean (true/false) for arg index: " .. argIndex)
                    end
                    return false
                end
            end
        end
    end
    return true
end

print("Luash v0.1")

-- Main loop to read and process user input
while true do
    io.write("> ")
    local input = io.read()
    local cmd, argStr = input:match("(%S+)%s*(.*)")

    if cmd == "exit" then
        break
    end

    local curCmd = cmds[cmd]
    if curCmd then
        if type(curCmd) == "table" then
            -- Split the arguments into individual values using space as the delimiter
            local args = {}
            for arg in argStr:gmatch("%S+") do
                table.insert(args, arg)
            end
            -- Check if amount of args is bigger than specified max amount of args,
            -- and if all required args were provided, print error and usage if false
            if curCmd.args ~= nil then 
                if #args > #curCmd.args then
                    UsageError("Too many arguments!", curCmd.usage)
                elseif checkArgs(args, curCmd.args, curCmd.usage) == true then
                    curCmd.Handler(table.unpack(args))
                end
            else
                print("Please define the arguments for " .. cmd .. "command")
            end
        else
            print("Invalid command module. Try adding at the end of your command module script return command_name_here")
        end
    else
        print(cmd .. ": Command not found")
    end
end
