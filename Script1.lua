-- Speed Hub Style Script (Fixed Rejoin Location)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("ProScriptHub") then
        CoreGui.ProScriptHub:Destroy()
    end
end)

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
TitleLabel.Text = "⚡ Huge Pro Hub | Fixed Mode"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainHub

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

-- Container chứa nội dung (Bên phải)
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -120, 1, -45)
Container.Position = UDim2.new(0, 115, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainHub

-- Khung chứa nội dung từng Tab
local MainTabContent = Instance.new("ScrollingFrame")
MainTabContent.Size = UDim2.new(1, 0, 1, 0)
MainTabContent.BackgroundTransparency = 1
MainTabContent.CanvasSize = UDim2.new(0, 0, 1.4, 0)
MainTabContent.ScrollBarThickness = 4
MainTabContent.Visible = true
MainTabContent.Parent = Container

local HopTabContent = Instance.new("Frame")
HopTabContent.Size = UDim2.new(1, 0, 1, 0)
HopTabContent.BackgroundTransparency = 1
HopTabContent.Visible = false
HopTabContent.Parent = Container

local RejoinTabContent = Instance.new("Frame")
RejoinTabContent.Size = UDim2.new(1, 0, 1, 0)
RejoinTabContent.BackgroundTransparency = 1
RejoinTabContent.Visible = false
RejoinTabContent.Parent = Container

-- Nút Chuyển Tab
local TabMainBtn = Instance.new("TextButton")
TabMainBtn.Size = UDim2.new(0.9, 0, 0, 32)
TabMainBtn.Position = UDim2.new(0.05, 0, 0.03, 0)
TabMainBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
TabMainBtn.Font = Enum.Font.SourceSansBold
TabMainBtn.Text = "🏠 Main"
TabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMainBtn.TextSize = 12
TabMainBtn.Parent = TabBar
Instance.new("UICorner", TabMainBtn).CornerRadius = UDim.new(0, 6)

local TabHopBtn = Instance.new("TextButton")
TabHopBtn.Size = UDim2.new(0.9, 0, 0, 32)
TabHopBtn.Position = UDim2.new(0.05, 0, 0.16, 0)
TabHopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabHopBtn.Font = Enum.Font.SourceSansBold
TabHopBtn.Text = "🌐 Server Hop"
TabHopBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TabHopBtn.TextSize = 12
TabHopBtn.Parent = TabBar
Instance.new("UICorner", TabHopBtn).CornerRadius = UDim.new(0, 6)

local TabRejoinBtn = Instance.new("TextButton")
TabRejoinBtn.Size = UDim2.new(0.9, 0, 0, 32)
TabRejoinBtn.Position = UDim2.new(0.05, 0, 0.29, 0)
TabRejoinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabRejoinBtn.Font = Enum.Font.SourceSansBold
TabRejoinBtn.Text = "🔄 Rejoin"
TabRejoinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TabRejoinBtn.TextSize = 12
TabRejoinBtn.Parent = TabBar
Instance.new("UICorner", TabRejoinBtn).CornerRadius = UDim.new(0, 6)

local function SwitchTab(activeTab, activeBtn)
    MainTabContent.Visible = (activeTab == MainTabContent)
    HopTabContent.Visible = (activeTab == HopTabContent)
    RejoinTabContent.Visible = (activeTab == RejoinTabContent)

    TabMainBtn.BackgroundColor3 = (activeBtn == TabMainBtn) and Color3.fromRGB(0, 140, 230) or Color3.fromRGB(45, 45, 45)
    TabMainBtn.TextColor3 = (activeBtn == TabMainBtn) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

    TabHopBtn.BackgroundColor3 = (activeBtn == TabHopBtn) and Color3.fromRGB(0, 140, 230) or Color3.fromRGB(45, 45, 45)
    TabHopBtn.TextColor3 = (activeBtn == TabHopBtn) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

    TabRejoinBtn.BackgroundColor3 = (activeBtn == TabRejoinBtn) and Color3.fromRGB(0, 140, 230) or Color3.fromRGB(45, 45, 45)
    TabRejoinBtn.TextColor3 = (activeBtn == TabRejoinBtn) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
end

TabMainBtn.MouseButton1Click:Connect(function() SwitchTab(MainTabContent, TabMainBtn) end)
TabHopBtn.MouseButton1Click:Connect(function() SwitchTab(HopTabContent, TabHopBtn) end)
TabRejoinBtn.MouseButton1Click:Connect(function() SwitchTab(RejoinTabContent, TabRejoinBtn) end)

-- ==================== TAB 1: MAIN (Chỉ có Anti AFK, ESP, Speed) ====================
local AntiAfkBtn = Instance.new("TextButton", MainTabContent)
AntiAfkBtn.Size = UDim2.new(0.92, 0, 0, 35)
AntiAfkBtn.Position = UDim2.new(0.04, 0, 0.03, 0)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AntiAfkBtn.Font = Enum.Font.SourceSansBold
AntiAfkBtn.Text = "🛡️ Anti AFK: TẮT"
AntiAfkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkBtn.TextSize = 12
Instance.new("UICorner", AntiAfkBtn).CornerRadius = UDim.new(0, 6)

local EspBtn = Instance.new("TextButton", MainTabContent)
EspBtn.Size = UDim2.new(0.92, 0, 0, 35)
EspBtn.Position = UDim2.new(0.04, 0, 0.16, 0)
EspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.Text = "👁️ ESP Khung & Tên: TẮT"
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.TextSize = 12
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", MainTabContent)
SpeedBtn.Size = UDim2.new(0.92, 0, 0, 35)
SpeedBtn.Position = UDim2.new(0.04, 0, 0.29, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "⚡ CFrame Speed (Bypass): TẮT"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- ==================== TAB 2: HOP SERVER ====================
local HopBtn = Instance.new("TextButton", HopTabContent)
HopBtn.Size = UDim2.new(0.92, 0, 0, 45)
HopBtn.Position = UDim2.new(0.04, 0, 0.05, 0)
HopBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Text = "🚀 Hop Server (Tìm Server Ít Người)"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 12
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 6)

-- ==================== TAB 3: REJOIN (Đã gắn đúng vào RejoinTabContent) ====================
local RejoinBtn = Instance.new("TextButton", RejoinTabContent)
RejoinBtn.Size = UDim2.new(0.92, 0, 0, 45)
RejoinBtn.Position = UDim2.new(0.04, 0, 0.05, 0)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(230, 140, 0)
RejoinBtn.Font = Enum.Font.SourceSansBold
RejoinBtn.Text = "🔄 Rejoin (Vào Lại Server Này)"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.TextSize = 12
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

-- ==================== LOGIC TÍNH NĂNG ====================
RejoinBtn.MouseButton1Click:Connect(function()
    RejoinBtn.Text = "Đang kết nối lại..."
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nVào lại server...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Đang tìm server..."
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
    HopBtn.Text = "🚀 Hop Server (Tìm Server Ít Người)"
end)

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

local CFrameSpeedEnabled = false
local SpeedMultiplier = 0.5

SpeedBtn.MouseButton1Click:Connect(function()
    CFrameSpeedEnabled = not CFrameSpeedEnabled
    SpeedBtn.BackgroundColor3 = CFrameSpeedEnabled and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 60)
    SpeedBtn.Text = CFrameSpeedEnabled and "⚡ CFrame Speed (Bypass): BẬT" or "⚡ CFrame Speed (Bypass): TẮT"
end)

RunService.RenderStepped:Connect(function()
    if CFrameSpeedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local hum = char.Humanoid
                local hrp = char.HumanoidRootPart
                if hum.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * SpeedMultiplier)
                end
            end
        end)
    end
end)
