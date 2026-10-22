-- RoundUI.lua
-- StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RoundUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 220, 0, 40)
timerLabel.Position = UDim2.new(0.5, -110, 0, 20)
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextColor3 = Color3.fromRGB(255,255,255)
timerLabel.Text = "3:00"
timerLabel.TextScaled = true
timerLabel.Parent = gui

local objectiveLabel = Instance.new("TextLabel")
objectiveLabel.Size = UDim2.new(0, 260, 0, 80)
objectiveLabel.Position = UDim2.new(0, 20, 0, 70)
objectiveLabel.BackgroundTransparency = 1
objectiveLabel.Font = Enum.Font.GothamBold
objectiveLabel.TextColor3 = Color3.fromRGB(255,255,255)
objectiveLabel.TextWrapped = true
objectiveLabel.Parent = gui

local roundStateRemote = ReplicatedStorage:WaitForChild("RoundState")
roundStateRemote.OnClientEvent:Connect(function(data)
    if not data then return end

    local timeLeft = math.max(0, data.timeLeft or 180)
    local minutes = math.floor(timeLeft / 60)
    local seconds = timeLeft % 60

    timerLabel.Text = string.format("%02d:%02d", minutes, seconds)
    objectiveLabel.Text = "Toys Repaired: " .. tostring(data.toysRepaired or 0) .. "/" .. tostring(data.toysNeeded or 4)
    if data.exitUnlocked then
        objectiveLabel.Text = objectiveLabel.Text .. "\nExit: Unlocked"
    else
        objectiveLabel.Text = objectiveLabel.Text .. "\nExit: Locked"
    end
end)
