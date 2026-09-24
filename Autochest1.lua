-- ==================== AUTO CHEST ULTRA SPEED (KHÔNG LAG, XA, CHỈ RƯƠNG THƯỜNG) ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local autoChestEnabled = false
local stopOnSpecialItem = true

-- Xóa Menu cũ nếu tồn tại
pcall(function()
    if PlayerGui:FindFirstChild("AutoChestOnlyUI") then
        PlayerGui.AutoChestOnlyUI:Destroy()
    end
end)

-- Tạo GUI giao diện chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoChestOnlyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 140)
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
Title.Text = "🎁 Auto Chest Pro"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Parent = MainFrame

-- Nút Bật/Tắt Auto Chest
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 180, 0, 35)
ToggleBtn.Position = UDim2.new(0, 10, 0, 35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Auto Chest: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.TextSize = 13
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

-- Nút Bật/Tắt Stop khi có Key/Chén Thánh
local StopToggleBtn = Instance.new("TextButton")
StopToggleBtn.Size = UDim2.new(0, 180, 0, 35)
StopToggleBtn.Position = UDim2.new(0, 10, 0, 78)
StopToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
StopToggleBtn.Font = Enum.Font.SourceSansBold
StopToggleBtn.Text = "Stop Key/Chén: BẬT"
StopToggleBtn.TextColor3 = Color3.fromRGB(60, 255, 60)
StopToggleBtn.TextSize = 12
StopToggleBtn.Parent = MainFrame
Instance.new("UICorner", StopToggleBtn).CornerRadius = UDim.new(0, 6)

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

-- HÀM TÌM RƯƠNG CỰC KỲ TỐI ƯU (DÙNG CACHE TRÁNH LAG NẶNG)
local cachedChest = nil
local lastCheck = 0

local function GetNearestChest()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local rootPos = char.HumanoidRootPart.Position

    -- Nếu rương cũ vẫn tồn tại và chưa bị nhặt, ưu tiên dùng luôn để bay cực nhanh
    if cachedChest and cachedChest.Parent then
        local dist = (rootPos - cachedChest.Position).Magnitude
        if dist > 5 then -- Nếu chưa đứng sát rương thì tiếp tục bay tới
            return cachedChest
        end
    end

    local nearestChest = nil
    local shortestDistance = math.huge

    pcall(function()
        -- Quét nhanh các phần tử chứa chest nhưng lọc sạch rương ẩn/nhiệm vụ
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
                        local distance = (rootPos - part.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestChest = part
                        end
                    end
                end
            end
        end
    end)

    cachedChest = nearestChest
    return nearestChest
end

-- Vòng lặp tốc độ cao, mượt mà tuyệt đối, không giật lag
RunService.Stepped:Connect(function()
    if autoChestEnabled then
        pcall(function()
            if stopOnSpecialItem and HasSpecialItem() then
                autoChestEnabled = false
                ToggleBtn.Text = "Auto Chest: TẮT"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
                return
            end

            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPart = char.HumanoidRootPart
                
                -- Khóa vật lý chống cà giật
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                local chest = GetNearestChest()
                if chest then
                    rootPart.CFrame = chest.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end)
    end
end)
