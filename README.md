# Toyhouse Prototype

This repository contains the core Roblox prototype scripts for the Toyhouse game concept: 8 kids vs 1 Mom, toy repair objective, exit door unlock, round timer, hide/noise system, and basic Mom abilities.

## Project structure

- `ServerScriptService/` — server-side systems
- `StarterPlayerScripts/` — client-side UI and input handlers

## Required Workspace folders

In your Roblox place, create these folders under `Workspace`:

- `Map`
  - `KidSpawns`
  - `MomSpawn`
  - `ExitDoor`
  - `ToyStations`
  - `HideSpots`
  - `Doors`
  - `Props`

## Important setup

Before testing, create:

- 8 `KidSpawn` parts in `Workspace.Map.KidSpawns`
- 1 `MomSpawn` part in `Workspace.Map.MomSpawn`
- 1 `ExitDoor` part in `Workspace.Map.ExitDoor`
- 4 toy stations under `Workspace.Map.ToyStations` named:
  - `TeddyBear`
  - `ToyTrain`
  - `DollHouse`
  - `MusicBox`
- hide spots under `Workspace.Map.HideSpots`

## Prototype loop

1. Lobby countdown begins
2. One player is assigned as Mom
3. Remaining players become Kids
4. Kids repair 4 toys
5. Exit unlocks when enough toys are repaired
6. Kids escape through exit
7. Mom chases and catches players
8. Round ends and resets

## Goal

This prototype is designed to be the core playable loop. It is intentionally minimal and easily expandable.
