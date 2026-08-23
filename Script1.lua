-- Delta / Mobile Executor Compatible Script (ESP Player + Name + Speed + Hop Server Title)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Auto Execute Configuration
local AutoLoadEnabled = true
local ScriptUrl = "https://raw.githubusercontent.com/hugegameroblox/Script-/main/Script1.lua"

pcall(function()
    if syn and syn.queue_on_teleport then
        syn.queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
    elseif queue_on_teleport then
        queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
    end
end)

-- Xóa GUI cũ
pcall(function()
    if CoreGui:FindFirstChild("HugeGameHub_HopServer") then
        CoreGui.HugeGameHub_HopServer:Destroy()
    end
end)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HugeGameHub_HopServer"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 390)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -35, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "HugeGame Hub | Hop Server"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "-"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Image = "rbxassetid://18751493385"
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 22)

-- Các nút chức năng
local HopBtn = Instance.new("TextButton", MainFrame)
HopBtn.Size = UDim2.new(0.9, 0, 0, 32)
HopBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
HopBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Text = "🌐 Hop Low Server (Ít Người)"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 12
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 6)

local RejoinBtn = Instance.new("TextButton", MainFrame)
RejoinBtn.Size = UDim2.new(0.9, 0, 0, 32)
RejoinBtn.Position = UDim2.new(0.05, 0, 0.23, 0)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(230, 140, 0)
RejoinBtn.Font = Enum.Font.SourceSansBold
RejoinBtn.Text = "🔄 Rejoin (Vào Lại Server)"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.TextSize = 12
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

local AntiAfkBtn = Instance.new("TextButton", MainFrame)
AntiAfkBtn.Size = UDim2.new(0.9, 0, 0, 32)
AntiAfkBtn.Position = UDim2.new(0.05, 0, 0.34, 0)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AntiAfkBtn.Font = Enum.Font.SourceSansBold
AntiAfkBtn.Text = "🛡️ Anti AFK: TẮT"
AntiAfkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkBtn.TextSize = 12
Instance.new("UICorner", AntiAfkBtn).CornerRadius = UDim.new(0, 6)

local EspBtn = Instance.new("TextButton", MainFrame)
EspBtn.Size = UDim2.new(0.9, 0, 0, 32)
EspBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
EspBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.Text = "👁️ ESP Khung & Tên: TẮT"
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.TextSize = 12
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)

-- Phần tốc độ (Speed)
local SpeedBtn = Instance.new("TextButton", MainFrame)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 32)
SpeedBtn.Position = UDim2.new(0.05, 0, 0.56, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "⚡ Tốc Độ Chạy (Speed): TẮT (32)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- Nút tăng giảm speed nhanh
local SpeedSub = Instance.new("TextButton", MainFrame)
SpeedSub.Size = UDim2.new(0.42, 0, 0, 28)
SpeedSub.Position = UDim2.new(0.05, 0, 0.67, 0)
SpeedSub.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedSub.Font = Enum.Font.SourceSansBold
SpeedSub.Text = "◀ Giảm Speed (-5)"
SpeedSub.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSub.TextSize = 11
Instance.new("UICorner", SpeedSub).CornerRadius = UDim.new(0, 6)

local SpeedAdd = Instance.new("TextButton", MainFrame)
SpeedAdd.Size = UDim2.new(0.42, 0, 0, 28)
SpeedAdd.Position = UDim2.new(0.53, 0, 0.67, 0)
SpeedAdd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedAdd.Font = Enum.Font.SourceSansBold
SpeedAdd.Text = "Tăng Speed (+5) ▶"
SpeedAdd.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedAdd.TextSize = 11
Instance.new("UICorner", SpeedAdd).CornerRadius = UDim.new(0, 6)

local AutoExecBtn = Instance.new("TextButton", MainFrame)
AutoExecBtn.Size = UDim2.new(0.9, 0, 0, 32)
AutoExecBtn.Position = UDim2.new(0.05, 0, 0.79, 0)
AutoExecBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
AutoExecBtn.Font = Enum.Font.SourceSansBold
AutoExecBtn.Text = "⚡ Tự Động Mở Lại Script: BẬT"
AutoExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoExecBtn.TextSize = 12
Instance.new("UICorner", AutoExecBtn).CornerRadius = UDim.new(0, 6)

--- LOGIC ---
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Đang tìm server..."
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

local AntiAfkRunning = false
local VirtualUser = game:GetService("VirtualUser")
AntiAfkBtn.MouseButton1Click:Connect(function()
    AntiAfkRunning = not AntiAfkRunning
    AntiAfkBtn.BackgroundColor3 = AntiAfkRunning and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(100, 100, 100)
    AntiAfkBtn.Text = AntiAfkRunning and "🛡️ Anti AFK: BẬT" or "🛡️ Anti AFK: TẮT"
end)

LocalPlayer.Idled:Connect(function()
    if AntiAfkRunning then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- ESP Khung & Tên
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
            txt.TextSize = 12
            txt.TextStrokeTransparency = 0
            txt.Parent = bill
            bill.Parent = head
        end
    end

    player.CharacterAdded:Connect(function(char)
        if EspEnabled then SetupCharacter(char) end
    end)
    if player.Character and EspEnabled then
        SetupCharacter(player.Character)
    end
end

for _, p in pairs(Players:GetPlayers()) do ApplyEsp(p) end
Players.PlayerAdded:Connect(ApplyEsp)

EspBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    if EspEnabled then
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        EspBtn.Text = " ESP Khung & Tên: BẬT"
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then ApplyEsp(p) end
        end
    else
        EspBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        EspBtn.Text = " ESP Khung & Tên: TẮT"
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                if p.Character:FindFirstChild("EspHighlight") then p.Character.EspHighlight:Destroy() end
                local head = p.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("EspNameTag") then head.EspNameTag:Destroy() end
            end
        end
    end
end)

-- Logic Speed Hack
local SpeedEnabled = false
local CustomSpeed = 32

SpeedBtn.MouseButton1Click:Connect(function()
    SpeedEnabled = not SpeedEnabled
    SpeedBtn.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(100, 100, 100)
    SpeedBtn.Text = SpeedEnabled and (" Speed: BẬT (" .. CustomSpeed .. ")") or ("⚡ Tốc Độ Chạy (Speed): TẮT (" .. CustomSpeed .. ")")
end)

SpeedAdd.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed + 5
    if CustomSpeed > 150 then CustomSpeed = 150 end
    if SpeedEnabled then
        SpeedBtn.Text = " Speed: BẬT (" .. CustomSpeed .. ")"
    end
end)

SpeedSub.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed - 5
    if CustomSpeed < 16 then CustomSpeed = 16 end
    if SpeedEnabled then
        SpeedBtn.Text = " Speed: BẬT (" .. CustomSpeed .. ")"
    end
end)

RunService.RenderStepped:Connect(function()
    if SpeedEnabled then
        pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = CustomSpeed
            end
        end)
    end
end)

AutoExecBtn.MouseButton1Click:Connect(function()
    AutoLoadEnabled = not AutoLoadEnabled
    AutoExecBtn.BackgroundColor3 = AutoLoadEnabled and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(100, 100, 100)
    AutoExecBtn.Text = AutoLoadEnabled and "⚡ Tự Động Mở Lại Script: BẬT" or "⚡ Tự Động Mở Lại Script: TẮT"
    pcall(function()
        local code = AutoLoadEnabled and 'loadstring(game:HttpGet("' .. ScriptUrl .. '"))()' or ""
        if syn and syn.queue_on_teleport then syn.queue_on_teleport(code)
        elseif queue_on_teleport then queue_on_teleport(code) end
    end)
end)

