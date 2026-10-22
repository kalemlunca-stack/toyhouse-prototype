-- MomController.lua
-- StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local abilityRemote = ReplicatedStorage:WaitForChild("MomAbilityEvent")

local function setSpeed()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if player:GetAttribute("Role") == "Mom" then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            humanoid.WalkSpeed = 22
        else
            humanoid.WalkSpeed = 18
        end
    else
        humanoid.WalkSpeed = 16
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if player:GetAttribute("Role") ~= "Mom" then return end

    if input.KeyCode == Enum.KeyCode.F then
        abilityRemote:FireServer("doorSlam")
    elseif input.KeyCode == Enum.KeyCode.Q then
        abilityRemote:FireServer("noiseBurst")
    elseif input.KeyCode == Enum.KeyCode.E then
        abilityRemote:FireServer("breakToy")
    elseif input.KeyCode == Enum.KeyCode.R then
        abilityRemote:FireServer("rageBurst")
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    setSpeed()
end)
