local http = require("socket.http")

local download = {}

download.args = {
    {1, "string", true, nil, "url"}
}

download.usage = "download url"

function download.Handler(url)
    local response, status, headers = http.request(url)

    if status == 200 then
        print("Download succesful")
    else
        print("Download failed, status: " .. status)
    end
end

return download