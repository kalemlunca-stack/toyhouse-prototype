-- EndOfRoundUI.lua
-- StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "EndOfRoundUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 360, 0, 180)
panel.Position = UDim2.new(0.5, -180, 0.5, -90)
panel.BackgroundColor3 = Color3.fromRGB(20,20,20)
panel.BackgroundTransparency = 0.15
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "ROUND RESULT"
title.Parent = panel

local winnerLabel = Instance.new("TextLabel")
winnerLabel.Size = UDim2.new(1, -20, 0, 40)
winnerLabel.Position = UDim2.new(0,10,0,60)
winnerLabel.BackgroundTransparency = 1
winnerLabel.Font = Enum.Font.GothamBold
winnerLabel.TextColor3 = Color3.fromRGB(255, 210, 80)
winnerLabel.Text = "Kids Win"
winnerLabel.Parent = panel

local roundStateRemote = ReplicatedStorage:WaitForChild("RoundState")
roundStateRemote.OnClientEvent:Connect(function(data)
    if not data then return end
    if data.winner then
        panel.Visible = true
        winnerLabel.Text = data.winner == "Kids" and "Kids Win" or "Mom Wins"
        task.delay(4, function()
            panel.Visible = false
        end)
    end
end)
