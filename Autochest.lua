-- ==================== AUTO CHEST FIX (AN TOÀN CHO MOBILE) ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local autoChestEnabled = false
local stopOnSpecialItem = true

-- Xóa GUI cũ nếu có để tránh trùng lặp
pcall(function()
    if PlayerGui:FindFirstChild("AutoChestHubUI") then
        PlayerGui.AutoChestHubUI:Destroy()
    end
end)

-- Tạo giao diện Menu chính trực tiếp vào PlayerGui (Tránh lỗi CoreGui trên mobile)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoChestHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 190, 0, 140)
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
Title.Text = "Auto Chest"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Parent = MainFrame

-- Nút Bật/Tắt Auto Chest
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 170, 0, 35)
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
StopToggleBtn.Size = UDim2.new(0, 170, 0, 35)
StopToggleBtn.Position = UDim2.new(0, 10, 0, 75)
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

-- Sự kiện bấm nút Auto Chest
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

-- Sự kiện bấm nút Stop
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

-- Hàm tìm rương tối ưu
local function GetNearestChest()
    local nearestChest = nil
    local shortestDistance = math.huge
    
    pcall(function()
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj.Name:lower():find("chest") or obj.Name:lower():find("treasure") then
                local part = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if part and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestChest = part
                    end
                end
            end
        end
    end)
    
    return nearestChest
end

-- Vòng lặp chạy ngầm
RunService.RenderStepped:Connect(function()
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
                local chest = GetNearestChest()
                if chest then
                    char.HumanoidRootPart.CFrame = chest.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end)
    end
end)
