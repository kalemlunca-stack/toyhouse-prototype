-- RoleUI.lua
-- StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "RoleUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 240, 0, 50)
label.Position = UDim2.new(0.5, -120, 0.9, -70)
label.BackgroundColor3 = Color3.fromRGB(20,20,20)
label.BackgroundTransparency = 0.15
label.BorderSizePixel = 0
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Text = "Role: Kid"
label.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = label

local roleRemote = ReplicatedStorage:WaitForChild("RoleState")
roleRemote.OnClientEvent:Connect(function(data)
    if not data then return end
    if data.role == "Mom" then
        label.Text = "Role: MOM"
        label.TextColor3 = Color3.fromRGB(255, 90, 90)
    else
        label.Text = "Role: Kid"
        label.TextColor3 = Color3.fromRGB(255,255,255)
    end
end)
