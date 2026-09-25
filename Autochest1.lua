-- ==================== BLOX FRUITS - Auto Chest + Full Options v1.7 ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local running = false
local summonEnabled = true
local speed = 350
local range = 100000
local checked = {}

-- Tọa độ bệ thờ Dark Arena (Sea 2)
local DarkbeardAltarPos = Vector3.new(3715, 13, -3508)

-- Xóa GUI cũ
if PlayerGui:FindFirstChild("ChestHub") then
    PlayerGui.ChestHub:Destroy()
end

-- Tạo GUI Giao diện đầy đủ
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ChestHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 210)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0, 200, 0, 30)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
btn.TextColor3 = Color3.fromRGB(255, 70, 70)
btn.TextSize = 13
btn.Font = Enum.Font.SourceSansBold
btn.Text = "Auto Chest: TẮT"
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

local summonBtn = Instance.new("TextButton", frame)
summonBtn.Size = UDim2.new(0, 200, 0, 30)
summonBtn.Position = UDim2.new(0, 10, 0, 50)
summonBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
summonBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
summonBtn.TextSize = 12
summonBtn.Font = Enum.Font.SourceSansBold
summonBtn.Text = "Auto Summon RâuĐen: BẬT"
Instance.new("UICorner", summonBtn).CornerRadius = UDim.new(0, 6)

local speedBox = Instance.new("TextBox", frame)
speedBox.Size = UDim2.new(0, 200, 0, 30)
speedBox.Position = UDim2.new(0, 10, 0, 90)
speedBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 12
speedBox.Font = Enum.Font.SourceSansBold
speedBox.Text = "Tốc độ: 350"
speedBox.ClearTextOnFocus = false
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

local rangeBox = Instance.new("TextBox", frame)
rangeBox.Size = UDim2.new(0, 200, 0, 30)
rangeBox.Position = UDim2.new(0, 10, 0, 130)
rangeBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
rangeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
rangeBox.TextSize = 12
rangeBox.Font = Enum.Font.SourceSansBold
rangeBox.Text = "Tầm quét: 100000"
rangeBox.ClearTextOnFocus = false
Instance.new("UICorner", rangeBox).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 170)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.Text = "Trạng thái: Đang chờ..."

-- Xử lý nút bật tắt Auto Chest
btn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        btn.Text = "Auto Chest: BẬT"
        btn.TextColor3 = Color3.fromRGB(70, 255, 70)
        btn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
        statusLabel.Text = "Trạng thái: Đang săn rương..."
    else
        btn.Text = "Auto Chest: TẮT"
        btn.TextColor3 = Color3.fromRGB(255, 70, 70)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        statusLabel.Text = "Trạng thái: Đã dừng."
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                char:FindFirstChildOfClass("Humanoid").PlatformStand = false
                char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
        end)
    end
end)

-- Xử lý nút bật tắt Auto Summon Râu Đen
summonBtn.MouseButton1Click:Connect(function()
    summonEnabled = not summonEnabled
    if summonEnabled then
        summonBtn.Text = "Auto Summon RâuĐen: BẬT"
        summonBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        summonBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
    else
        summonBtn.Text = "Auto Summon RâuĐen: TẮT"
        summonBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        summonBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end
end)

-- Cập nhật Tốc độ từ TextBox
speedBox.FocusLost:Connect(function()
    local num = tonumber(speedBox.Text:match("%d+"))
    if num and num > 0 then
        speed = num
        speedBox.Text = "Tốc độ: " .. speed
    else
        speedBox.Text = "Tốc độ: " .. speed
    end
end)

-- Cập nhật Tầm quét từ TextBox
rangeBox.FocusLost:Connect(function()
    local num = tonumber(rangeBox.Text:match("%d+"))
    if num and num > 0 then
        range = num
        rangeBox.Text = "Tầm quét: " .. range
    else
        rangeBox.Text = "Tầm quét: " .. range
    end
end)

-- Hàm kiểm tra Fist of Darkness
local function CheckFist()
    local found = false
    pcall(function()
        for _, container in pairs({LocalPlayer:FindFirstChild("Backpack"), LocalPlayer.Character}) do
            if container then
                for _, item in pairs(container:GetChildren()) do
                    if item.Name:lower():find("fist") then
                        found = true
                    end
                end
            end
        end
    end)
    return found
end

-- Vòng lặp tìm rương theo tầm quét tùy chỉnh
local target = nil
task.spawn(function()
    while true do
        if running then
            local nearest = nil
            local minDst = math.huge
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local p = char.HumanoidRootPart.Position
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("Model") and v.Name:lower():find("chest") then
                            local part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                            if part and not checked[v] then
                                local d = (p - part.Position).Magnitude
                                if d <= range and d < minDst then
                                    minDst = d
                                    nearest = part
                                end
                            end
                        end
                    end
                end
            end)
            target = nearest
        else
            target = nil
        end
        task.wait(0.3)
    end
end)

-- Xử lý chống rớt, bay nhặt và tự động gọi Râu Đen
RunService.Stepped:Connect(function()
    if running then
        pcall(function()
            if summonEnabled and CheckFist() then
                running = false
                target = nil
                btn.Text = "Auto Chest: TẮT"
                btn.TextColor3 = Color3.fromRGB(255, 70, 70)
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                statusLabel.Text = "Đã có Fist! Đang gọi Râu Đen..."
                
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(DarkbeardAltarPos + Vector3.new(0, 5, 0))
                end
                return
            end

            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                hum.PlatformStand = true
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                
                if target and target.Parent then
                    local m = target.Parent
                    if not m:IsA("Model") then m = target end
                    
                    local tp = target.Position + Vector3.new(0, 3, 0)
                    local dist = (root.Position - tp).Magnitude
                    
                    if dist < 5 then
                        checked[m] = true
                        target = nil
                        root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                    else
                        root.AssemblyLinearVelocity = (tp - root.Position).Unit * speed
                    end
                else
                    root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                end
            end
        end)
    end
end)
