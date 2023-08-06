# Luash

Luash is a simple interactive shell written in Lua that allows you to execute custom commands defined in separate Lua script files. It provides a convenient way to extend the shell with your own commands, making it more versatile and tailored to your needs.

## Features

  - Easy-to-use interactive shell environment
  - Customizable commands through Lua script files
  - Support for required and optional arguments with type validation
  - Default values for optional arguments

## Requirements

  - Lua (5.1 or above)
  - LuaFileSystem (lfs) library

## Usage

1. Clone or download the repository to your local machine
2. Make sure you have Lua and the LuaFileSystem library installed
   - Download Lua here https://www.lua.org/download.html
   - To install LuaFileSystem, install luarocks and run
     ```shell
     luarocks install luafilesystem
     ```
    
3. Navigate to the Luash directory
4. Run the core.lua script using the Lua interpreter:

```bash

lua core.lua
```
You will be presented with the Luash prompt (>) where you can enter commands.

## Custom Commands

To add your custom commands, create Lua script files (the filename will be command's name, e.g hello.lua would create a hello command) in the cmds folder, defining your commands with the required structure. Each command should be defined as a Lua table with the following properties:

  - `args` (table): A table defining the arguments for the command, including type and whether they are required or optional.
    
      - Argument definition format: {argIndex, argType, isRequired, defaultValue, argAlias}
  
          - `argIndex` (number): The position of the argument.
  
          - `argType` (string): The data type of the argument. Supported types: "string", "number", "boolean".
  
          - `isRequired` (boolean): Whether the argument is required (true) or optional (false).
  
          - `defaultValue` (any, optional): The default value for optional arguments. Only applicable if isRequired is false,                   set to `nil` if arg is required. The type of default value should match the type of the argument
  
          - `argAlias` (string, optional): An alias for the argument, used in usage error messages.

    Note: To pass a string argument that contains spaces, wrap the entire string in single or double quotes.

    - `usage` (string): A usage string that provides information about how to use the command.

    - `Handler` (function): The function that implements the behavior of the command.

Example of a custom command file (echo.lua):

```lua

local echo = {}

echo.args = {
    {1, "string", true, nil, "msg"},
    {2, "number", false, 14, "num"}
}
echo.usage = "echo msg num"

function echo.Handler(msg, num)
    print(msg)
    print(num)
end

return echo
```
## Reloading

At any time, you can type reload at the Luash prompt (>) to manually reload the custom commands. This is useful if you make changes to the command script files and want to apply the changes during runtime.

To exit the Luash shell, simply type exit.

## Examples

1. Execute the echo command with a string and a number:

```shell

> echo 'Hello, Luash!' 42
Hello, Luash!
42
```
2. Execute the echo command with only a string (optional argument will use the default value):

```shell

> echo 'Hello, Luash!'
Hello, Luash!
14
```
3. Execute the reload command to reload the custom commands after making changes:

```shell

> reload
Reloading the commands...
Success!
```
## Contributions

If you encounter any issues, have suggestions, or want to contribute new features, feel free to create a pull request or open an issue on GitHub.
If you want to contribute but are unsure how, refer to the official GitHub guide on [Contributing to projects](https://docs.github.com/en/get-started/quickstart/contributing-to-projects).

## License

Luash is open-source software licensed under the [MIT License](LICENSE).
