-- ==================== BLOX FRUITS - Auto catch chest v1.2 ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local autoChestEnabled = false
local stopOnSpecialItem = true
local moveSpeed = 350 -- Tốc độ bay
local collectedChests = {}

-- Xóa Menu cũ nếu tồn tại
pcall(function()
    if PlayerGui:FindFirstChild("AutoCatchChestHub") then
        PlayerGui.AutoCatchChestHub:Destroy()
    end
end)

-- Tạo GUI Giao diện Menu
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCatchChestHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 230)
MainFrame.Position = UDim2.new(0, 60, 0, 140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 120, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Auto catch chest v1.2"
Title.TextColor3 = Color3.fromRGB(100, 180, 255)
Title.TextSize = 13
Title.Parent = MainFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = MainFrame
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 4)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 200, 0, 32)
ToggleBtn.Position = UDim2.new(0, 10, 0, 38)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Auto Chest: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
ToggleBtn.TextSize = 13
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local StopToggleBtn = Instance.new("TextButton")
StopToggleBtn.Size = UDim2.new(0, 200, 0, 32)
StopToggleBtn.Position = UDim2.new(0, 10, 0, 75)
StopToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
StopToggleBtn.Font = Enum.Font.SourceSansBold
StopToggleBtn.Text = "Stop Key/Chén: BẬT"
StopToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
StopToggleBtn.TextSize = 12
StopToggleBtn.Parent = MainFrame
Instance.new("UICorner", StopToggleBtn).CornerRadius = UDim.new(0, 6)

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 200, 0, 32)
SpeedBox.Position = UDim2.new(0, 10, 0, 112)
SpeedBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpeedBox.Font = Enum.Font.SourceSansBold
SpeedBox.Text = "Tốc độ: 350"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 12
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = MainFrame
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 152)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.Text = "Trạng thái: Đang chờ..."
StatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
StatusLabel.TextSize = 11
StatusLabel.Parent = MainFrame

-- Thu gọn Menu
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MinimizeBtn.Text = "+"
        MainFrame.Size = UDim2.new(0, 220, 0, 45)
        ToggleBtn.Visible = false
        StopToggleBtn.Visible = false
        SpeedBox.Visible = false
        StatusLabel.Visible = false
    else
        MinimizeBtn.Text = "-"
        MainFrame.Size = UDim2.new(0, 220, 0, 230)
        ToggleBtn.Visible = true
        StopToggleBtn.Visible = true
        SpeedBox.Visible = true
        StatusLabel.Visible = true
    end
end)

SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text:match("%d+"))
    if num and num > 0 then
        moveSpeed = num
        SpeedBox.Text = "Tốc độ: " .. moveSpeed
    else
        SpeedBox.Text = "Tốc độ: " .. moveSpeed
    end
end)

local function HasSpecialItem()
    local found = false
    pcall(function()
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                local name = item.Name:lower()
                if name:find("key") or name:find("chalice") or name:find("fist") then
                    found = true
                end
            end
        end
        local char = LocalPlayer.Character
        if char then
            for _, item in pairs(char:GetChildren()) do
                if item:IsA("Tool") then
                    local name = item.Name:lower()
                    if name:find("key") or name:find("chalice") or name:find("fist") then
                        found = true
                    end
                end
            end
        end
    end)
    return found
end

ToggleBtn.MouseButton1Click:Connect(function()
    autoChestEnabled = not autoChestEnabled
    if autoChestEnabled then
        ToggleBtn.Text = "Auto Chest: BẬT"
        ToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
        StatusLabel.Text = "Trạng thái: Đang bay săn rương..."
    else
        ToggleBtn.Text = "Auto Chest: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        StatusLabel.Text = "Trạng thái: Đã dừng."
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.PlatformStand = false end
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end)

StopToggleBtn.MouseButton1Click:Connect(function()
    stopOnSpecialItem = not stopOnSpecialItem
    if stopOnSpecialItem then
        StopToggleBtn.Text = "Stop Key/Chén: BẬT"
        StopToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        StopToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
    else
        StopToggleBtn.Text = "Stop Key/Chén: TẮT"
        StopToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        StopToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end
end)

-- Quét tìm rương gần nhất
local targetChest = nil
task.spawn(function()
    while true do
        if autoChestEnabled then
            local nearest = nil
            local shortest = math.huge
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPos = char.HumanoidRootPart.Position
                    
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") then
                            local nameLower = obj.Name:lower()
                            if (nameLower:find("chest") or nameLower:find("treasure"))
                                and not nameLower:find("secret")
                                and not nameLower:find("quest")
                                and not nameLower:find("rengoku")
                                and
                                        
