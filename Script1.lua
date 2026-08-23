local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()

local Window = redzlib:MakeWindow({
  Title = "HugeGame Hub",
  SubTitle = "Hop Server Edition",
  SaveFolder = "HugeGameConfig"
})

-- Tạo nút bấm nổi trên màn hình để đóng/mở Menu (Tương tự SP Hub)
Window:AddMinimizeButton({
  Button = { Image = "rbxassetid://18751493385", BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 10) }
})

local Tab1 = Window:MakeTab({"Chức Năng", "server"})

Tab1:AddButton({
  Name = "Hop Server (Đổi Máy Chủ)",
  Callback = function()
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
  end
})

