-- PRO HUGE HUB - FULL FEATURES (Red Neon Theme)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
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
MainFrame.Size = UDim2.new(0, 520, 0, 380)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(220, 20, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- LEFT SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -20)
Sidebar.Position = UDim2.new(0, 10, 0, 10)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.BorderSizePixel = 1
Sidebar.BorderColor3 = Color3.fromRGB(200, 20, 30)
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

-- Logo Rocket Icon & Title
local LogoImg = Instance.new("ImageLabel")
LogoImg.Size = UDim2.new(0, 45, 0, 45)
LogoImg.Position = UDim2.new(0.5, -22.5, 0, 12)
LogoImg.BackgroundTransparency = 1
LogoImg.Image = "rbxassetid://6031082533"
LogoImg.ImageColor3 = Color3.fromRGB(230, 30, 40)
LogoImg.Parent = Sidebar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 35)
LogoText.Position = UDim2.new(0, 0, 0, 58)
LogoText.BackgroundTransparency = 1
LogoText.Font = Enum.Font.SourceSansBold
LogoText.Text = "PRO HUGE\nHUB"
LogoText.TextColor3 = Color3.fromRGB(230, 30, 40)
LogoText.TextSize = 12
LogoText.Parent = Sidebar

-- Tab Buttons
local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Size = UDim2.new(0.88, 0, 0, 32)
MainTabBtn.Position = UDim2.new(0.06, 0, 0.32, 0)
MainTabBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 30)
MainTabBtn.Font = Enum.Font.SourceSansBold
MainTabBtn.Text = "🏠  MAIN"
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabBtn.TextSize = 12
MainTabBtn.Parent = Sidebar
Instance.new("UICorner", MainTabBtn).CornerRadius = UDim.new(0, 6)

local ServerTabBtn = Instance.new("TextButton")
ServerTabBtn.Size = UDim2.new(0.88, 0, 0, 32)
ServerTabBtn.Position = UDim2.new(0.06, 0, 0.43, 0)
ServerTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ServerTabBtn.Font = Enum.Font.SourceSansBold
ServerTabBtn.Text = "🌐  SERVER"
ServerTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
ServerTabBtn.TextSize = 12
ServerTabBtn.Parent = Sidebar
Instance.new("UICorner", ServerTabBtn).CornerRadius = UDim.new(0, 6)

-- Close Button
local CloseMenuBtn = Instance.new("TextButton")
CloseMenuBtn.Size = UDim2.new(0.88, 0, 0, 32)
CloseMenuBtn.Position = UDim2.new(0.06, 0, 0.88, 0)
CloseMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 15)
CloseMenuBtn.BorderSizePixel = 1
CloseMenuBtn.BorderColor3 = Color3.fromRGB(180, 20, 30)
CloseMenuBtn.Font = Enum.Font.SourceSansBold
CloseMenuBtn.Text = "❌  CLOSE"
CloseMenuBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseMenuBtn.TextSize = 12
CloseMenuBtn.Parent = Sidebar
Instance.new("UICorner", CloseMenuBtn).CornerRadius = UDim.new(0, 6)

-- Toggle Icon Open Hub
local OpenHubBtn = Instance.new("ImageButton")
OpenHubBtn.Size = UDim2.new(0, 45, 0, 45)
OpenHubBtn.Position = UDim2.new(0, 20, 0.4, 0)
OpenHubBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
OpenHubBtn.BorderSizePixel = 1
OpenHubBtn.BorderColor3 = Color3.fromRGB(220, 20, 30)
OpenHubBtn.Image = "rbxassetid://6031082533"
OpenHubBtn.ImageColor3 = Color3.fromRGB(230, 30, 40)
OpenHubBtn.Visible = false
OpenHubBtn.Active = true
OpenHubBtn.Draggable = true
OpenHubBtn.Parent = ScreenGui
Instance.new("UICorner", OpenHubBtn).CornerRadius = UDim.new(0, 22.5)

CloseMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenHubBtn.Visible = true
end)

OpenHubBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenHubBtn.Visible = false
end)

-- RIGHT AREA
local RightArea = Instance.new("Frame")
RightArea.Size = UDim2.new(1, -155, 1, -20)
RightArea.Position = UDim2.new(0, 145, 0, 10)
RightArea.BackgroundTransparency = 1
RightArea.Parent = MainFrame

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -30, 0, 25)
HeaderTitle.Position = UDim2.new(0, 0, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Font = Enum.Font.SourceSansBold
HeaderTitle.Text = "⚡ Pro huge hub | hop server"
HeaderTitle.TextColor3 = Color3.fromRGB(220, 30, 40)
HeaderTitle.TextSize = 14
HeaderTitle.Parent = RightArea

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -25, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 16
MinBtn.Parent = RightArea
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenHubBtn.Visible = true
end)

-- TABS
local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, 0, 1, -35)
MainContent.Position = UDim2.new(0, 0, 0, 35)
MainContent.BackgroundTransparency = 1
MainContent.CanvasSize = UDim2.new(0, 0, 1.45, 0)
MainContent.ScrollBarThickness = 3
MainContent.ScrollBarImageColor3 = Color3.fromRGB(200, 20, 30)
MainContent.Visible = true
MainContent.Parent = RightArea

local ServerContent = Instance.new("ScrollingFrame")
ServerContent.Size = UDim2.new(1, 0, 1, -35)
ServerContent.Position = UDim2.new(0, 0, 0, 35)
ServerContent.BackgroundTransparency = 1
ServerContent.CanvasSize = UDim2.new(0, 0, 1.1, 0)
ServerContent.ScrollBarThickness = 3
ServerContent.ScrollBarImageColor3 = Color3.fromRGB(200, 20, 30)
ServerContent.Visible = false
ServerContent.Parent = RightArea

local function SwitchTab(activeTab, activeBtn)
    MainContent.Visible = (activeTab == MainContent)
    ServerContent.Visible = (activeTab == ServerContent)

    MainTabBtn.BackgroundColor3 = (activeBtn == MainTabBtn) and Color3.fromRGB(180, 20, 30) or Color3.fromRGB(25, 25, 30)
    MainTabBtn.TextColor3 = (activeBtn == MainTabBtn) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)

    ServerTabBtn.BackgroundColor3 = (activeBtn == ServerTabBtn) and Color3.fromRGB(180, 20, 30) or Color3.fromRGB(25, 25, 30)
    ServerTabBtn.TextColor3 = (activeBtn == ServerTabBtn) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
end

MainTabBtn.MouseButton1Click:Connect(function() SwitchTab(MainContent, MainTabBtn) end)
ServerTabBtn.MouseButton1Click:Connect(function() SwitchTab(ServerContent, ServerTabBtn) end)

-- UI HELPERS
local function CreateCard(parent, posY, height, title, subText)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0.98, 0, 0, height)
    card.Position = UDim2.new(0, 0, 0, posY)
    card.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    card.BorderSizePixel = 1
    card.BorderColor3 = Color3.fromRGB(45, 15, 20)
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(0.6, 0, 0, 20)
    tLabel.Position = UDim2.new(0, 12, 0, 8)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.SourceSansBold
    tLabel.Text = title
    tLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tLabel.TextSize = 13
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.Parent = card

    if subText then
        local sLabel = Instance.new("TextLabel")
        sLabel.Size = UDim2.new(0.6, 0, 0, 15)
        sLabel.Position = UDim2.new(0, 12, 0, 26)
        sLabel.BackgroundTransparency = 1
        sLabel.Font = Enum.Font.SourceSans
        sLabel.Text = subText
        sLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
        sLabel.TextSize = 11
        sLabel.TextXAlignment = Enum.TextXAlignment.Left
        sLabel.Parent = card
    end

    return card
end

local function CreateToggle(card, defaultState, callback)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 24)
    toggleBtn.Position = UDim2.new(1, -62, 0.5, -12)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(200, 20, 30) or Color3.fromRGB(40, 40, 45)
    toggleBtn.Text = ""
    toggleBtn.Parent = card
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 12)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = defaultState and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(0, 9)

    local stateText = Instance.new("TextLabel")
    stateText.Size = UDim2.new(0, 25, 1, 0)
    stateText.Position = defaultState and UDim2.new(0, 4, 0, 0) or UDim2.new(1, -29, 0, 0)
    stateText.BackgroundTransparency = 1
    stateText.Font = Enum.Font.SourceSansBold
    stateText.Text = defaultState and "ON" or "OFF"
    stateText.TextColor3 = Color3.fromRGB(255, 255, 255)
    stateText.TextSize = 9
    stateText.Parent = toggleBtn

    local state = defaultState
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(200, 20, 30) or Color3.fromRGB(40, 40, 45)
        circle.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        stateText.Position = state and UDim2.new(0, 4, 0, 0) or UDim2.new(1, -29, 0, 0)
        stateText.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

local function CreateNumberControl(card, initialValue, step, maxVal, callback)
    local decBtn = Instance.new("TextButton")
    decBtn.Size = UDim2.new(0, 35, 0, 26)
    decBtn.Position = UDim2.new(1, -145, 0.5, -13)
    decBtn.BackgroundColor3 = Color3.fromRGB(150, 20, 30)
    decBtn.Font = Enum.Font.SourceSansBold
    decBtn.Text = "-"
    decBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    decBtn.TextSize = 16
    decBtn.Parent = card
    Instance.new("UICorner", decBtn).CornerRadius = UDim.new(0, 6)

    local valBox = Instance.new("TextLabel")
    valBox.Size = UDim2.new(0, 60, 0, 26)
    valBox.Position = UDim2.new(1, -105, 0.5, -13)
    valBox.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    valBox.BorderSizePixel = 1
    valBox.BorderColor3 = Color3.fromRGB(150, 20, 30)
    valBox.Font = Enum.Font.SourceSansBold
    valBox.Text = tostring(initialValue)
    valBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valBox.TextSize = 12
    valBox.Parent = card
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 6)

    local incBtn = Instance.new("TextButton")
    incBtn.Size = UDim2.new(0, 35, 0, 26)
    incBtn.Position = UDim2.new(1, -40, 0.5, -13)
    incBtn.BackgroundColor3 = Color3.fromRGB(150, 20, 30)
    incBtn.Font = Enum.Font.SourceSansBold
    incBtn.Text = "+"
    incBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    incBtn.TextSize = 16
    incBtn.Parent = card
    Instance.new("UICorner", incBtn).CornerRadius = UDim.new(0, 6)

    local curVal = initialValue
    incBtn.MouseButton1Click:Connect(function()
        curVal = curVal + step
        if curVal > maxVal then curVal = maxVal end
        valBox.Text = tostring(curVal)
        callback(curVal)
    end)

    decBtn.MouseButton1Click:Connect(function()
        curVal = curVal - step
        if curVal < 10 then curVal = 10 end
        valBox.Text = tostring(curVal)
        callback(curVal)
    end)
end

-- ==================== TAB MAIN ====================
-- 1. FLY
local flyCard = CreateCard(MainContent, 0, 50, "🚀 FLY", "Bay tự do trong game")
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

CreateToggle(flyCard, false, function(state)
    flying = state
    if flying then startFly() else stopFly() end
end)

-- 2. CFRAME SPEED
local speedCard = CreateCard(MainContent, 57, 65, "⚡ SPEED", "Tốc độ di chuyển (Max 500)")
local currentSpeed = 10
local speedEnabled = false
CreateToggle(speedCard, false, function(state)
    speedEnabled = state
end)
CreateNumberControl(speedCard, 10, 10, 500, function(newVal)
    currentSpeed = newVal
end)

-- 3. ESP PLAYER
local espCard = CreateCard(MainContent, 129, 50, "👁️ ESP PLAYER", "Hiển thị khung đỏ & tên người chơi")
local espEnabled = false
CreateToggle(espCard, false, function(state)
    espEnabled = state
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            if not state then
                if p.Character:FindFirstChild("EspHighlight") then p.Character.EspHighlight:Destroy() end
                local head = p.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("EspNameTag") then head.EspNameTag:Destroy() end
            end
        end
    end
end)

-- 4. ANTI AFK
local afkCard = CreateCard(MainContent, 186, 50, "🛡️ ANTI AFK", "Chống treo máy bị văng khỏi game")
local afkEnabled = false
CreateToggle(afkCard, false, function(state)
    afkEnabled = state
end)

-- ==================== TAB SERVER ====================
-- 1. HOP SERVER
local hopCard = CreateCard(ServerContent, 0, 55, "🌐 HOP SERVER", "Tìm server ít người hơn")
local hopActionBtn = Instance.new("TextButton", hopCard)
hopActionBtn.Size = UDim2.new(0, 80, 0, 26)
hopActionBtn.Position = UDim2.new(1, -90, 0.5, -13)
hopActionBtn.BackgroundColor3 = Color3.fromRGB(200, 20, 30)
hopActionBtn.Font = Enum.Font.SourceSansBold
hopActionBtn.Text = "HOP"
hopActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopActionBtn.TextSize = 12
Instance.new("UICorner", hopActionBtn).CornerRadius = UDim.new(0, 6)

hopActionBtn.MouseButton1Click:Connect(function()
    hopActionBtn.Text = "WAIT..."
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
    hopActionBtn.Text = "HOP"
end)

-- 2. REJOIN SERVER
local rejoinCard = CreateCard(ServerContent, 62, 55, "🔄 REJOIN SERVER", "Vào lại ngay server này")
local rejoinActionBtn = Instance.new("TextButton", rejoinCard)
rejoinActionBtn.Size = UDim2.new(0, 80, 0, 26)
rejoinActionBtn.Position = UDim2.new(1, -90, 0.5, -13)
rejoinActionBtn.BackgroundColor3 = Color3.fromRGB(200, 20, 30)
rejoinActionBtn.Font = Enum.Font.SourceSansBold
rejoinActionBtn.Text = "REJOIN"
rejoinActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinActionBtn.TextSize = 12
Instance.new("UICorner", rejoinActionBtn).CornerRadius = UDim.new(0, 6)

rejoinActionBtn.MouseButton1Click:Connect(function()
    rejoinActionBtn.Text = "WAIT..."
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nRejoining...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

-- ==================== SYSTEM LOGICS ====================
-- Speed Loop
RunService.RenderStepped:Connect(function()
    if speedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local hum = char.Humanoid
                local hrp = char.HumanoidRootPart
                if hum.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (currentSpeed * 0.1))
                end
            end
        end)
    end
end)

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if afkEnabled then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- ESP Logic
local function ApplyEsp(player)
    if player == LocalPlayer then return end
    local function SetupCharacter(char)
        if not char then return end
        task.wait(0.5)
        if espEnabled then
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
                txt.TextColor3 = Color3.fromRGB(255, 60, 60)
                txt.TextSize = 11
                txt.TextStrokeTransparency = 0
                txt.Parent = bill
                bill.Parent = head
            end
        end
    end
    player.CharacterAdded:Connect(SetupCharacter)
    if player.Character then SetupCharacter(player.Character) end
end

for _, p in pairs(Players:GetPlayers()) do ApplyEsp(p) end
Players.PlayerAdded:Connect(ApplyEsp)
