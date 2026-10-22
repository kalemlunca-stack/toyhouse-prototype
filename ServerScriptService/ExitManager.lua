-- ExitManager.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exitStateRemote = ReplicatedStorage:FindFirstChild("ExitState")
if not exitStateRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "ExitState"
    remote.Parent = ReplicatedStorage
    exitStateRemote = remote
end

local function unlockExit()
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local exitDoor = map:FindFirstChild("ExitDoor")
    if exitDoor then
        exitDoor.Transparency = 0.25
        exitDoor.CanCollide = false
    end

    exitStateRemote:FireAllClients({
        unlocked = true,
        message = "Exit unlocked",
    })
end

local function checkEscape(player)
    if not player then return end
    if player:GetAttribute("Role") ~= "Kid" then return end

    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local exitDoor = map:FindFirstChild("ExitDoor")
    if not exitDoor then return end

    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - exitDoor.Position).Magnitude
    if distance <= 6 then
        player:SetAttribute("Escaped", true)
        exitStateRemote:FireClient(player, {
            escaped = true,
            message = "You escaped!",
        })
    end
end

return {
    unlockExit = unlockExit,
    checkEscape = checkEscape,
}
