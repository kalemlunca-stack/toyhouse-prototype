-- ToyRepairManager.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local toyRepairStateRemote = ReplicatedStorage:FindFirstChild("ToyRepairState")
if not toyRepairStateRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "ToyRepairState"
    remote.Parent = ReplicatedStorage
    toyRepairStateRemote = remote
end

local noiseRemote = ReplicatedStorage:FindFirstChild("NoiseEvent")
if not noiseRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "NoiseEvent"
    remote.Parent = ReplicatedStorage
    noiseRemote = remote
end

local repairedCount = 0
local requiredCount = 4
local setOfToys = {}

local function emitNoise(sourcePlayer, position)
    noiseRemote:FireAllClients({
        source = sourcePlayer and sourcePlayer.Name or "Unknown",
        type = "Repair",
        position = position,
    })
end

local function updateToyState(toy)
    if not toy then return end
    toyRepairStateRemote:FireAllClients({
        toyName = toy.Name,
        repaired = toy:GetAttribute("Repaired"),
        progress = toy:GetAttribute("Progress") or 0,
        requiredProgress = toy:GetAttribute("RequiredProgress") or 100,
    })
end

local function registerToy(toy)
    if not toy then return end
    toy:SetAttribute("Repaired", false)
    toy:SetAttribute("Progress", 0)
    toy:SetAttribute("RequiredProgress", 100)
    toy:SetAttribute("Repairing", false)
    setOfToys[toy] = true
    updateToyState(toy)
end

local function completeToy(toy)
    if not toy or toy:GetAttribute("Repaired") then return end
    toy:SetAttribute("Repaired", true)
    toy:SetAttribute("Progress", 100)
    toy:SetAttribute("Repairing", false)

    repairedCount += 1
    updateToyState(toy)

    local roundManager = require(game.ServerScriptService:WaitForChild("RoundManager"))
    roundManager.onToyRepaired()
end

local function repairToy(player, toy)
    if not player or not toy then return end
    if player:GetAttribute("Role") ~= "Kid" then return end
    if toy:GetAttribute("Repaired") then return end

    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - toy.Position).Magnitude
    if distance > 8 then return end

    local progress = toy:GetAttribute("Progress") or 0
    local newProgress = math.min(progress + 10, 100)
    toy:SetAttribute("Progress", newProgress)
    toy:SetAttribute("Repairing", true)

    emitNoise(player, toy.Position)

    if newProgress >= 100 then
        completeToy(toy)
    else
        updateToyState(toy)
    end
end

local function resetAllToys()
    repairedCount = 0
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local folder = map:FindFirstChild("ToyStations")
    if not folder then return end

    for _,toy in ipairs(folder:GetChildren()) do
        toy:SetAttribute("Repaired", false)
        toy:SetAttribute("Progress", 0)
        toy:SetAttribute("Repairing", false)
        updateToyState(toy)
    end
end

return {
    registerToy = registerToy,
    repairToy = repairToy,
    resetAllToys = resetAllToys,
    requiredCount = requiredCount,
}
