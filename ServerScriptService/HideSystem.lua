-- HideSystem.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local hideStateRemote = ReplicatedStorage:FindFirstChild("HideState")
if not hideStateRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "HideState"
    remote.Parent = ReplicatedStorage
    hideStateRemote = remote
end

local function getHideSpots()
    local map = workspace:FindFirstChild("Map")
    if not map then return {} end
    local folder = map:FindFirstChild("HideSpots")
    if not folder then return {} end
    return folder:GetChildren()
end

local function getNearbyHideSpot(player)
    local char = player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _,spot in ipairs(getHideSpots()) do
        if spot:IsA("BasePart") then
            if (spot.Position - root.Position).Magnitude <= 8 then
                return spot
            end
        end
    end

    return nil
end

local function setHiddenState(player, hidden)
    player:SetAttribute("Hidden", hidden)
    hideStateRemote:FireClient(player, { hidden = hidden })
end

local function checkPlayerHide(player)
    local spot = getNearbyHideSpot(player)
    if spot then
        setHiddenState(player, true)
        return true
    end

    setHiddenState(player, false)
    return false
end

return {
    getNearbyHideSpot = getNearbyHideSpot,
    checkPlayerHide = checkPlayerHide,
    setHiddenState = setHiddenState,
}
