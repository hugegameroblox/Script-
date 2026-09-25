-- ==================== BLOX FRUITS - Auto Chest + Auto Summon Darkbeard v1.6 ====================
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

-- Tạo GUI Giao diện
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ChestHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 110)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0, 180, 0, 32)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
btn.TextColor3 = Color3.fromRGB(255, 70, 70)
btn.TextSize = 13
btn.Font = Enum.Font.SourceSansBold
btn.Text = "Auto Chest: TẮT"
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

local summonBtn = Instance.new("TextButton", frame)
summonBtn.Size = UDim2.new(0, 180, 0, 32)
summonBtn.Position = UDim2.new(0, 10, 0, 52)
summonBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
summonBtn.TextColor3 = Color3.fromRGB(70, 255, 70)
summonBtn.TextSize = 12
summonBtn.Font = Enum.Font.SourceSansBold
summonBtn.Text = "Auto Summon RâuĐen: BẬT"
Instance.new("UICorner", summonBtn).CornerRadius = UDim.new(0, 6)

btn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        btn.Text = "Auto Chest: BẬT"
        btn.TextColor3 = Color3.fromRGB(70, 255, 70)
        btn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
    else
        btn.Text = "Auto Chest: TẮT"
        btn.TextColor3 = Color3.fromRGB(255, 70, 70)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                char:FindFirstChildOfClass("Humanoid").PlatformStand = false
                char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
        end)
    end
end)

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

-- Vòng lặp tìm rương tối ưu tầm quét 100k
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
            -- Nếu bật tính năng summon và nhặt được Fist of Darkness
            if summonEnabled and CheckFist() then
                running = false
                target = nil
                btn.Text = "Auto Chest: TẮT"
                btn.TextColor3 = Color3.fromRGB(255, 70, 70)
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Dịch chuyển thẳng đến bệ thờ Râu Đen Sea 2
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
