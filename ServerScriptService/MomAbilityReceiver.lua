-- MomAbilityReceiver.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local abilities = require(script.Parent:WaitForChild("MomAbilities"))

local event = ReplicatedStorage:WaitForChild("MomAbilityEvent")

event.OnServerEvent:Connect(function(player, abilityName)
    if player:GetAttribute("Role") ~= "Mom" then return end

    if abilityName == "doorSlam" then
        abilities.doorSlam(player)
    elseif abilityName == "noiseBurst" then
        abilities.noiseBurst(player)
    elseif abilityName == "breakToy" then
        abilities.breakToy(player)
    elseif abilityName == "rageBurst" then
        abilities.rageBurst(player)
    end
end)
