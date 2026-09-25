-- ==================== BLOX FRUITS - PORTAL F AUTO CHEST HUB + SEA CASTLE GATE ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local autoChestEnabled = false
local stopOnSpecialItem = true
local portalFEnabled = true
local chestSpeed = 350

-- Xóa Menu cũ nếu tồn tại
pcall(function()
    if PlayerGui:FindFirstChild("PortalChestHubUI") then
        PlayerGui.PortalChestHubUI:Destroy()
    end
end)

-- Tạo GUI Giao diện Menu Mới
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PortalChestHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 265)
MainFrame.Position = UDim2.new(0, 60, 0, 140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Viền sáng nhẹ cho Menu
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 120, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "⚡ Portal F - Hub + Sea Gate"
Title.TextColor3 = Color3.fromRGB(100, 180, 255)
Title.TextSize = 14
Title.Parent = MainFrame

-- Nút Thu Gọn / Mở Rộng Menu (-)
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

-- Nút Bật/Tắt Auto Chest
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

-- Nút Bật/Tắt Stop khi có Key/Chén Thánh
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

-- Nút Bật/Tắt F Portal
local PortalFToggleBtn = Instance.new("TextButton")
PortalFToggleBtn.Size = UDim2.new(0, 200, 0, 32)
PortalFToggleBtn.Position = UDim2.new(0, 10, 0, 112)
PortalFToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
PortalFToggleBtn.Font = Enum.Font.SourceSansBold
PortalFToggleBtn.Text = "Dùng F Portal: BẬT"
PortalFToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
PortalFToggleBtn.TextSize = 12
PortalFToggleBtn.Parent = MainFrame
Instance.new("UICorner", PortalFToggleBtn).CornerRadius = UDim.new(0, 6)

-- Ô nhập tốc độ trực tiếp trong game
local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 200, 0, 32)
SpeedBox.Position = UDim2.new(0, 10, 0, 149)
SpeedBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpeedBox.Font = Enum.Font.SourceSansBold
SpeedBox.Text = "Tốc độ: 350"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 12
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = MainFrame
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

-- Dòng chữ trạng thái nhỏ ở đáy Menu
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 188)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.Text = "Trạng thái: Đang chờ..."
StatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
StatusLabel.TextSize = 11
StatusLabel.Parent = MainFrame

-- Tính năng Ẩn/Hiện Menu (Minimize)
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MinimizeBtn.Text = "+"
        MainFrame.Size = UDim2.new(0, 220, 0, 45)
        ToggleBtn.Visible = false
        StopToggleBtn.Visible = false
        PortalFToggleBtn.Visible = false
        SpeedBox.Visible = false
        StatusLabel.Visible = false
    else
        MinimizeBtn.Text = "-"
        MainFrame.Size = UDim2.new(0, 220, 0, 265)
        ToggleBtn.Visible = true
        StopToggleBtn.Visible = true
        PortalFToggleBtn.Visible = true
        SpeedBox.Visible = true
        StatusLabel.Visible = true
    end
end)

-- Xử lý thay đổi tốc độ
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

-- Hàm kiểm tra cổng dịch chuyển Pháo đài trên biển (Sea Castle) ở Sea 3 đã mở hay chưa
local function IsSeaCastlePortalUnlocked()
    local unlocked = false
    pcall(function()
        -- Kiểm tra trong Workspace hoặc dữ liệu game xem cổng Sea Castle đã hoạt động chưa
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("portal") or obj.Name:lower():find("gate") or obj.Name:lower():find("teleport") then
                local nameLower = obj.Name:lower()
                if nameLower:find("sea") or nameLower:find("castle") or nameLower:find("mansion") then
                    -- Nếu tìm thấy đối tượng cổng và nó có thể tương tác/hoạt động
                    if obj:IsA("BasePart") and obj.Transparency < 1 then
                        unlocked = true
                    end
                end
            end
        end
        -- Kiểm tra thêm điều kiện quest/level hoặc progress đặc trưng của Sea 3 nếu có
        local dataFolder = LocalPlayer:FindFirstChild("Data")
        if dataFolder and dataFolder:FindFirstChild("Level") then
            if dataFolder.Level.Value >= 1500 then
                unlocked = true -- Mặc định từ cấp độ mở Sea 3 / Pháo đài trên biển
            end
        end
    end)
    return unlocked
end

-- Bật/Tắt Auto Chest
ToggleBtn.MouseButton1Click:Connect(function()
    autoChestEnabled = not autoChestEnabled
    if autoChestEnabled then
        ToggleBtn.Text = "Auto Chest: BẬT"
        ToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
        StatusLabel.Text = "Trạng thái: Đang săn rương..."
    else
        ToggleBtn.Text = "Auto Chest: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        StatusLabel.Text = "Trạng thái: Đã dừng."
    end
end)

-- Bật/Tắt Stop Key
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

-- Bật/Tắt F Portal
PortalFToggleBtn.MouseButton1Click:Connect(function()
    portalFEnabled = not portalFEnabled
    if portalFEnabled then
        PortalFToggleBtn.Text = "Dùng F Portal: BẬT"
        PortalFToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        PortalFToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
    else
        PortalFToggleBtn.Text = "Dùng F Portal: TẮT"
        PortalFToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        PortalFToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 35)
    end
end)

-- Khóa vận tốc ngầm chống rung lắc
RunService.Stepped:Connect(function()
    if autoChestEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPart = char.HumanoidRootPart
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end
end)

-- Quét rương toàn map
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

-- Hệ thống di chuyển kết hợp F Portal và kiểm tra cổng Sea Castle
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoChestEnabled then
            if stopOnSpecialItem and HasSpecialItem() then
                autoChestEnabled = false
                targetChest = nil
                ToggleBtn.Text = "Auto Chest: TẮT"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                StatusLabel.Text = "Đã dừng do có Key/Chén!"
            else
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPart = char.HumanoidRootPart
                    
                    if targetChest and targetChest.Parent then
                        local destCFrame = targetChest.CFrame + Vector3.new(0, 3, 0)
                        local distance = (rootPart.Position - targetChest.Position).Magnitude
                        
                        -- Kiểm tra nếu gần khu vực Sea Castle và cổng đã mở thì ưu tiên định tuyến qua cổng
                        if IsSeaCastlePortalUnlocked() and distance > 500 then
                            pcall(function()
                                -- Logic tận dụng cổng dịch chuyển Sea Castle nếu hợp lệ
                                for _, part in pairs(Workspace:GetDescendants()) do
                                    if part:IsA("BasePart") and part.Name:lower():find("portal") then
                                        local distToPortal = (rootPart.Position - part.Position).Magnitude
                                        if distToPortal < 150 then
                                            -- Đã tiếp cận cổng Sea Castle mở, cho phép đi qua
                                            rootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                                            task.wait(0.2)
                                        end
                                    end
                                end
                            end)
                        end
                        
                        -- Kích hoạt F Portal nếu được bật và khoảng cách xa
                        if portalFEnabled and distance > 150 then
                            pcall(function()
                                local backpack = LocalPlayer:FindFirstChild("Backpack")
                                local portalTool = nil
                                if backpack then
                                    for _, tool in pairs(backpack:GetChildren()) do
                                        if tool.Name:lower():find("portal") then
                                            portalTool = tool
                                            break
                                        end
                                    end
                                end
                                
                                if portalTool and not char:FindFirstChildOfClass("Tool") then
                                    portalTool.Parent = char
                                end
                                
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                task.wait(0.05)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                            end)
                        end
                        
                        local stepTime = distance / chestSpeed
                        if stepTime < 0.05 then stepTime = 0.05 end
                        
                        local tweenInfo = TweenInfo.new(stepTime, Enum.EasingStyle.Linear)
                        local tween = game:GetService("TweenService"):Create(rootPart, tweenInfo, {CFrame = destCFrame})
                        tween:Play()
                        task.wait(stepTime)
                    end
                end
            end
        end
    end
end)
