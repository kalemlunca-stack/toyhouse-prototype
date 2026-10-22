-- LobbyManager.lua
-- ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lobbyStateRemote = ReplicatedStorage:FindFirstChild("LobbyState")
if not lobbyStateRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "LobbyState"
    remote.Parent = ReplicatedStorage
    lobbyStateRemote = remote
end

local lobby = {
    active = false,
    countdown = 10,
    phase = "Lobby",
}

local function broadcastLobby()
    lobbyStateRemote:FireAllClients({
        active = lobby.active,
        countdown = lobby.countdown,
        phase = lobby.phase,
    })
end

local function startLobbyCountdown()
    lobby.active = true
    lobby.phase = "Lobby"
    lobby.countdown = 10

    broadcastLobby()

    while lobby.active and lobby.countdown > 0 do
        task.wait(1)
        lobby.countdown -= 1
        broadcastLobby()
    end

    lobby.active = false
    lobby.phase = "Play"
    broadcastLobby()
end

return {
    lobby = lobby,
    startLobbyCountdown = startLobbyCountdown,
    broadcastLobby = broadcastLobby,
}
