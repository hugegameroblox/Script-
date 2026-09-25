-- ==================== AUTO CHEST FULL OPTION (CÓ Ô CHỈNH TỐC ĐỘ TRONG GAME) ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local autoChestEnabled = false
local stopOnSpecialItem = true
local chestSpeed = 350 -- Tốc độ mặc định ban đầu

-- Xóa Menu cũ nếu tồn tại
pcall(function()
    if PlayerGui:FindFirstChild("AutoChestOnlyUI") then
        PlayerGui.AutoChestOnlyUI:Destroy()
    end
end)

-- Tạo GUI giao diện chính (tăng chiều cao để chứa ô chỉnh tốc độ)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoChestOnlyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Position = UDim2.new(0, 50, 0, 150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "🎁 Auto Chest Custom"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Parent = MainFrame

-- Nút Bật/Tắt Auto Chest
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 180, 0, 32)
ToggleBtn.Position = UDim2.new(0, 10, 0, 32)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Auto Chest: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.TextSize = 13
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

-- Nút Bật/Tắt Stop khi có Key/Chén Thánh
local StopToggleBtn = Instance.new("TextButton")
StopToggleBtn.Size = UDim2.new(0, 180, 0, 32)
StopToggleBtn.Position = UDim2.new(0, 10, 0, 70)
StopToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
StopToggleBtn.Font = Enum.Font.SourceSansBold
StopToggleBtn.Text = "Stop Key/Chén: BẬT"
StopToggleBtn.TextColor3 = Color3.fromRGB(60, 255, 60)
StopToggleBtn.TextSize = 12
StopToggleBtn.Parent = MainFrame
Instance.new("UICorner", StopToggleBtn).CornerRadius = UDim.new(0, 6)

-- Ô nhập tốc độ trực tiếp trong game (TextBox)
local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 180, 0, 32)
SpeedBox.Position = UDim2.new(0, 10, 0, 108)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
SpeedBox.Font = Enum.Font.SourceSansBold
SpeedBox.Text = "Tốc độ: 350"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 12
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = MainFrame
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

-- Xử lý khi nhập xong tốc độ
SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text:match("%d+"))
    if num and num > 0 then
        chestSpeed = num
        SpeedBox.Text = "Tốc độ: " .. chestSpeed
    else
        SpeedBox.Text = "Tốc độ: " .. chestSpeed
    end
end)

-- Hàm kiểm tra vật phẩm đặc biệt
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

-- Xử lý sự kiện bấm nút Auto Chest
ToggleBtn.MouseButton1Click:Connect(function()
    autoChestEnabled = not autoChestEnabled
    if autoChestEnabled then
        ToggleBtn.Text = "Auto Chest: BẬT"
        ToggleBtn.TextColor3 = Color3.fromRGB(60, 255, 60)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
    else
        ToggleBtn.Text = "Auto Chest: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    end
end)

-- Xử lý sự kiện bấm nút Stop
StopToggleBtn.MouseButton1Click:Connect(function()
    stopOnSpecialItem = not stopOnSpecialItem
    if stopOnSpecialItem then
        StopToggleBtn.Text = "Stop Key/Chén: BẬT"
        StopToggleBtn.TextColor3 = Color3.fromRGB(60, 255, 60)
        StopToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
    else
        StopToggleBtn.Text = "Stop Key/Chén: TẮT"
        StopToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
        StopToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    end
end)

-- HỆ THỐNG QUÉT RƯƠNG TOÀN MAP
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
                                and not nameLower:find("door") then
                                
                                local part = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local dist = (rootPos - part.Position).Magnitude
                                    if dist < shortest then
                                        shortest = dist
                                        nearest = part
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            targetChest = nearest
        else
            targetChest = nil
        end
        task.wait(1)
    end
end)

-- HỆ THỐNG BAY LƯỚT (TWEEN) DÙNG TỐC ĐỘ TÙY CHỈNH
local currentTween = nil

task.spawn(function()
    while true do
        task.wait(0.1)
        if autoChestEnabled then
            if stopOnSpecialItem and HasSpecialItem() then
                autoChestEnabled = false
                targetChest = nil
                ToggleBtn.Text = "Auto Chest: TẮT"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
                if currentTween then currentTween:Cancel() end
            else
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPart = char.HumanoidRootPart
                    
                    if targetChest and targetChest.Parent then
                        local destCFrame = targetChest.CFrame + Vector3.new(0, 3, 0)
                        local distance = (rootPart.Position - targetChest.Position).Magnitude
                        
                        -- Lấy giá trị tốc độ động từ biến chestSpeed do người dùng nhập
                        local travelTime = distance / chestSpeed
                        if travelTime < 0.1 then travelTime = 0.1 end
                        
                        if not currentTween or currentTween.PlaybackState ~= Enum.PlaybackState.Playing then
                            local info = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
                            currentTween = TweenService:Create(rootPart, info, {CFrame = destCFrame})
                            currentTween:Play()
                        end
                    end
                end
            end
        else
            if currentTween then
                currentTween:Cancel()
                currentTween = nil
            end
        end
    end
end)
