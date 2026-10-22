-- NoiseSystem.lua
-- ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local noiseRemote = ReplicatedStorage:FindFirstChild("NoiseEvent")
if not noiseRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "NoiseEvent"
    remote.Parent = ReplicatedStorage
    noiseRemote = remote
end

local function emitNoise(sourcePlayer, volume, position, noiseType)
    noiseRemote:FireAllClients({
        source = sourcePlayer and sourcePlayer.Name or "Unknown",
        volume = volume or 0.5,
        position = position or Vector3.new(0,0,0),
        type = noiseType or "General",
    })
end

return {
    emitNoise = emitNoise,
}
