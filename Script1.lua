-- Delta / Mobile Executor Compatible Script (Updated)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Auto Execute Configuration (Tự động chạy lại script khi Rejoin/Hop)
local AutoLoadEnabled = true
local ScriptUrl = "https://raw.githubusercontent.com/hugegameroblox/Script-/main/Script1.lua"

pcall(function()
    if syn and syn.queue_on_teleport then
        syn.queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
    elseif queue_on_teleport then
        queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
    end
end)

-- Xóa GUI cũ nếu có để tránh trùng lặp
pcall(function()
    if CoreGui:FindFirstChild("HugeGameHub_StealAEgg") then
        CoreGui.HugeGameHub_StealAEgg:Destroy()
    end
end)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HugeGameHub_StealAEgg"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 310)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, -155)
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
Title.Text = "HugeGame Hub | Steal a Egg"
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

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Image = "rbxassetid://18751493385"
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner", OpenBtn)
OpenCorner.CornerRadius = UDim.new(0, 22)

-- Nút: Hop Low Server
local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(0.9, 0, 0, 32)
HopBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
HopBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Text = "🌐 Hop Low Server (Ít Người)"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 12
HopBtn.Parent = MainFrame
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 6)

-- Nút: Rejoin
local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(0.9, 0, 0, 32)
RejoinBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(230, 140, 0)
RejoinBtn.Font = Enum.Font.SourceSansBold
RejoinBtn.Text = "🔄 Rejoin (Vào Lại Server)"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.TextSize = 12
RejoinBtn.Parent = MainFrame
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

-- Nút: Anti AFK
local AntiAfkBtn = Instance.new("TextButton")
AntiAfkBtn.Size = UDim2.new(0.9, 0, 0, 32)
AntiAfkBtn.Position = UDim2.new(0.05, 0, 0.41, 0)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AntiAfkBtn.Font = Enum.Font.SourceSansBold
AntiAfkBtn.Text = "🛡️ Anti AFK: TẮT"
AntiAfkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkBtn.TextSize = 12
AntiAfkBtn.Parent = MainFrame
Instance.new("UICorner", AntiAfkBtn).CornerRadius = UDim.new(0, 6)

-- Nút: ESP Player
local EspBtn = Instance.new("TextButton")
EspBtn.Size = UDim2.new(0.9, 0, 0, 32)
EspBtn.Position = UDim2.new(0.05, 0, 0.54, 0)
EspBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.Text = "👁️ ESP Người Khác: TẮT"
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.TextSize = 12
EspBtn.Parent = MainFrame
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)

-- Nút: Toggle Auto Execute
local AutoExecBtn = Instance.new("TextButton")
AutoExecBtn.Size = UDim2.new(0.9, 0, 0, 32)
AutoExecBtn.Position = UDim2.new(0.05, 0, 0.67, 0)
AutoExecBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
AutoExecBtn.Font = Enum.Font.SourceSansBold
AutoExecBtn.Text = "⚡ Tự Động Mở Lại Script: BẬT"
AutoExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoExecBtn.TextSize = 12
AutoExecBtn.Parent = MainFrame
Instance.new("UICorner", AutoExecBtn).CornerRadius = UDim.new(0, 6)

--- LOGIC CHỨC NĂNG ---

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- 1. Hop Low Server
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

-- 2. Rejoin
RejoinBtn.MouseButton1Click:Connect(function()
    RejoinBtn.Text = "Đang kết nối lại..."
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nĐang vào lại server...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

-- 3. Anti AFK
local AntiAfkRunning = false
local VirtualUser = game:GetService("VirtualUser")
AntiAfkBtn.MouseButton1Click:Connect(function()
    AntiAfkRunning = not AntiAfkRunning
    if AntiAfkRunning then
        AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        AntiAfkBtn.Text = " Anti AFK: BẬT"
    else
        AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        AntiAfkBtn.Text = " Anti AFK: TẮT"
    end
end)

LocalPlayer.Idled:Connect(function()
    if AntiAfkRunning then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- 4. ESP Người Khác
local EspEnabled = false
local EspFolder = Instance.new("Folder", CoreGui)
EspFolder.Name = "ESP_Container"

local function AddEsp(player)
    if player == LocalPlayer then return end
    local function CreateBox(char)
        if char:FindFirstChild("Highlight") then return end
        local hl = Instance.new("Highlight")
        hl.Name = "Highlight"
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.Parent = char
    end
    
    player.CharacterAdded:Connect(function(char)
        if EspEnabled then
            task.wait(1)
            CreateBox(char)
        end
    end)
    if player.Character and EspEnabled then
        CreateBox(player.Character)
    end
end

for _, p in pairs(Players:GetPlayers()) do AddEsp(p) end
Players.PlayerAdded:Connect(AddEsp)

EspBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    if EspEnabled then
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        EspBtn.Text = " ESP : BẬT"
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                if not p.Character:FindFirstChild("Highlight") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "Highlight"
                    hl.Adornee = p.Character
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.FillTransparency = 0.5
                end
            end
        end
    else
        EspBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        EspBtn.Text = " ESP : TẮT"
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then
                p.Character.Highlight:Destroy()
            end
        end
    end
end)

-- 5. Bật/Tắt Tự động mở lại script
AutoExecBtn.MouseButton1Click:Connect(function()
    AutoLoadEnabled = not AutoLoadEnabled
    pcall(function()
        if AutoLoadEnabled then
            AutoExecBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
            AutoExecBtn.Text = "⚡ Tự Động Mở Lại Script: BẬT"
            if syn and syn.queue_on_teleport then
                syn.queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
            elseif queue_on_teleport then
                queue_on_teleport('loadstring(game:HttpGet("' .. ScriptUrl .. '"))()')
            end
        else
            AutoExecBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            AutoExecBtn.Text = "⚡ Tự Động Mở Lại Script: TẮT"
            if syn and syn.queue_on_teleport then
                syn.queue_on_teleport("")
            elseif queue_on_teleport then
                queue_on_teleport("")
            end
        end
    end)
end)
