-- LobbyUI.lua
-- StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LobbyUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 120)
panel.Position = UDim2.new(0.5, -150, 0.5, -60)
panel.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
panel.BackgroundTransparency = 0.2
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 24)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "ROUND STARTING"
title.Parent = panel

local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, -20, 0, 50)
countdownLabel.Position = UDim2.new(0, 10, 0, 40)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Font = Enum.Font.GothamBlack
countdownLabel.TextColor3 = Color3.fromRGB(255, 210, 80)
countdownLabel.Text = "10"
countdownLabel.TextScaled = true
countdownLabel.Parent = panel

local lobbyRemote = ReplicatedStorage:WaitForChild("LobbyState")
lobbyRemote.OnClientEvent:Connect(function(data)
    if not data then return end
    if data.active then
        panel.Visible = true
        countdownLabel.Text = tostring(data.countdown)
    else
        panel.Visible = false
    end
end)
