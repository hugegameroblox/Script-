-- Speed Hub Style Script with Tab System (Main & Hop)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa GUI cũ nếu có
pcall(function()
    if CoreGui:FindFirstChild("ProScriptHub") then
        CoreGui.ProScriptHub:Destroy()
    end
end)

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProScriptHub"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Khung chính của Hub
local MainHub = Instance.new("Frame")
MainHub.Size = UDim2.new(0, 450, 0, 300)
MainHub.Position = UDim2.new(0.5, -225, 0.5, -150)
MainHub.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainHub.BorderSizePixel = 0
MainHub.Active = true
MainHub.Draggable = true
MainHub.Parent = ScreenGui
Instance.new("UICorner", MainHub).CornerRadius = UDim.new(0, 8)

-- Tiêu đề Hub
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 0, 35)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "⚡ Huge Pro Hub | Roblox Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainHub

-- Nút đóng mở nhanh (Minimize)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 3)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = MainHub
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

-- Nút nổi khi thu gọn Hub
local OpenHubBtn = Instance.new("ImageButton")
OpenHubBtn.Size = UDim2.new(0, 45, 0, 45)
OpenHubBtn.Position = UDim2.new(0, 20, 0.4, 0)
OpenHubBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
OpenHubBtn.Image = "rbxassetid://18751493385"
OpenHubBtn.Visible = false
OpenHubBtn.Active = true
OpenHubBtn.Draggable = true
OpenHubBtn.Parent = ScreenGui
Instance.new("UICorner", OpenHubBtn).CornerRadius = UDim.new(0, 22.5)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainHub.Visible = false
    OpenHubBtn.Visible = true
end)

OpenHubBtn.MouseButton1Click:Connect(function()
    MainHub.Visible = true
    OpenHubBtn.Visible = false
end)

-- Thanh Menu chọn Tab (Bên trái)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 110, 1, -45)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainHub

-- Container chứa nội dung các Tab (Bên phải)
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -120, 1, -45)
Container.Position = UDim2.new(0, 115, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainHub

-- Tạo giao diện các Tab nội dung
local MainTabContent = Instance.new("ScrollingFrame")
MainTabContent.Size = UDim2.new(1, 0, 1, 0)
MainTabContent.BackgroundTransparency = 1
MainTabContent.CanvasSize = UDim2.new(0, 0, 1.5, 0)
MainTabContent.ScrollBarThickness = 4
MainTabContent.Visible = true
MainTabContent.Parent = Container

local HopTabContent = Instance.new("Frame")
HopTabContent.Size = UDim2.new(1, 0, 1, 0)
HopTabContent.BackgroundTransparency = 1
HopTabContent.Visible = false
HopTabContent.Parent = Container

-- Nút chuyển Tab Main
local TabMainBtn = Instance.new("TextButton")
TabMainBtn.Size = UDim2.new(0.9, 0, 0, 35)
TabMainBtn.Position = UDim2.new(0.05, 0, 0.03, 0)
TabMainBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
TabMainBtn.Font = Enum.Font.SourceSansBold
TabMainBtn.Text = "🏠 Main"
TabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMainBtn.TextSize = 13
TabMainBtn.Parent = TabBar
Instance.new("UICorner", TabMainBtn).CornerRadius = UDim.new(0, 6)

-- Nút chuyển Tab Hop
local TabHopBtn = Instance.new("TextButton")
TabHopBtn.Size = UDim2.new(0.9, 0, 0, 35)
TabHopBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
TabHopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabHopBtn.Font = Enum.Font.SourceSansBold
TabHopBtn.Text = "🌐 Server Hop"
TabHopBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TabHopBtn.TextSize = 13
TabHopBtn.Parent = TabBar
Instance.new("UICorner", TabHopBtn).CornerRadius = UDim.new(0, 6)

-- Sự kiện chuyển qua lại giữa các Tab
TabMainBtn.MouseButton1Click:Connect(function()
    MainTabContent.Visible = true
    HopTabContent.Visible = false
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
    TabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabHopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabHopBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

TabHopBtn.MouseButton1Click:Connect(function()
    MainTabContent.Visible = false
    HopTabContent.Visible = true
    TabHopBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
    TabHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabMainBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)


-- ==================== NỘI DUNG TAB MAIN ====================
local RejoinBtn = Instance.new("TextButton", MainTabContent)
RejoinBtn.Size = UDim2.new(0.92, 0, 0, 35)
RejoinBtn.Position = UDim2.new(0.04, 0, 0.03, 0)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(230, 140, 0)
RejoinBtn.Font = Enum.Font.SourceSansBold
RejoinBtn.Text = "🔄 Rejoin Server"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.TextSize = 12
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

local AntiAfkBtn = Instance.new("TextButton", MainTabContent)
AntiAfkBtn.Size = UDim2.new(0.92, 0, 0, 35)
AntiAfkBtn.Position = UDim2.new(0.04, 0, 0.16, 0)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AntiAfkBtn.Font = Enum.Font.SourceSansBold
AntiAfkBtn.Text = "🛡️ Anti AFK: TẮT"
AntiAfkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkBtn.TextSize = 12
Instance.new("UICorner", AntiAfkBtn).CornerRadius = UDim.new(0, 6)

local EspBtn = Instance.new("TextButton", MainTabContent)
EspBtn.Size = UDim2.new(0.92, 0, 0, 35)
EspBtn.Position = UDim2.new(0.04, 0, 0.29, 0)
EspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.Text = "👁️ ESP Khung & Tên: TẮT"
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.TextSize = 12
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", MainTabContent)
SpeedBtn.Size = UDim2.new(0.92, 0, 0, 35)
SpeedBtn.Position = UDim2.new(0.04, 0, 0.42, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "⚡ Speed: TẮT (32)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

local SpeedSub = Instance.new("TextButton", MainTabContent)
SpeedSub.Size = UDim2.new(0.44, 0, 0, 30)
SpeedSub.Position = UDim2.new(0.04, 0, 0.55, 0)
SpeedSub.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedSub.Font = Enum.Font.SourceSansBold
SpeedSub.Text = "◀ Giảm tốc (-5)"
SpeedSub.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSub.TextSize = 11
Instance.new("UICorner", SpeedSub).CornerRadius = UDim.new(0, 6)

local SpeedAdd = Instance.new("TextButton", MainTabContent)
SpeedAdd.Size = UDim2.new(0.44, 0, 0, 30)
SpeedAdd.Position = UDim2.new(0.52, 0, 0.55, 0)
SpeedAdd.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedAdd.Font = Enum.Font.SourceSansBold
SpeedAdd.Text = "Tăng tốc (+5) ▶"
SpeedAdd.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedAdd.TextSize = 11
Instance.new("UICorner", SpeedAdd).CornerRadius = UDim.new(0, 6)


-- ==================== NỘI DUNG TAB HOP ====================
local HopBtn = Instance.new("TextButton", HopTabContent)
HopBtn.Size = UDim2.new(0.92, 0, 0, 45)
HopBtn.Position = UDim2.new(0.04, 0, 0.05, 0)
HopBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Text = "🚀 Tìm & Vào Server Ít Người (Hop)"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 12
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 6)

local HopInfo = Instance.new("TextLabel", HopTabContent)
HopInfo.Size = UDim2.new(0.92, 0, 0, 60)
HopInfo.Position = UDim2.new(0.04, 0, 0.25, 0)
HopInfo.BackgroundTransparency = 1
HopInfo.Font = Enum.Font.SourceSans
HopInfo.Text = "Tính năng này giúp bạn tự động tìm các server công khai có số lượng người chơi ít hơn để tránh lag hoặc farm dễ hơn."
HopInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
HopInfo.TextSize = 12
HopInfo.TextWrapped = true
HopInfo.TextXAlignment = Enum.TextXAlignment.Left


-- ==================== LOGIC TÍNH NĂNG ====================

-- Hop Server Logic
HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Đang tìm server trống..."
    pcall(function()
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = HttpService:JSONDecode(req)
        if body and body.data then
            for _, server in pairs(body.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        end
    end)
    task.wait(2)
    HopBtn.Text = "🚀 Tìm & Vào Server Ít Người (Hop)"
end)

-- Rejoin Logic
RejoinBtn.MouseButton1Click:Connect(function()
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nVào lại server...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

-- Anti AFK Logic
local AntiAfkRunning = false
local VirtualUser = game:GetService("VirtualUser")
AntiAfkBtn.MouseButton1Click:Connect(function()
    AntiAfkRunning = not AntiAfkRunning
    AntiAfkBtn.BackgroundColor3 = AntiAfkRunning and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 60)
    AntiAfkBtn.Text = AntiAfkRunning and "🛡️ Anti AFK: BẬT" or "🛡️ Anti AFK: TẮT"
end)

LocalPlayer.Idled:Connect(function()
    if AntiAfkRunning then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- ESP Logic
local EspEnabled = false
local function ApplyEsp(player)
    if player == LocalPlayer then return end
    local function SetupCharacter(char)
        if not char then return end
        task.wait(0.5)
        if not char:FindFirstChild("EspHighlight") then
            local hl = Instance.new("Highlight")
            hl.Name = "EspHighlight"
            hl.Adornee = char
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.Parent = char
        end
        local head = char:FindFirstChild("Head")
        if head and not head:FindFirstChild("EspNameTag") then
            local bill = Instance.new("BillboardGui")
            bill.Name = "EspNameTag"
            bill.Adornee = head
            bill.Size = UDim2.new(0, 100, 0, 40)
            bill.StudsOffset = Vector3.new(0, 2, 0)
            bill.AlwaysOnTop = true
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.Text = player.Name .. "\n[" .. player.DisplayName .. "]"
            txt.TextColor3 = Color3.fromRGB(255, 255, 0)
            txt.TextSize = 11
            txt.TextStrokeTransparency = 0
            txt.Parent = bill
            bill.Parent = head
        end
    end
    player.CharacterAdded:Connect(function(char)
        if EspEnabled then SetupCharacter(char) end
    end)
    if player.Character and EspEnabled then SetupCharacter(player.Character) end
end

for _, p in pairs(Players:GetPlayers()) do ApplyEsp(p) end
Players.PlayerAdded:Connect(ApplyEsp)

EspBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    if EspEnabled then
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        EspBtn.Text = "👁️ ESP Khung & Tên: BẬT"
        for _, p in pairs(Players:GetPlayers()) do if p.Character then ApplyEsp(p) end end
    else
        EspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        EspBtn.Text = "👁️ ESP Khung & Tên: TẮT"
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                if p.Character:FindFirstChild("EspHighlight") then p.Character.EspHighlight:Destroy() end
                local head = p.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("EspNameTag") then head.EspNameTag:Destroy() end
            end
        end
    end
end)

-- Speed Logic
local SpeedEnabled = false
local CustomSpeed = 32

SpeedBtn.MouseButton1Click:Connect(function()
    SpeedEnabled = not SpeedEnabled
    SpeedBtn.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 60)
    SpeedBtn.Text = SpeedEnabled and ("⚡ Speed: BẬT (" .. CustomSpeed .. ")") or ("⚡ Speed: TẮT (" .. CustomSpeed .. ")")
end)

SpeedAdd.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed + 5
    if CustomSpeed > 150 then CustomSpeed = 150 end
    if SpeedEnabled then SpeedBtn.Text = "⚡ Speed: BẬT (" .. CustomSpeed .. ")" end
end)

SpeedSub.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed - 5
    if CustomSpeed < 16 then CustomSpeed = 16 end
    if SpeedEnabled then SpeedBtn.Text = "⚡ Speed: BẬT (" .. CustomSpeed .. ")" end
end)

RunService.Heartbeat:Connect(function()
    if SpeedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if humanoid then humanoid.WalkSpeed = CustomSpeed end
                if hrp and humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    local moveDir = humanoid.MoveDirection
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * CustomSpeed, hrp.AssemblyLinearVelocity.Y, moveDir.Z * CustomSpeed)
                end
            end
        end)
    end
end)
