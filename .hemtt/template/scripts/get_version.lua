function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function split_by_space(string)
    local groups = {}
    for match in string.gmatch(string, "%S+") do
        groups[#groups + 1] = match
    end
    return groups
end

local file = './addons/markers/script_version.hpp'
if not file_exists(file) then
    return "0.0.0"
end

local version = {}
for line in io.lines(file) do
    local split = split_by_space(line)
    local last = split[#split]

    version[#version + 1] = last
end

local version_str = table.concat(version, ".")

return version_str
