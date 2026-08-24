-- PRO HUGE HUB - FULL FEATURES (FLY, SPEED, NOCLIP, ESP, INF JUMP, AIR WALK, HITBOX, F3X, HOP)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("RocketMenuUI") then
        CoreGui.RocketMenuUI:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RocketMenuUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- TOP BAR (HEADER)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local FixBar = Instance.new("Frame")
FixBar.Size = UDim2.new(1, 0, 0, 5)
FixBar.Position = UDim2.new(0, 0, 1, -5)
FixBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
FixBar.BorderSizePixel = 0
FixBar.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "⚡ Pro huge hub | hop server"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.TextSize = 18
MinBtn.Parent = TopBar

-- OPEN BUTTON
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 120, 0, 35)
OpenBtn.Position = UDim2.new(0, 20, 0, 20)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Text = "🚀 PRO HUGE HUB"
OpenBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
OpenBtn.TextSize = 11
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- SIDEBAR
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 130, 1, -45)
Sidebar.Position = UDim2.new(0, 5, 0, 40)
Sidebar.BackgroundTransparency = 1
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.ScrollBarThickness = 0
Sidebar.Parent = MainFrame

local function CreateTabButton(name, posY, active)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = active and Color3.fromRGB(220, 20, 30) or Color3.fromRGB(25, 25, 32)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)
    btn.TextSize = 12
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local MainTabBtn = CreateTabButton("🏠  Main", 0, true)
local CombatTabBtn = CreateTabButton("⚔️  Combat", 38, false)
local ServerTabBtn = CreateTabButton("🌐  Server", 76, false)

-- CONTENT AREA
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -145, 1, -45)
ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.BackgroundTransparency = 1
MainContent.CanvasSize = UDim2.new(0, 0, 3.4, 0)
MainContent.ScrollBarThickness = 3
MainContent.ScrollBarImageColor3 = Color3.fromRGB(200, 20, 30)
MainContent.Visible = true
MainContent.Parent = ContentArea

local CombatContent = Instance.new("ScrollingFrame")
CombatContent.Size = UDim2.new(1, 0, 1, 0)
CombatContent.BackgroundTransparency = 1
CombatContent.CanvasSize = UDim2.new(0, 0, 1.4, 0)
CombatContent.ScrollBarThickness = 3
CombatContent.ScrollBarImageColor3 = Color3.fromRGB(200, 20, 30)
CombatContent.Visible = false
CombatContent.Parent = ContentArea

local ServerContent = Instance.new("ScrollingFrame")
ServerContent.Size = UDim2.new(1, 0, 1, 0)
ServerContent.BackgroundTransparency = 1
ServerContent.CanvasSize = UDim2.new(0, 0, 1, 0)
ServerContent.ScrollBarThickness = 3
ServerContent.ScrollBarImageColor3 = Color3.fromRGB(200, 20, 30)
ServerContent.Visible = false
ServerContent.Parent = ContentArea

MainTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    CombatContent.Visible = false
    ServerContent.Visible = false
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CombatTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    CombatTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    ServerTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    ServerTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
end)

CombatTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    CombatContent.Visible = true
    ServerContent.Visible = false
    CombatTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    CombatTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    MainTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    ServerTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    ServerTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
end)

ServerTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    CombatContent.Visible = false
    ServerContent.Visible = true
    ServerTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    ServerTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    MainTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    CombatTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    CombatTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
end)

-- UI HELPERS
local function CreateElement(parent, posY, title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 0, 0, posY)
    frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Text = title
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    return frame
end

local function CreateToggle(parent, posY, title, callback)
    local frame = CreateElement(parent, posY, title)

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(0, 8)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
            circle:TweenPosition(UDim2.new(1, -18, 0.5, -8), "Out", "Quad", 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.15, true)
        end
        callback(state)
    end)
end

local function CreateNumberControl(parent, posY, title, initialValue, step, minVal, maxVal, isFloat, callback)
    local frame = CreateElement(parent, posY, title)

    local incBtn = Instance.new("TextButton")
    incBtn.Size = UDim2.new(0, 25, 0, 24)
    incBtn.Position = UDim2.new(1, -30, 0.5, -12)
    incBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    incBtn.Font = Enum.Font.SourceSansBold
    incBtn.Text = "+"
    incBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    incBtn.TextSize = 14
    incBtn.Parent = frame
    Instance.new("UICorner", incBtn).CornerRadius = UDim.new(0, 4)

    local valBox = Instance.new("TextLabel")
    valBox.Size = UDim2.new(0, 45, 0, 24)
    valBox.Position = UDim2.new(1, -80, 0.5, -12)
    valBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    valBox.Font = Enum.Font.SourceSansBold
    valBox.Text = isFloat and string.format("%.2f", initialValue) or tostring(initialValue)
    valBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valBox.TextSize = 12
    valBox.Parent = frame
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 4)

    local decBtn = Instance.new("TextButton")
    decBtn.Size = UDim2.new(0, 25, 0, 24)
    decBtn.Position = UDim2.new(1, -110, 0.5, -12)
    decBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    decBtn.Font = Enum.Font.SourceSansBold
    decBtn.Text = "-"
    decBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    decBtn.TextSize = 14
    decBtn.Parent = frame
    Instance.new("UICorner", decBtn).CornerRadius = UDim.new(0, 4)

    local curVal = initialValue
    incBtn.MouseButton1Click:Connect(function()
        curVal = curVal + step
        if curVal > maxVal then curVal = maxVal end
        valBox.Text = isFloat and string.format("%.2f", curVal) or tostring(curVal)
        callback(curVal)
    end)

    decBtn.MouseButton1Click:Connect(function()
        curVal = curVal - step
        if curVal < minVal then curVal = minVal end
        valBox.Text = isFloat and string.format("%.2f", curVal) or tostring(curVal)
        callback(curVal)
    end)
end

-- ==================== TAB MAIN ====================
local flying = false
local flySpeed = 50
local bodyGyro, bodyVelocity

local function startFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = hrp.CFrame
    bodyGyro.Parent = hrp

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = hrp

    task.spawn(function()
        while flying and char and char:FindFirstChild("Humanoid") do
            RunService.RenderStepped:Wait()
            local cam = workspace.CurrentCamera
            bodyGyro.cframe = cam.CFrame
            bodyVelocity.velocity = cam.CFrame.LookVector * flySpeed
        end
    end)
end

local function stopFly()
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

CreateToggle(MainContent, 0, "Fly", function(state)
    flying = state
    if flying then startFly() else stopFly() end
end)

CreateNumberControl(MainContent, 48, "   ↳ Fly Speed", 50, 10, 10, 300, false, function(val)
    flySpeed = val
end)

local currentSpeed = 10
local speedEnabled = false
CreateToggle(MainContent, 96, "Speed (CFrame)", function(state)
    speedEnabled = state
end)
CreateNumberControl(MainContent, 144, "   ↳ Value Speed", 10, 10, 10, 500, false, function(val)
    currentSpeed = val
end)

local noclipEnabled = false
CreateToggle(MainContent, 192, "Noclip (Đi xuyên tường)", function(state)
    noclipEnabled = state
end)

local infJumpEnabled = false
CreateToggle(MainContent, 240, "Infinite Jump", function(state)
    infJumpEnabled = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

local airWalkEnabled = false
local airPlatform = nil
CreateToggle(MainContent, 288, "Air Walk (Đi trên không)", function(state)
    airWalkEnabled = state
    if not airWalkEnabled and airPlatform then
        airPlatform:Destroy()
        airPlatform = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if airWalkEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                if not airPlatform then
                    airPlatform = Instance.new("Part")
                    airPlatform.Name = "AirWalkPlatform"
                    airPlatform.Size = Vector3.new(4, 1, 4)
                    airPlatform.Transparency = 1
                    airPlatform.Anchored = true
                    airPlatform.Parent = workspace
                end
                airPlatform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
            end
        end)
    else
        if airPlatform then
            airPlatform:Destroy()
            airPlatform = nil
        end
    end
end)

local espEnabled = false
CreateToggle(MainContent, 336, "ESP Player", function(state)
    espEnabled = state
end)

local afkEnabled = false
CreateToggle(MainContent, 384, "Anti AFK", function(state)
    afkEnabled = state
end)

local savedCFrame = nil
local setTpCard = CreateElement(MainContent, 432, "Set Pos & Teleport")

local setPosBtn = Instance.new("TextButton", setTpCard)
setPosBtn.Size = UDim2.new(0, 60, 0, 24)
setPosBtn.Position = UDim2.new(1, -135, 0.5, -12)
setPosBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
setPosBtn.Font = Enum.Font.SourceSansBold
setPosBtn.Text = "SET POS"
setPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setPosBtn.TextSize = 11
Instance.new("UICorner", setPosBtn).CornerRadius = UDim.new(0, 4)

local tpBtn = Instance.new("TextButton", setTpCard)
tpBtn.Size = UDim2.new(0, 60, 0, 24)
tpBtn.Position = UDim2.new(1, -70, 0.5, -12)
tpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.Text = "TP"
tpBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
tpBtn.TextSize = 11
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)

setPosBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        setPosBtn.Text = "SAVED!"
        tpBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(1)
        setPosBtn.Text = "SET POS"
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if savedCFrame and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = savedCFrame
    end
end)

-- ==================== TAB COMBAT ====================
local hitboxEnabled = false
local hitboxSize = 5

CreateToggle(CombatContent, 0, "Hiện Hitbox & Tăng Hit", function(state)
    hitboxEnabled = state
end)

CreateNumberControl(CombatContent, 48, "   ↳ Kích thước Hitbox", 5, 2, 2, 25, false, function(val)
    hitboxSize = val
end)

RunService.RenderStepped:Connect(function()
    if hitboxEnabled then
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.6
                    hrp.BrickColor = BrickColor.new("Bright red")
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                end
            end
        end)
    else
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end)
    end
end)

local godmodeEnabled = false
CreateToggle(CombatContent, 96, "Godmode (Anti Đánh)", function(state)
    godmodeEnabled = state
end)

RunService.Stepped:Connect(function()
    if godmodeEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, part in pairs(p.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
                
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
        end)
    end
end)

-- ==================== TAB SERVER ====================
local f3xCard = CreateElement(ServerContent, 0, "Lấy F3X (Build Tools)")
local f3xBtn = Instance.new("TextButton", f3xCard)
f3xBtn.Size = UDim2.new(0, 70, 0, 24)
f3xBtn.Position = UDim2.new(1, -80, 0.5, -12)
f3xBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
f3xBtn.Font = Enum.Font.SourceSansBold
f3xBtn.Text = "GET F3X"
f3xBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
f3xBtn.TextSize = 11
Instance.new("UICorner", f3xBtn).CornerRadius = UDim.new(0, 4)

f3xBtn.MouseButton1Click:Connect(function()
    f3xBtn.Text = "..."
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/F3XTeam/F3X/main/client.lua"))()
    end)
    task.wait(1)
    f3xBtn.Text = "LOADED!"
    task.wait(1)
    f3xBtn.Text = "GET F3X"
end)

local hopCard = CreateElement(ServerContent, 48, "Hop Server (Ít người)")
local hopBtn = Instance.new("TextButton", hopCard)
hopBtn.Size = UDim2.new(0, 70, 0, 24)
hopBtn.Position = UDim2.new(1, -80, 0.5, -12)
hopBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
hopBtn.Font = Enum.Font.SourceSansBold
hopBtn.Text = "HOP"
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.TextSize = 12
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 4)

hopBtn.MouseButton1Click:Connect(function()
    hopBtn.Text = "..."
    pcall(function()
        local req = game:HttpGet("https://games.roblox.com/v1
