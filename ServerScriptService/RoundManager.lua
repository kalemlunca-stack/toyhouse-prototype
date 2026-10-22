-- RoundManager.lua
-- ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local roundStateRemote = ReplicatedStorage:FindFirstChild("RoundState")
if not roundStateRemote then
    local remote = Instance.new("RemoteEvent")
    remote.Name = "RoundState"
    remote.Parent = ReplicatedStorage
    roundStateRemote = remote
end

local round = {
    active = false,
    timeLeft = 180,
    maxTime = 180,
    toysNeeded = 4,
    toysRepaired = 0,
    exitUnlocked = false,
    winner = nil,
    phase = "Lobby",
}

local function broadcastRound()
    roundStateRemote:FireAllClients({
        active = round.active,
        phase = round.phase,
        timeLeft = round.timeLeft,
        toysRepaired = round.toysRepaired,
        toysNeeded = round.toysNeeded,
        exitUnlocked = round.exitUnlocked,
        winner = round.winner,
    })
end

local function resetRoundState()
    round.active = false
    round.timeLeft = 180
    round.toysRepaired = 0
    round.exitUnlocked = false
    round.winner = nil
    round.phase = "Lobby"
    broadcastRound()
end

local function unlockExit()
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local exitDoor = map:FindFirstChild("ExitDoor")
    if exitDoor then
        exitDoor.Transparency = 0.25
        exitDoor.CanCollide = false
    end

    round.exitUnlocked = true
    broadcastRound()
end

local function addCatchPenalty()
    round.timeLeft = round.timeLeft + 20
    if round.timeLeft > round.maxTime then
        round.timeLeft = round.maxTime
    end
    broadcastRound()
end

local function checkRoundState()
    local aliveKids = 0
    for _,player in ipairs(Players:GetPlayers()) do
        if player:GetAttribute("Role") == "Kid" and player:GetAttribute("Caught") ~= true then
            aliveKids += 1
        end
    end

    if aliveKids <= 0 then
        round.active = false
        round.phase = "End"
        round.winner = "Mom"
        broadcastRound()
        return
    end

    if round.toysRepaired >= round.toysNeeded then
        unlockExit()
    end

    if round.exitUnlocked then
        local escaped = 0
        for _,player in ipairs(Players:GetPlayers()) do
            if player:GetAttribute("Role") == "Kid" and player:GetAttribute("Escaped") == true then
                escaped += 1
            end
        end

        if escaped > 0 then
            round.active = false
            round.phase = "End"
            round.winner = "Kids"
            broadcastRound()
            return
        end
    end

    if round.timeLeft <= 0 then
        round.active = false
        round.phase = "End"
        round.winner = "Mom"
        broadcastRound()
        return
    end
end

local function startRound()
    round.active = true
    round.timeLeft = 180
    round.toysRepaired = 0
    round.exitUnlocked = false
    round.winner = nil
    round.phase = "Play"

    for _,player in ipairs(Players:GetPlayers()) do
        player:SetAttribute("Caught", false)
        player:SetAttribute("Escaped", false)
        player:SetAttribute("Repairing", false)
    end

    broadcastRound()
end

local function onToyRepaired()
    round.toysRepaired = round.toysRepaired + 1
    if round.toysRepaired >= round.toysNeeded then
        unlockExit()
    end
    broadcastRound()
end

local function onKidCaught(player)
    if player and player:GetAttribute("Role") == "Kid" then
        player:SetAttribute("Caught", true)
        addCatchPenalty()
        checkRoundState()
    end
end

local function onKidEscaped(player)
    if player and player:GetAttribute("Role") == "Kid" then
        player:SetAttribute("Escaped", true)
        checkRoundState()
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        if round.active then
            round.timeLeft = round.timeLeft - 1
            checkRoundState()
            broadcastRound()
        end
    end
end)

return {
    round = round,
    startRound = startRound,
    resetRoundState = resetRoundState,
    onToyRepaired = onToyRepaired,
    onKidCaught = onKidCaught,
    onKidEscaped = onKidEscaped,
    checkRoundState = checkRoundState,
}
