-- ==================== BLOX FRUITS - PORTAL C SYNC CAMERA & PLAYER HUB ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local autoChestEnabled = false
local stopOnSpecialItem = true
local portalCEnabled = true
local chestSpeed = 350
local lastCPortalTime = 0

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
Title.Text = "auto catch chest v1.3.3 beta"
Title.TextColor3 = Color3.fromRGB(100, 180, 255)
Title.TextSize = 13
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

-- Nút Bật/Tắt C Portal
local PortalCToggleBtn = Instance.new("TextButton")
PortalCToggleBtn.Size = UDim2.new(0, 200, 0, 32)
PortalCToggleBtn.Position = UDim2.new(0, 10, 0, 112)
PortalCToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
PortalCToggleBtn.Font = Enum.Font.SourceSansBold
PortalCToggleBtn.Text = "Dùng C Portal: BẬT"
PortalCToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
PortalCToggleBtn.TextSize = 12
PortalCToggleBtn.Parent = MainFrame
Instance.new("UICorner", PortalCToggleBtn).CornerRadius = UDim.new(0, 6)

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
        PortalCToggleBtn.Visible = false
        SpeedBox.Visible = false
        StatusLabel.Visible = false
    else
        MinimizeBtn.Text = "-"
        MainFrame.Size = UDim2.new(0, 220, 0, 265)
        ToggleBtn.Visible = true
        StopToggleBtn.Visible = true
        PortalCToggleBtn.Visible = true
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

-- Bật/Tắt C Portal
PortalCToggleBtn.MouseButton1Click:Connect(function()
    portalCEnabled = not portalCEnabled
    if portalCEnabled then
        PortalCToggleBtn.Text = "Dùng C Portal: BẬT"
        PortalCToggleBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
        PortalCToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
    else
        PortalCToggleBtn.Text = "Dùng C Portal: TẮT"
        PortalCToggleBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
        PortalCToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 35)
    end
end)

-- Ép Camera luôn bám chặt vào nhân vật và khóa vận tốc chống giật
RunService.Stepped:Connect(function()
    if autoChestEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPart = char.HumanoidRootPart
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                
                -- Khóa đứng yên vật lý chống quăng quật
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                -- Luôn giữ Camera đồng bộ theo nhân vật
                if humanoid and Camera.CameraSubject ~= humanoid then
                    Camera.CameraSubject = humanoid
                end
            end
        end)
    end
end)

-- Quét rương toàn map liên tục
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
        task.wait(0.5)
    end
end)

-- Hệ thống di chuyển trực tiếp (Mượt mà, cam và nhân vật đi chung)
task.spawn(function()
    while true do
        task.wait(0.03)
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
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    if targetChest and targetChest.Parent then
                        local destCFrame = targetChest.CFrame + Vector3.new(0, 3, 0)
                        local distance = (rootPart.Position - targetChest.Position).Magnitude
                        
                        -- Nếu ở xa > 100 studs và đủ thời gian hồi chiêu -> Dùng C Portal
                        if portalCEnabled and distance > 100 and (tick() - lastCPortalTime > 4.5) then
                            lastCPortalTime = tick()
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
                                
                                -- Hướng camera về phía rương để mở cổng
                                if Camera then
                                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetChest.Position)
                                end
                                task.wait(0.04)
                                
                                -- Nhấn C lần 1
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                                task.wait(0.03)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
                                
                                task.wait(0.2)
                                
                                -- Nhấn C lần 2
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                                task.wait(0.03)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
                            end)
                            
                            -- Chờ cổng mở và dịch chuyển qua, đồng thời ép camera theo nhân vật
                            local waitDelay = 0
                            while waitDelay < 0.9 and autoChestEnabled do
                                task.wait(0.05)
                                waitDelay = waitDelay + 0.05
                                if humanoid then
                                    Camera.CameraSubject = humanoid
                                end
                            end
                        end
                        
                        -- Dịch chuyển trực tiếp từng bước mượt mà tới rương (Không dùng Tween dài gây kẹt cam)
                        while autoChestEnabled and targetChest and targetChest.Parent do
                            local currentPos = rootPart.Position
                            local targetPos = targetChest.Position + Vector3.new(0, 3, 0)
                            local remainDist = (currentPos - targetPos).Magnitude
                            
                            if remainDist < 5 then
                                rootPart.CFrame = CFrame.new(targetPos)
                                break
                            end
                            
                            -- Tính toán bước nhảy di chuyển trực tiếp theo tốc độ cài đặt
                            local step = (targetPos - currentPos).Unit * math.min(chestSpeed * 0.03, remainDist)
                            rootPart.CFrame = CFrame.new(currentPos + step)
                            
                            -- Đảm bảo camera luôn dính theo nhân vật trong từng khung hình dịch chuyển
                            if humanoid and Camera.CameraSubject ~= humanoid then
                                Camera.CameraSubject = humanoid
                            end
                            
                            task.wait(0.03)
                        end
                    end
                end
            end
        end
    end
end)
