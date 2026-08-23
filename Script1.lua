     -- Delta / Mobile Executor Compatible Script
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI Root Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HugeGameHub_StealAEgg"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -35, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "HugeGame Hub | Steal a Egg"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Close Button (Thu nhỏ)
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

-- Open Button (Nút nổi hình tròn góc màn hình)
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

-- Hop Low Server Button
local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(0.9, 0, 0, 35)
HopBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
HopBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Text = "🌐 Hop Low Server (Ít Người)"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 13
HopBtn.Parent = MainFrame

local HopCorner = Instance.new("UICorner", HopBtn)
HopCorner.CornerRadius = UDim.new(0, 6)

-- Player Dropdown/Input
local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(0.9, 0, 0, 35)
TargetInput.Position = UDim2.new(0.05, 0, 0.43, 0)
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TargetInput.Font = Enum.Font.SourceSans
TargetInput.PlaceholderText = "Nhập Tên / Chữ cái đầu mục tiêu..."
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.TextSize = 12
TargetInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner", TargetInput)
InputCorner.CornerRadius = UDim.new(0, 6)

-- Fly & Fling Button
local FlingBtn = Instance.new("TextButton")
FlingBtn.Size = UDim2.new(0.9, 0, 0, 40)
FlingBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
FlingBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
FlingBtn.Font = Enum.Font.SourceSansBold
FlingBtn.Text = "🚀 Bay Đến & Fling Mục Tiêu"
FlingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingBtn.TextSize = 13
FlingBtn.Parent = MainFrame

local FlingCorner = Instance.new("UICorner", FlingBtn)
FlingCorner.CornerRadius = UDim.new(0, 6)

--- LOGIC CHỨC NĂNG ---

-- 1. Tắt/Mở Menu
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- 2. Hop Server Ít Người
HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Đang tìm máy chủ ít người..."
    local placeId = game.PlaceId
    local req = game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100")
    local body = HttpService:JSONDecode(req)

    if body and body.data then
        for _, server in pairs(body.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                break
            end
        end
    end
end)

-- Tìm người chơi theo tên rút gọn
local function GetTarget(name)
    name = name:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and (p.Name:lower():sub(1, #name) == name or p.DisplayName:lower():sub(1, #name) == name) then
            return p
        end
    end
    return nil
end

-- 3. Bay Đến & Fling
local isFlinging = false
FlingBtn.MouseButton1Click:Connect(function()
    if isFlinging then return end
    local target = GetTarget(TargetInput.Text)

    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        FlingBtn.Text = "❌ Không tìm thấy người chơi!"
        task.wait(1.5)
        FlingBtn.Text = "🚀 Bay Đến & Fling Mục Tiêu"
        return
    end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    isFlinging = true
    FlingBtn.Text = "🔥 Đang Fling..."

    -- Bật AngularVelocity để xoay với tốc độ cực đại (Fling Physics)
    local bav = Instance.new("BodyAngularVelocity")
    bav.AngularVelocity = Vector3.new(0, 99999, 0)
    bav.MaxTorque = Vector3.new(0, math.huge, 0)
    bav.P = math.huge
    bav.Parent = myRoot

    local targetRoot = target.Character.HumanoidRootPart
    local startTime = tick()

    -- Vòng lặp bám đuôi xoay người để hất tung
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not isFlinging or not targetRoot or not targetRoot.Parent or (tick() - startTime > 3) then
            connection:Disconnect()
            bav:Destroy()
            isFlinging = false
            FlingBtn.Text = "🚀 Bay Đến & Fling Mục Tiêu"
            return
        end
        -- Dịch chuyển dính chặt vào mục tiêu
        myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 0)
        myRoot.Velocity = Vector3.new(9999, 9999, 9999)
    end)
end)
