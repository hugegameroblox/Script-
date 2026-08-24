-- PRO PVP HUB - ULTIMATE COMBAT EDITION (PHẦN 1)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

pcall(function()
    if CoreGui:FindFirstChild("PvPHubUI") then
        CoreGui.PvPHubUI:Destroy()
    end
    if CoreGui:FindFirstChild("FlyControlGui") then
        CoreGui.FlyControlGui:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PvPHubUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then 
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") 
end

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 370)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -185)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(220, 20, 30)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "⚔️ ULTIMATE PVP HUB | MULTI-TAB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 18
MinBtn.Parent = TopBar

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 110, 0, 35)
OpenBtn.Position = UDim2.new(0, 20, 0, 20)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Text = "⚔️ PVP HUB"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 12
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(220, 20, 30)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- TAB SYSTEM
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 42)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Size = UDim2.new(0.5, -5, 1, 0)
MainTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
MainTabBtn.Font = Enum.Font.SourceSansBold
MainTabBtn.Text = "MAIN (Hỗ trợ)"
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabBtn.TextSize = 13
MainTabBtn.Parent = TabBar
Instance.new("UICorner", MainTabBtn).CornerRadius = UDim.new(0, 6)

local AimTabBtn = Instance.new("TextButton")
AimTabBtn.Size = UDim2.new(0.5, -5, 1, 0)
AimTabBtn.Position = UDim2.new(0.5, 5, 0, 0)
AimTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AimTabBtn.Font = Enum.Font.SourceSansBold
AimTabBtn.Text = "AIM (Ngắm bắn)"
AimTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
AimTabBtn.TextSize = 13
AimTabBtn.Parent = TabBar
Instance.new("UICorner", AimTabBtn).CornerRadius = UDim.new(0, 6)

local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, -20, 1, -85)
MainContent.Position = UDim2.new(0, 10, 0, 78)
MainContent.BackgroundTransparency = 1
MainContent.CanvasSize = UDim2.new(0, 0, 2.5, 0)
MainContent.ScrollBarThickness = 3
MainContent.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 30)
MainContent.Visible = true
MainContent.Parent = MainFrame

local AimContent = Instance.new("ScrollingFrame")
AimContent.Size = UDim2.new(1, -20, 1, -85)
AimContent.Position = UDim2.new(0, 10, 0, 78)
AimContent.BackgroundTransparency = 1
AimContent.CanvasSize = UDim2.new(0, 0, 2.0, 0)
AimContent.ScrollBarThickness = 3
AimContent.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 30)
AimContent.Visible = false
AimContent.Parent = MainFrame

MainTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    AimContent.Visible = false
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AimTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

AimTabBtn.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    AimContent.Visible = true
    AimTabBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
    AimTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

local function CreateElement(parent, posY, title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.Position = UDim2.new(0, 0, 0, posY)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 50, 50)
    stroke.Thickness = 1
    stroke.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Text = title
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.15, true)
        end
        callback(state)
    end)
end

local function CreateNumberControl(parent, posY, title, initialValue, step, minVal, maxVal, callback)
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
    valBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    valBox.Font = Enum.Font.SourceSansBold
    valBox.Text = tostring(initialValue)
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
        valBox.Text = tostring(curVal)
        callback(curVal)
    end)
    decBtn.MouseButton1Click:Connect(function()
        curVal = curVal - step
        if curVal < minVal then curVal = minVal end
        valBox.Text = tostring(curVal)
        callback(curVal)
    end)
end
-- ==================== TAB 1: MAIN CONTENT (PHẦN 2) ====================

local hitboxEnabled = false
local hitboxSize = 5
CreateToggle(MainContent, 0, "Mở rộng Hitbox (Tăng tầm đánh)", function(state) hitboxEnabled = state end)
CreateNumberControl(MainContent, 48, "   ↳ Kích thước Hitbox", 5, 2, 2, 1000, function(val) hitboxSize = val end)

RunService.RenderStepped:Connect(function()
    if hitboxEnabled then
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.7
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

local antiKbEnabled = false
CreateToggle(MainContent, 96, "Anti Knockback (Chống bật lùi)", function(state) antiKbEnabled = state end)

RunService.Stepped:Connect(function()
    if antiKbEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                if hrp.AssemblyLinearVelocity.Magnitude > 100 then
                    hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                end
            end
        end)
    end
end)

local espEnabled = false
CreateToggle(MainContent, 144, "ESP Player (Xuyên tường + Tên)", function(state) espEnabled = state end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local rootPart = p.Character:FindFirstChild("HumanoidRootPart")
                local head = p.Character:FindFirstChild("Head")
                local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                
                if rootPart and head and humanoid and humanoid.Health > 0 then
                    local box = p.Character:FindFirstChild("ESPBox")
                    local nameTag = head:FindFirstChild("ESPNameTag")
                    
                    if espEnabled then
                        if not box then
                            box = Instance.new("BoxHandleAdornment")
                            box.Name = "ESPBox"
                            box.Adornee = rootPart
                            box.Size = Vector3.new(3, 5, 2)
                            box.Color3 = Color3.fromRGB(220, 20, 30)
                            box.Transparency = 0.4
                            box.AlwaysOnTop = true
                            box.ZIndex = 5
                            box.Parent = p.Character
                        end
                        if not nameTag then
                            nameTag = Instance.new("BillboardGui")
                            nameTag.Name = "ESPNameTag"
                            nameTag.Size = UDim2.new(0, 100, 0, 40)
                            nameTag.StudsOffset = Vector3.new(0, 2.5, 0)
                            nameTag.AlwaysOnTop = true
                            nameTag.Parent = head
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Name = "NameText"
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Font = Enum.Font.SourceSansBold
                            textLabel.Text = p.Name
                            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            textLabel.TextSize = 14
                            textLabel.TextStrokeTransparency = 0
                            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            textLabel.Parent = nameTag
                        end
                    else
                        if box then box:Destroy() end
                        if nameTag then nameTag:Destroy() end
                    end
                end
            end
        end
    end)
end)

local speedEnabled = false
local speedVal = 1
CreateToggle(MainContent, 192, "Speed Boost (Tốc độ CFrame)", function(state) speedEnabled = state end)
CreateNumberControl(MainContent, 240, "   ↳ Độ phóng (Multi)", 1, 1, 1, 5, function(val) speedVal = val end)

RunService.RenderStepped:Connect(function()
    if speedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
                local hrp = char.HumanoidRootPart
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * (speedVal * 0.8))
                end
            end
        end)
    end
end)

local flyEnabled = false
local flySpeed = 50

local FlyGui = Instance.new("ScreenGui")
FlyGui.Name = "FlyControlGui"
FlyGui.ResetOnSpawn = false
pcall(function() FlyGui.Parent = CoreGui end)
if not FlyGui.Parent then FlyGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
FlyGui.Enabled = false

local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 160, 0, 140)
FlyFrame.Position = UDim2.new(0.8, -80, 0.4, -70)
FlyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FlyFrame.BorderSizePixel = 0
FlyFrame.Active = true
FlyFrame.Draggable = true
FlyFrame.Parent = FlyGui
Instance.new("UICorner", FlyFrame).CornerRadius = UDim.new(0, 8)

local FlyStroke = Instance.new("UIStroke")
FlyStroke.Color = Color3.fromRGB(220, 20, 30)
FlyStroke.Thickness = 2
FlyStroke.Parent = FlyFrame

local FlyTitle = Instance.new("TextLabel")
FlyTitle.Size = UDim2.new(1, 0, 0, 25)
FlyTitle.BackgroundTransparency = 1
FlyTitle.Font = Enum.Font.SourceSansBold
FlyTitle.Text = "🚀 FLY CONTROLS"
FlyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyTitle.TextSize = 12
FlyTitle.Parent = FlyFrame

local UpBtn = Instance.new("TextButton")
UpBtn.Size = UDim2.new(0, 65, 0, 35)
UpBtn.Position = UDim2.new(0, 10, 0, 35)
UpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UpBtn.Font = Enum.Font.SourceSansBold
UpBtn.Text = "UP (▲)"
UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpBtn.TextSize = 11
UpBtn.Parent = FlyFrame
Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 6)

local DownBtn = Instance.new("TextButton")
DownBtn.Size = UDim2.new(0, 65, 0, 35)
DownBtn.Position = UDim2.new(0, 85, 0, 35)
DownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DownBtn.Font = Enum.Font.SourceSansBold
DownBtn.Text = "DOWN (▼)"
DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DownBtn.TextSize = 11
DownBtn.Parent = FlyFrame
Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 6)

local SpeedLbl = Instance.new("TextLabel")
SpeedLbl.Size = UDim2.new(1, 0, 0, 20)
SpeedLbl.Position = UDim2.new(0, 0, 0, 75)
SpeedLbl.BackgroundTransparency = 1
SpeedLbl.Font = Enum.Font.SourceSansBold
SpeedLbl.Text = "Speed: 50"
SpeedLbl.TextColor3 = Color3.fromRGB(220, 20, 30)
SpeedLbl.TextSize = 11
SpeedLbl.Parent = FlyFrame

local PlusFly = Instance.new("TextButton")
PlusFly.Size = UDim2.new(0, 65, 0, 25)
PlusFly.Position = UDim2.new(0, 85, 0, 100)
PlusFly.BackgroundColor3 = Color3.fromRGB(220, 20, 30)
PlusFly.Font = Enum.Font.SourceSansBold
PlusFly.Text = "Tốc độ +"
PlusFly.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusFly.TextSize = 10
PlusFly.Parent = FlyFrame
Instance.new("UICorner", PlusFly).CornerRadius = UDim.new(0, 4)

local MinusFly = Instance.new("TextButton")
MinusFly.Size = UDim2.new(0, 65, 0, 25)
MinusFly.Position = UDim2.new(0, 10, 0, 100)
MinusFly.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinusFly.Font = Enum.Font.SourceSansBold
MinusFly.Text = "Tốc độ -"
MinusFly.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusFly.TextSize = 10
MinusFly.Parent = FlyFrame
Instance.new("UICorner", MinusFly).CornerRadius = UDim.new(0, 4)

PlusFly.MouseButton1Click:Connect(function()
    flySpeed = math.clamp(flySpeed + 15, 20, 200)
    SpeedLbl.Text = "Speed: " .. tostring(flySpeed)
end)

MinusFly.MouseButton1Click:Connect(function()
    flySpeed = math.clamp(flySpeed - 15, 20, 200)
    SpeedLbl.Text = "Speed: " .. tostring(flySpeed)
end)

CreateToggle(MainContent, 288, "Fly Mode + Fly GUI", function(state)
    flyEnabled = state
    FlyGui.Enabled = state
end)

local flyingUp = false
local flyingDown = false
UpBtn.MouseButton1Down:Connect(function() flyingUp = true end)
UpBtn.MouseButton1Up:Connect(function() flyingUp = false end)
DownBtn.MouseButton1Down:Connect(function() flyingDown = true end)
DownBtn.MouseButton1Up:Connect(function() flyingDown = false end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if flyEnabled then
                humanoid.PlatformStand = true
                local moveDir = humanoid.MoveDirection
                local velocity = moveDir * flySpeed
                if flyingUp then velocity = velocity + Vector3.new(0, flySpeed, 0)
                elseif flyingDown then velocity = velocity + Vector3.new(0, -flySpeed, 0)
                else velocity = velocity + Vector3.new(0, 0.1, 0) end
                hrp.Velocity = velocity
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
            else
                if humanoid and humanoid.PlatformStand then humanoid.PlatformStand = false end
            end
        end
    end)
end)

CreateToggle(MainContent, 336, "Godmode (Máu vô hạn giả lập)", function(state)
    _G.Godmode = state
end)

RunService.Stepped:Connect(function()
    if _G.Godmode then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").MaxHealth = math.huge
                char:FindFirstChildOfClass("Humanoid").Health = math.huge
            end
        end)
    end
end)

CreateToggle(MainContent, 384, "Infinite Jump (Nhảy vô hạn)", function(state) 
    _G.InfJump = state 
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

local airWalkPart = nil
CreateToggle(MainContent, 432, "Air Walk (Đi bộ trên không)", function(state) 
    _G.AirWalk = state 
    if not _G.AirWalk and airWalkPart then
        airWalkPart:Destroy()
        airWalkPart = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.AirWalk then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                if not airWalkPart or not airWalkPart.Parent then
                    airWalkPart = Instance.new("Part")
                    airWalkPart.Name = "AirWalkPlatform"
                    airWalkPart.Size = Vector3.new(4, 1, 4)
                    airWalkPart.Transparency = 1
                    airWalkPart.Anchored = true
                    airWalkPart.Parent = Workspace
                end
                airWalkPart.CFrame = hrp.CFrame - Vector3.new(0, 3.5, 0)
            end
        end)
    else
        if airWalkPart then airWalkPart:Destroy(); airWalkPart = nil end
    end
end)
-- ==================== ANTI-AFK (CHỐNG KICK ĐỨNG IM) ====================
pcall(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Anti-Afk-script-203676"))()
end)

-- ==================== TAB 2: AIM CONTENT (PHẦN 3) ====================

local aimbotEnabled = false
CreateToggle(AimContent, 0, "Aimbot (Tự động khóa đầu)", function(state) aimbotEnabled = state end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        pcall(function()
            local closestTarget = nil
            local shortestDist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                    local head = p.Character.Head
                    if humanoid and humanoid.Health > 0 then
                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local origin = Camera.CFrame.Position
                            local direction = (head.Position - origin)
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            local raycastResult = Workspace:Raycast(origin, direction, raycastParams)
                            local isVisible = true
                            if raycastResult and not raycastResult.Instance:IsDescendantOf(p.Character) then
                                isVisible = false
                            end
                            if isVisible then
                                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                                local screenDist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                                if screenDist < shortestDist then
                                    shortestDist = screenDist
                                    closestTarget = head
                                end
                            end
                        end
                    end
                end
            end
            if closestTarget then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
            end
        end)
    end
end)

local aimAssistEnabled = false
local fovCircleEnabled = true
local fovRadius = 120

CreateToggle(AimContent, 48, "Aim Assist & FOV Targeting", function(state) aimAssistEnabled = state end)
CreateToggle(AimContent, 96, "   ↳ Hiển thị vòng tròn FOV", function(state) fovCircleEnabled = state if FOVring then FOVring.Visible = state end end)
CreateNumberControl(AimContent, 144, "   ↳ Cỡ FOV Radius", 120, 10, 50, 400, function(val) fovRadius = val end)

local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Filled = false
FOVring.Thickness = 1.5
FOVring.Color = Color3.fromRGB(220, 20, 30)
FOVring.NumSides = 64

RunService.RenderStepped:Connect(function()
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if aimAssistEnabled and fovCircleEnabled then
        FOVring.Visible = true
        FOVring.Radius = fovRadius
        FOVring.Position = screenCenter
    else
        FOVring.Visible = false
    end

    if aimAssistEnabled then
        pcall(function()
            local closestTarget = nil
            local shortestDist = fovRadius
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                    local head = p.Character.Head
                    if humanoid and humanoid.Health > 0 then
                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local origin = Camera.CFrame.Position
                            local direction = (head.Position - origin)
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            local raycastResult = Workspace:Raycast(origin, direction, raycastParams)
                            local isVisible = true
                            if raycastResult and not raycastResult.Instance:IsDescendantOf(p.Character) then
                                isVisible = false
                            end
                            if isVisible then
                                local screenDist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                                if screenDist < shortestDist then
                                    shortestDist = screenDist
                                    closestTarget = head
                                end
                            end
                        end
                    end
                end
            end
            if closestTarget then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, closestTarget.Position), 0.50)
            end
        end)
    end
end)

local camLockEnabled = false
CreateToggle(AimContent, 192, "CamLock / Aimbot (Khóa tâm địch)", function(state) camLockEnabled = state end)

RunService.RenderStepped:Connect(function()
    if camLockEnabled then
        pcall(function()
            local closestPlayer = nil
            local shortestDist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                closestPlayer = p
                            end
                        end
                    end
                end
            end
            if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
            end
        end)
    end
end)

local silentAimEnabled = false
CreateToggle(AimContent, 240, "Silent Aim (Aim không cần nhìn)", function(state) silentAimEnabled = state end)

local function GetClosestTargetForSilentAim()
    local closestTarget = nil
    local shortestDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
            local head = p.Character.Head
            if humanoid and humanoid.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestTarget = head
                    end
                end
            end
        end
    end
    return closestTarget
end

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if silentAimEnabled and (method == "FireServer" or method == "InvokeServer") then
        local target = GetClosestTargetForSilentAim()
        if target then
            for i, v in pairs(args) do
                if typeof(v) == "Vector3" then
                    args[i] = target.Position
                elseif typeof(v) == "CFrame" then
                    args[i] = CFrame.new(v.Position, target.Position)
                end
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)
