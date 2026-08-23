local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
local data = HttpService:JSONDecode(req)

for _, server in pairs(data.data) do
    if server.playing < server.maxPlayers and server.id ~= game.JobId then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
        break
    end
end
