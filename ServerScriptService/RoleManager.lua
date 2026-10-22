-- RoleManager.lua
-- ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local roleRemote = ReplicatedStorage:FindFirstChild("RoleState")
if not roleRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "RoleState"
    remote.Parent = ReplicatedStorage
    roleRemote = remote
end

local function setRole(player, role)
    player:SetAttribute("Role", role)

    if role == "Mom" then
        player:SetAttribute("SpeedMultiplier", 1.35)
        player:SetAttribute("CanSprint", true)
        player:SetAttribute("CanDoorSlam", true)
        player:SetAttribute("CanBreakToy", true)
        player:SetAttribute("IsMom", true)
    else
        player:SetAttribute("SpeedMultiplier", 1.15)
        player:SetAttribute("CanSprint", false)
        player:SetAttribute("CanDoorSlam", false)
        player:SetAttribute("CanBreakToy", false)
        player:SetAttribute("IsMom", false)
    end

    roleRemote:FireClient(player, { role = role })
end

local function assignRoles()
    local players = Players:GetPlayers()
    if #players < 2 then return end

    local momIndex = math.random(1, #players)
    local momPlayer = players[momIndex]

    for _,player in ipairs(players) do
        if player == momPlayer then
            setRole(player, "Mom")
        else
            setRole(player, "Kid")
        end
    end
end

return {
    assignRoles = assignRoles,
    setRole = setRole,
}
