-- ==========================================
-- Script: Eilia Aim Bot + Auto Fire (Part 1)
-- Developer: Eilia (TG @Saharrmohamed2005)
-- ==========================================
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Settings = {
    Enabled = false,
    AutoFire = true,
    FireDelay = 0.3,
    Speed = 100,
    Condition = "Always",
    TargetPart = "Head", 
    MenuOpen = false,
    LockOn = true
}

local MainGui
local holdingAim = false
local lastFireTime = 0

local createMenu = function()
    if Settings.MenuOpen then return end
    Settings.MenuOpen = true

    local MenuFrame = Instance.new("Frame")
    MenuFrame.Size = UDim2.new(0, 600, 0, 320)
    MenuFrame.Position = UDim2.new(0.5, -300, 0.5, -160)
    MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 25)
    MenuFrame.BorderSizePixel = 2
    MenuFrame.BorderColor3 = Color3.fromRGB(150, 0, 255)
    MenuFrame.ZIndex = 50
    MenuFrame.Parent = MainGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
    title.Text = "اعدادات الإيم بوت + اوتو فاير"
    title.TextColor3 = Color3.fromRGB(150, 0, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.ZIndex = 51
    title.Parent = MenuFrame

    local btnX = Instance.new("TextButton")
    btnX.Size = UDim2.new(0, 40, 0, 40)
    btnX.Position = UDim2.new(1, -40, 0, 0)
    btnX.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    btnX.Text = "X"
    btnX.TextColor3 = Color3.new(1, 1, 1)
    btnX.Font = Enum.Font.SourceSansBold
    btnX.TextSize = 18
    btnX.ZIndex = 52
    btnX.Parent = MenuFrame

    local btnMin = Instance.new("TextButton")
    btnMin.Size = UDim2.new(0, 40, 0, 40)
    btnMin.Position = UDim2.new(1, -80, 0, 0)
    btnMin.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    btnMin.Text = "-"
    btnMin.TextColor3 = Color3.new(1, 1, 1)
    btnMin.Font = Enum.Font.SourceSansBold
    btnMin.TextSize = 24
    btnMin.ZIndex = 52
    btnMin.Parent = MenuFrame

    local lblToggle = Instance.new("TextLabel")
    lblToggle.Size = UDim2.new(0, 150, 0, 30)
    lblToggle.Position = UDim2.new(0, 20, 0, 60)
    lblToggle.BackgroundTransparency = 1
    lblToggle.Text = "تفعيل الايم بوت:"
    lblToggle.TextColor3 = Color3.new(1, 1, 1)
    lblToggle.Font = Enum.Font.SourceSansBold
    lblToggle.TextSize = 16
    lblToggle.TextXAlignment = Enum.TextXAlignment.Left
    lblToggle.ZIndex = 51
    lblToggle.Parent = MenuFrame

    local btnToggle = Instance.new("TextButton")
    btnToggle.Size = UDim2.new(0, 80, 0, 30)
    btnToggle.Position = UDim2.new(0, 180, 0, 60)
    btnToggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    btnToggle.Text = "OFF"
    btnToggle.TextColor3 = Color3.new(1, 1, 1)
    btnToggle.Font = Enum.Font.SourceSansBold
    btnToggle.TextSize = 16
    btnToggle.ZIndex = 51
    btnToggle.Parent = MenuFrame

    local lblAuto = Instance.new("TextLabel")
    lblAuto.Size = UDim2.new(0, 150, 0, 30)
    lblAuto.Position = UDim2.new(0, 300, 0, 60)
    lblAuto.BackgroundTransparency = 1
    lblAuto.Text = "أوتو فاير (تلقائي):"
    lblAuto.TextColor3 = Color3.new(1, 1, 1)
    lblAuto.Font = Enum.Font.SourceSansBold
    lblAuto.TextSize = 16
    lblAuto.TextXAlignment = Enum.TextXAlignment.Left
    lblAuto.ZIndex = 51
    lblAuto.Parent = MenuFrame

    local btnAuto = Instance.new("TextButton")
    btnAuto.Size = UDim2.new(0, 80, 0, 30)
    btnAuto.Position = UDim2.new(0, 460, 0, 60)
    btnAuto.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnAuto.Text = "ON"
    btnAuto.TextColor3 = Color3.new(1, 1, 1)
    btnAuto.Font = Enum.Font.SourceSansBold
    btnAuto.TextSize = 16
    btnAuto.ZIndex = 51
    btnAuto.Parent = MenuFrame

    local lblLock = Instance.new("TextLabel")
    lblLock.Size = UDim2.new(0, 150, 0, 30)
    lblLock.Position = UDim2.new(0, 20, 0, 110)
    lblLock.BackgroundTransparency = 1
    lblLock.Text = "لصق مطلق:"
    lblLock.TextColor3 = Color3.new(1, 1, 1)
    lblLock.Font = Enum.Font.SourceSansBold
    lblLock.TextSize = 16
    lblLock.TextXAlignment = Enum.TextXAlignment.Left
    lblLock.ZIndex = 51
    lblLock.Parent = MenuFrame

    local btnLock = Instance.new("TextButton")
    btnLock.Size = UDim2.new(0, 80, 0, 30)
    btnLock.Position = UDim2.new(0, 180, 0, 110)
    btnLock.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnLock.Text = "ON"
    btnLock.TextColor3 = Color3.new(1, 1, 1)
    btnLock.Font = Enum.Font.SourceSansBold
    btnLock.TextSize = 16
    btnLock.ZIndex = 51
    btnLock.Parent = MenuFrame

    local lblSpeed = Instance.new("TextLabel")
    lblSpeed.Size = UDim2.new(0, 150, 0, 30)
    lblSpeed.Position = UDim2.new(0, 20, 0, 160)
    lblSpeed.BackgroundTransparency = 1
    lblSpeed.Text = "سرعة (إذا اللصق مطفي):"
    lblSpeed.TextColor3 = Color3.new(1, 1, 1)
    lblSpeed.Font = Enum.Font.SourceSansBold
    lblSpeed.TextSize = 14
    lblSpeed.TextXAlignment = Enum.TextXAlignment.Left
    lblSpeed.ZIndex = 51
    lblSpeed.Parent = MenuFrame

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 200, 0, 10)
    sliderBg.Position = UDim2.new(0, 180, 0, 170)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 51
    sliderBg.Parent = MenuFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(1, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 52
    sliderFill.Parent = sliderBg

    local sliderKnob = Instance.new("TextButton")
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new(1, -8, 0.5, -8)
    sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    sliderKnob.Text = ""
    sliderKnob.ZIndex = 53
    sliderKnob.Parent = sliderBg

    local speedVal = Instance.new("TextLabel")
    speedVal.Size = UDim2.new(0, 50, 0, 30)
    speedVal.Position = UDim2.new(0, 390, 0, 160)
    speedVal.BackgroundTransparency = 1
    speedVal.Text = "100"
    speedVal.TextColor3 = Color3.fromRGB(150, 0, 255)
    speedVal.Font = Enum.Font.SourceSansBold
    speedVal.TextSize = 16
    speedVal.ZIndex = 51
    speedVal.Parent = MenuFrame

    local lblCond = Instance.new("TextLabel")
    lblCond.Size = UDim2.new(0, 150, 0, 30)
    lblCond.Position = UDim2.new(0, 20, 0, 210)
    lblCond.BackgroundTransparency = 1
    lblCond.Text = "شرط التفعيل:"
    lblCond.TextColor3 = Color3.new(1, 1, 1)
    lblCond.Font = Enum.Font.SourceSansBold
    lblCond.TextSize = 16
    lblCond.TextXAlignment = Enum.TextXAlignment.Left
    lblCond.ZIndex = 51
    lblCond.Parent = MenuFrame

    local btnOnFire = Instance.new("TextButton")
    btnOnFire.Size = UDim2.new(0, 110, 0, 30)
    btnOnFire.Position = UDim2.new(0, 160, 0, 210)
    btnOnFire.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    btnOnFire.Text = "عند الاطلاق"
    btnOnFire.TextColor3 = Color3.new(1, 1, 1)
    btnOnFire.Font = Enum.Font.SourceSansBold
    btnOnFire.TextSize = 13
    btnOnFire.ZIndex = 51
    btnOnFire.Parent = MenuFrame

    local btnOnAim = Instance.new("TextButton")
    btnOnAim.Size = UDim2.new(0, 110, 0, 30)
    btnOnAim.Position = UDim2.new(0, 280, 0, 210)
    btnOnAim.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    btnOnAim.Text = "عند فتح المنظار"
    btnOnAim.TextColor3 = Color3.new(1, 1, 1)
    btnOnAim.Font = Enum.Font.SourceSansBold
    btnOnAim.TextSize = 13
    btnOnAim.ZIndex = 51
    btnOnAim.Parent = MenuFrame

    local btnAlways = Instance.new("TextButton")
    btnAlways.Size = UDim2.new(0, 110, 0, 30)
    btnAlways.Position = UDim2.new(0, 400, 0, 210)
    btnAlways.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    btnAlways.Text = "دائماً"
    btnAlways.TextColor3 = Color3.new(1, 1, 1)
    btnAlways.Font = Enum.Font.SourceSansBold
    btnAlways.TextSize = 13
    btnAlways.ZIndex = 51
    btnAlways.Parent = MenuFrame

    local lblPart = Instance.new("TextLabel")
    lblPart.Size = UDim2.new(0, 150, 0, 30)
    lblPart.Position = UDim2.new(0, 20, 0, 260)
    lblPart.BackgroundTransparency = 1
    lblPart.Text = "مكان الايم بوت:"
    lblPart.TextColor3 = Color3.new(1, 1, 1)
    lblPart.Font = Enum.Font.SourceSansBold
    lblPart.TextSize = 16
    lblPart.TextXAlignment = Enum.TextXAlignment.Left
    lblPart.ZIndex = 51
    lblPart.Parent = MenuFrame

    local btnHead = Instance.new("TextButton")
    btnHead.Size = UDim2.new(0, 70, 0, 30)
    btnHead.Position = UDim2.new(0, 180, 0, 260)
    btnHead.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    btnHead.Text = "الرأس"
    btnHead.TextColor3 = Color3.new(1, 1, 1)
    btnHead.Font = Enum.Font.SourceSansBold
    btnHead.TextSize = 14
    btnHead.ZIndex = 51
    btnHead.Parent = MenuFrame

    local btnTorso = Instance.new("TextButton")
    btnTorso.Size = UDim2.new(0, 70, 0, 30)
    btnTorso.Position = UDim2.new(0, 260, 0, 260)
    btnTorso.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    btnTorso.Text = "البطن"
    btnTorso.TextColor3 = Color3.new(1, 1, 1)
    btnTorso.Font = Enum.Font.SourceSansBold
    btnTorso.TextSize = 14
    btnTorso.ZIndex = 51
    btnTorso.Parent = MenuFrame

    btnToggle.MouseButton1Click:Connect(function()
        Settings.Enabled = not Settings.Enabled
        if Settings.Enabled then
            btnToggle.Text = "ON"
            btnToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            btnToggle.Text = "OFF"
            btnToggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        end
    end)

    btnAuto.MouseButton1Click:Connect(function()
        Settings.AutoFire = not Settings.AutoFire
        if Settings.AutoFire then
            btnAuto.Text = "ON"
            btnAuto.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            btnAuto.Text = "OFF"
            btnAuto.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        end
    end)

    btnLock.MouseButton1Click:Connect(function()
        Settings.LockOn = not Settings.LockOn
        if Settings.LockOn then
            btnLock.Text = "ON"
            btnLock.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            btnLock.Text = "OFF"
            btnLock.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        end
    end)

    local function updateCondUI(activeBtn)
        btnOnFire.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
        btnOnAim.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
        btnAlways.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
        activeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    end

    btnOnFire.MouseButton1Click:Connect(function()
        Settings.Condition = "OnFire"
        updateCondUI(btnOnFire)
    end)
    btnOnAim.MouseButton1Click:Connect(function()
        Settings.Condition = "OnAim"
        updateCondUI(btnOnAim)
    end)
    btnAlways.MouseButton1Click:Connect(function()
        Settings.Condition = "Always"
        updateCondUI(btnAlways)
    end)

    btnHead.MouseButton1Click:Connect(function()
        Settings.TargetPart = "Head"
        btnHead.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
        btnTorso.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    end)

    btnTorso.MouseButton1Click:Connect(function()
        Settings.TargetPart = "Torso"
        btnTorso.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
        btnHead.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    end)

    local dragging = false
    sliderKnob.MouseButton1Down:Connect(function() dragging = true end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mouseX = input.Position.X
            local relX = math.clamp(mouseX - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
            local percent = relX / sliderBg.AbsoluteSize.X
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            sliderKnob.Position = UDim2.new(percent, -8, 0.5, -8)
            Settings.Speed = math.floor(50 + (percent * 50))
            speedVal.Text = tostring(Settings.Speed)
        end
    end)

    local minimized = false
    btnMin.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            for _, child in ipairs(MenuFrame:GetChildren()) do
                if child ~= title and child ~= btnX and child ~= btnMin then
                    child.Visible = false
                end
            end
            MenuFrame.Size = UDim2.new(0, 600, 0, 40)
        else
            for _, child in ipairs(MenuFrame:GetChildren()) do
                child.Visible = true
            end
            MenuFrame.Size = UDim2.new(0, 600, 0, 320)
        end
    end)

    btnX.MouseButton1Click:Connect(function()
        Settings.Enabled = false
        Settings.MenuOpen = false
        if MainGui then MainGui:Destroy() end
    end)
end

local function startScript()
    MainGui = Instance.new("ScreenGui")
    MainGui.Name = "EiliaAimBot"
    MainGui.ResetOnSpawn = false
    MainGui.IgnoreGuiInset = true
    MainGui.Parent = playerGui

    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 350, 0, 150)
    confirmFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
    confirmFrame.BorderSizePixel = 2
    confirmFrame.BorderColor3 = Color3.fromRGB(150, 0, 255)
    confirmFrame.ZIndex = 10
    confirmFrame.Parent = MainGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = "هل متأكد من تفعيل سكربت ايم بوت؟"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.TextWrapped = true
    title.ZIndex = 11
    title.Parent = confirmFrame

    local btnYes = Instance.new("TextButton")
    btnYes.Size = UDim2.new(0.4, 0, 0, 35)
    btnYes.Position = UDim2.new(0.05, 0, 0, 90)
    btnYes.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    btnYes.Text = "نعم"
    btnYes.TextColor3 = Color3.new(1, 1, 1)
    btnYes.Font = Enum.Font.SourceSansBold
    btnYes.ZIndex = 11
    btnYes.Parent = confirmFrame

    local btnNo = Instance.new("TextButton")
    btnNo.Size = UDim2.new(0.4, 0, 0, 35)
    btnNo.Position = UDim2.new(0.55, 0, 0, 90)
    btnNo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btnNo.Text = "لا"
    btnNo.TextColor3 = Color3.new(1, 1, 1)
    btnNo.Font = Enum.Font.SourceSansBold
    btnNo.ZIndex = 11
    btnNo.Parent = confirmFrame

    btnNo.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)

    btnYes.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()

        local creditsBtn = Instance.new("TextButton")
        creditsBtn.Size = UDim2.new(0, 300, 0, 30)
        creditsBtn.Position = UDim2.new(0, 10, 1, -40)
        creditsBtn.BackgroundTransparency = 1
        creditsBtn.Text = "Aim Bot by Eilia | TG @Saharrmohamed2005"
        creditsBtn.TextColor3 = Color3.fromRGB(150, 0, 255)
        creditsBtn.Font = Enum.Font.SourceSansBold
        creditsBtn.TextSize = 14
        creditsBtn.TextXAlignment = Enum.TextXAlignment.Left
        creditsBtn.ZIndex = 20
        creditsBtn.Active = true
        creditsBtn.Selectable = true
        creditsBtn.Parent = MainGui

        local msgFrame = Instance.new("Frame")
        msgFrame.Size = UDim2.new(0, 350, 0, 120)
        msgFrame.Position = UDim2.new(0.5, -175, 0.5, -60)
        msgFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
        msgFrame.BorderSizePixel = 2
        msgFrame.BorderColor3 = Color3.fromRGB(150, 0, 255)
        msgFrame.ZIndex = 15
        msgFrame.Parent = MainGui

        local msgText = Instance.new("TextLabel")
        msgText.Size = UDim2.new(1, 0, 0, 60)
        msgText.BackgroundTransparency = 1
        msgText.Text = "اضغط على حقوق المطور لفتح منيو اعدادات الإيم بوت"
        msgText.TextColor3 = Color3.new(1, 1, 1)
        msgText.Font = Enum.Font.SourceSansBold
        msgText.TextSize = 16
        msgText.TextWrapped = true
        msgText.ZIndex = 16
        msgText.Parent = msgFrame

        local btnClose = Instance.new("TextButton")
        btnClose.Size = UDim2.new(0.4, 0, 0, 35)
        btnClose.Position = UDim2.new(0.3, 0, 0, 75)
        btnClose.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
        btnClose.Text = "اغلاق"
        btnClose.TextColor3 = Color3.new(1, 1, 1)
        btnClose.Font = Enum.Font.SourceSansBold
        btnClose.ZIndex = 16
        btnClose.Parent = msgFrame

        btnClose.MouseButton1Click:Connect(function()
            msgFrame:Destroy()
        end)

        creditsBtn.MouseButton1Click:Connect(function()
            createMenu()
        end)
    end)
end
local function getClosestToScreen()
    local closest = nil
    local bestScreenDist = math.huge
    local centerScreen = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    for _, other in ipairs(game.Players:GetPlayers()) do
        if other ~= player and other.Character then
            local char = other.Character
            local part = char:FindFirstChild(Settings.TargetPart == "Head" and "Head" or "HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if part and hum and hum.Health > 0 then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    rayParams.FilterDescendantsInstances = {player.Character, other.Character}
                    local origin = camera.CFrame.Position
                    local direction = (part.Position - origin)
                    local rayHit = workspace:Raycast(origin, direction, rayParams)
                    
                    if not rayHit then
                        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
                        if screenDist < bestScreenDist then
                            bestScreenDist = screenDist
                            closest = {part = part, char = char}
                        end
                    end
                end
            end
        end
    end
    return closest
end

local function snapToTarget(targetPart)
    if targetPart then
        if Settings.LockOn then
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
        else
            local lerpSpeed = Settings.Speed / 100 * 0.3
            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, targetPart.Position), lerpSpeed)
        end
    end
end

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.M and not Settings.MenuOpen then
        createMenu()
    end

    if not Settings.Enabled then return end
    
    if Settings.Condition == "OnFire" and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local target = getClosestToScreen()
        if target then
            snapToTarget(target.part)
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
    
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingAim = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingAim = false
    end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then return end
    
    if (Settings.Condition == "Always") or (Settings.Condition == "OnAim" and holdingAim) then
        local target = getClosestToScreen()
        if target then
            snapToTarget(target.part)
            
            if Settings.AutoFire then
                local now = tick()
                if now - lastFireTime >= Settings.FireDelay then
                    local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                    if tool then 
                        tool:Activate()
                        lastFireTime = now
                    end
                end
            end
        end
    end
end)

startScript()
