-- PRO PVP HUB - ULTIMATE COMBAT EDITION
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
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PvPHubUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then 
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") 
end

-- MAIN FRAME (ĐEN - VIỀN ĐỎ)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 340)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(220, 20, 30) -- Viền Đỏ
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
Title.Text = "⚔️ ULTIMATE PVP HUB | ALL COMBAT TOOLS"
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

-- CONTENT AREA (TĂNG CANVAS CHO NHIỀU TÍNH NĂNG)
local CombatContent = Instance.new("ScrollingFrame")
CombatContent.Size = UDim2.new(1, -20, 1, -50)
CombatContent.Position = UDim2.new(0, 10, 0, 45)
CombatContent.BackgroundTransparency = 1
CombatContent.CanvasSize = UDim2.new(0, 0, 2.8, 0)
CombatContent.ScrollBarThickness = 3
CombatContent.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 30)
CombatContent.Parent = MainFrame

-- UI HELPERS
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

-- ==================== TẤT CẢ TÍNH NĂNG PVP ====================

-- 1. Hitbox Mở Rộng
local hitboxEnabled = false
local hitboxSize = 5

CreateToggle(CombatContent, 0, "Mở rộng Hitbox (Tăng tầm đánh)", function(state)
    hitboxEnabled = state
end)

CreateNumberControl(CombatContent, 48, "   ↳ Kích thước Hitbox", 5, 2, 2, 1000 , function(val)
    hitboxSize = val
end)

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

-- 2. Anti Knockback (Chống bật lùi)
local antiKbEnabled = false
CreateToggle(CombatContent, 96, "Anti Knockback (Chống bật lùi)", function(state)
    antiKbEnabled = state
end)

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

-- 3 ESP BOX + TÊN NGƯỜI CHƠI
local espEnabled = false
CreateToggle(CombatContent, 144, "ESP Player (Nhìn xuyên tường + Tên)", function(state) espEnabled = state end)

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
                        -- Tạo Box nhìn xuyên tường
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
                        
                        -- Tạo hiện tên trên đầu
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


-- 4. CamLock / Aimbot (Khóa camera theo kẻ địch gần nhất)
local camLockEnabled = false
CreateToggle(CombatContent, 192, "CamLock / Aimbot (Khóa tâm địch)", function(state)
    camLockEnabled = state
end)

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

-- 5. Speed Boost (Tăng tốc độ chạy)
local speedEnabled = false
local speedVal = 24
CreateToggle(CombatContent, 240, "Speed Boost (Tăng tốc chạy)", function(state)
    speedEnabled = state
end)

CreateNumberControl(CombatContent, 288, "   ↳ Tốc độ (WalkSpeed)", 24, 4, 16, 1000, function(val)
    speedVal = val
end)

RunService.Stepped:Connect(function()
    if speedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").WalkSpeed = speedVal
            end
        end)
    end
end)
-- 6 SPEED BOOST FIX (DÙNG CFRAME BẤT CHẤP ANTI-CHEAT)
local speedEnabled = false
local speedVal = 1
CreateToggle(CombatContent, 240, "Speed Boost (Tốc độ CFrame)", function(state) speedEnabled = state end)
CreateNumberControl(CombatContent, 288, "   ↳ Độ phóng (Multi)", 1, 1, 1, 5, function(val) speedVal = val end)

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

-- 7. Fly (Bay lượn né giao tranh)
local flyEnabled = false
CreateToggle(CombatContent, 336, "Fly Mode (Bay lượn PvP)", function(state)
    flyEnabled = state
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if flyEnabled then
                humanoid.PlatformStand = true
                hrp.Velocity = Vector3.new(0, 1, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    hrp.CFrame = hrp.CFrame + (Camera.CFrame.LookVector * 1.5)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    hrp.CFrame = hrp.CFrame - (Camera.CFrame.LookVector * 1.5)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    hrp.CFrame = hrp.CFrame - (Camera.CFrame.RightVector * 1.5)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    hrp.CFrame = hrp.CFrame + (Camera.CFrame.RightVector * 1.5)
                end
            else
                if humanoid and humanoid.PlatformStand then
                    humanoid.PlatformStand = false
                end
            end
        end
    end)
end)
-- 8. INFINITE JUMP (Nhảy liên tục vô hạn trên không)
local infJumpEnabled = false
CreateToggle(CombatContent, 432, "Infinite Jump (Nhảy vô hạn)", function(state) 
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

-- 9. AIR WALK (Đứng/đi lơ lửng trên không như trên mặt đất)
local airWalkEnabled = false
local airWalkPart = nil
CreateToggle(CombatContent, 480, "Air Walk (Đi bộ trên không)", function(state) 
    airWalkEnabled = state 
    if not airWalkEnabled and airWalkPart then
        airWalkPart:Destroy()
        airWalkPart = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if airWalkEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                if not airWalkPart or not airWalkPart.Parent then
                    airWalkPart = Instance.new("Part")
                    airWalkPart.Name = "AirWalkPlatform"
                    airWalkPart.Size = Vector3.new(4, 1, 4)
                    airWalkPart.Transparency = 1 -- Ẩn tàng hình nền đi (muốn test thấy thì đổi thành 0.5)
                    airWalkPart.Anchored = true
                    airWalkPart.Parent = Workspace
                end
                airWalkPart.CFrame = hrp.CFrame - Vector3.new(0, 3.5, 0)
            end
        end)
    else
        if airWalkPart then
            airWalkPart:Destroy()
            airWalkPart = nil
        end
    end
end)

-- 10 . Godmode 
local godmodeEnabled = false
CreateToggle(CombatContent, 384, "Godmode (Hỗ trợ máu vô hạn giả lập)", function(state)
    godmodeEnabled = state
end)

RunService.Stepped:Connect(function()
    if godmodeEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
        end)
    end
end)
