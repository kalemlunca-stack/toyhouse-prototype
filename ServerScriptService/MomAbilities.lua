-- MomAbilities.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local abilityRemote = ReplicatedStorage:FindFirstChild("MomAbilityEvent")
if not abilityRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "MomAbilityEvent"
    remote.Parent = ReplicatedStorage
    abilityRemote = remote
end

local function doorSlam(momPlayer)
    if not momPlayer then return end
    local char = momPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local doorFolder = map:FindFirstChild("Doors")
    if not doorFolder then return end

    for _,door in ipairs(doorFolder:GetChildren()) do
        if door:IsA("BasePart") then
            local dist = (door.Position - root.Position).Magnitude
            if dist <= 12 then
                door.CanCollide = true
                door.Transparency = 0.2
            end
        end
    end
end

local function noiseBurst(momPlayer)
    if not momPlayer then return end
    local char = momPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _,player in ipairs(Players:GetPlayers()) do
        if player:GetAttribute("Role") == "Kid" then
            local kidChar = player.Character
            if kidChar then
                local kidRoot = kidChar:FindFirstChild("HumanoidRootPart")
                if kidRoot then
                    local dist = (kidRoot.Position - root.Position).Magnitude
                    if dist <= 25 then
                        player:SetAttribute("Detected", true)
                    end
                end
            end
        end
    end
end

local function breakToy(momPlayer)
    if not momPlayer then return end
    local char = momPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local toyFolder = map:FindFirstChild("ToyStations")
    if not toyFolder then return end

    for _,toy in ipairs(toyFolder:GetChildren()) do
        local dist = (toy.Position - root.Position).Magnitude
        if dist <= 8 then
            if toy:GetAttribute("Repaired") == true then
                toy:SetAttribute("Repaired", false)
                toy:SetAttribute("Progress", 0)
            end
        end
    end
end

local function rageBurst(momPlayer)
    if not momPlayer then return end
    local char = momPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    humanoid.WalkSpeed = 26
    task.delay(2.5, function()
        if humanoid then
            humanoid.WalkSpeed = 18
        end
    end)
end

return {
    doorSlam = doorSlam,
    noiseBurst = noiseBurst,
    breakToy = breakToy,
    rageBurst = rageBurst,
}
