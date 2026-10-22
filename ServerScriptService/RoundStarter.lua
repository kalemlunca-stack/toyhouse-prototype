-- RoundStarter.lua
-- ServerScriptService

local LobbyManager = require(script.Parent:WaitForChild("LobbyManager"))
local RoleManager = require(script.Parent:WaitForChild("RoleManager"))
local RoundManager = require(script.Parent:WaitForChild("RoundManager"))

task.spawn(function()
    while true do
        LobbyManager.startLobbyCountdown()
        RoleManager.assignRoles()
        RoundManager.startRound()
        task.wait(180)
    end
end)
