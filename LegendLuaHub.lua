-- ================================================
--           LegendLua Hub v1.0
--         Universal Multi-Game Script
-- ================================================

local KEY = "KEY_HERE"

-- ── Services (needed before key check for kick GUI) ───
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Workspace        = game:GetService("Workspace")
local CoreGui          = game:GetService("CoreGui")
local HttpService      = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- ── Kick GUI helper ───────────────────────────────────
local function showKickScreen(message)
    -- Destroy any existing hub GUI first
    if CoreGui:FindFirstChild("LegendLuaHub") then
        CoreGui:FindFirstChild("LegendLuaHub"):Destroy()
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = "LegendLuaKick"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = CoreGui

    -- Dim overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.35
    overlay.BorderSizePixel = 0
    overlay.Parent = sg

    -- Card
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 200)
    card.Position = UDim2.new(0.5, -210, 0.5, -100)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    card.BorderSizePixel = 0
    card.Parent = sg

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 12)
    cc.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(200, 50, 50)
    stroke.Thickness = 1.5
    stroke.Parent = card

    -- Red accent bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 4)
    bar.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    bar.BorderSizePixel = 0
    bar.Parent = card

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 12)
    bc.Parent = bar

    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Text = "✕"
    icon.Size = UDim2.new(0, 48, 0, 48)
    icon.Position = UDim2.new(0.5, -24, 0, 20)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = Color3.fromRGB(220, 60, 60)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 28
    icon.Parent = card

    -- Title
    local title = Instance.new("TextLabel")
    title.Text = "ACCESS DENIED"
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 20, 0, 72)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(235, 235, 235)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 17
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = card

    -- Message
    local msg = Instance.new("TextLabel")
    msg.Text = message
    msg.Size = UDim2.new(1, -40, 0, 50)
    msg.Position = UDim2.new(0, 20, 0, 106)
    msg.BackgroundTransparency = 1
    msg.TextColor3 = Color3.fromRGB(160, 160, 175)
    msg.Font = Enum.Font.Gotham
    msg.TextSize = 13
    msg.TextWrapped = true
    msg.TextXAlignment = Enum.TextXAlignment.Center
    msg.Parent = card

    -- Countdown label
    local countdown = Instance.new("TextLabel")
    countdown.Size = UDim2.new(1, -40, 0, 20)
    countdown.Position = UDim2.new(0, 20, 0, 162)
    countdown.BackgroundTransparency = 1
    countdown.TextColor3 = Color3.fromRGB(100, 100, 120)
    countdown.Font = Enum.Font.GothamBold
    countdown.TextSize = 11
    countdown.TextXAlignment = Enum.TextXAlignment.Center
    countdown.Parent = card

    -- Animate card in
    card.Position = UDim2.new(0.5, -210, 0.5, -60)
    card.BackgroundTransparency = 1
    TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -210, 0.5, -100),
        BackgroundTransparency = 0
    }):Play()

    -- Kick after 5 seconds
    task.spawn(function()
        for i = 5, 1, -1 do
            countdown.Text = "Disconnecting in " .. i .. "s..."
            task.wait(1)
        end
        LocalPlayer:Kick("\n[LegendLua] " .. message .. "\n\nGet a key at your LegendLua portal.")
    end)
end

-- ── Key Validation ────────────────────────────────────
local function isValidFormat(k)
    return type(k) == "string" and k:match("^LegendLua%-%w%w%w%w%-%w%w%w%w%-%w%w%w%w$") ~= nil
end

if not isValidFormat(KEY) then
    showKickScreen("No valid key provided.\nPaste your key into the script before running.")
    return
end

-- ── Server-side key + user verification ──────────────
-- The Flask portal must be running and accessible for this to work.
-- Replace the URL below with your actual server address if not running locally.
local PORTAL_URL = "http://127.0.0.1:5000"

local verifySuccess, verifyResult = pcall(function()
    return HttpService:RequestAsync({
        Url = PORTAL_URL .. "/verify",
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode({
            key = KEY,
            userId = tostring(LocalPlayer.UserId)
        })
    })
end)

if not verifySuccess then
    -- Can't reach server — fall back to local format check only
    warn("[LegendLua] Could not reach verification server. Running in offline mode.")
else
    local ok, data = pcall(function()
        return HttpService:JSONDecode(verifyResult.Body)
    end)

    if not ok or not data.success then
        local reason = (ok and data.message) or "Verification failed."
        showKickScreen(reason)
        return
    end
end

print("[LegendLua] Key accepted: " .. KEY)
print("[LegendLua] User verified: " .. LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")")

-- ── Game Detection ────────────────────────────────────
local Camera   = Workspace.CurrentCamera
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local GAMES = {
    BLOX_FRUITS    = {2753915549, "Blox Fruits"},
    ARSENAL        = {286090429,  "Arsenal"},
    ADOPT_ME       = {920587237,  "Adopt Me!"},
    MURDER_MYSTERY = {142823291,  "Murder Mystery 2"},
}

local currentGame = "UNIVERSAL"
for id, data in pairs(GAMES) do
    if game.PlaceId == data[1] then
        currentGame = id
        break
    end
end

print("[LegendLua] Game detected: " .. (GAMES[currentGame] and GAMES[currentGame][2] or GameName))

-- ── State ─────────────────────────────────────────────
local State = {
    flyEnabled      = false,
    flySpeed        = 50,
    noclipEnabled   = false,
    espEnabled      = false,
    espShowNames    = true,
    espShowBoxes    = true,
    espShowDistance = false,
    speedEnabled    = false,
    speedValue      = 32,
    jumpEnabled     = false,
    jumpValue       = 50,
    infiniteJump    = false,
    autoFarm        = false,
    fruitSnipe      = false,
    silentAim       = false,
    fastShoot       = false,
    autoCollect     = false,
    petESP          = false,
    coinFarm        = false,
    roleESP         = false,
}

-- ── GUI Setup ─────────────────────────────────────────
if CoreGui:FindFirstChild("LegendLuaHub") then
    CoreGui:FindFirstChild("LegendLuaHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegendLuaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 520)
Main.Position = UDim2.new(0.5, -240, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(55, 55, 70)
MainStroke.Thickness = 1
MainStroke.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 48)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 10)
TopFix.Position = UDim2.new(0, 0, 1, -10)
TopFix.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TopFix.BorderSizePixel = 0
TopFix.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "LegendLua  |  " .. (GAMES[currentGame] and GAMES[currentGame][2] or GameName)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local KeyHint = Instance.new("TextLabel")
KeyHint.Text = "Press  RightShift  to toggle"
KeyHint.Size = UDim2.new(0, 200, 0, 18)
KeyHint.Position = UDim2.new(0.5, -100, 1, 6)
KeyHint.BackgroundTransparency = 1
KeyHint.TextColor3 = Color3.fromRGB(90, 90, 110)
KeyHint.Font = Enum.Font.Gotham
KeyHint.TextSize = 11
KeyHint.Parent = Main

UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 34)
TabBar.Position = UDim2.new(0, 10, 0, 56)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = TabBar

local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -20, 1, -110)
ContentArea.Position = UDim2.new(0, 10, 0, 98)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 3
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentArea.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ContentArea

-- ── UI Helpers ────────────────────────────────────────
local activeTab = nil
local tabs = {}

local function makeTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 0, 1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = "  " .. name .. "  "
    btn.TextColor3 = Color3.fromRGB(140, 140, 160)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = TabBar

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 6)
    bc.Parent = btn

    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.BackgroundTransparency = 1
    section.Visible = false
    section.Parent = ContentArea

    local sl = Instance.new("UIListLayout")
    sl.Padding = UDim.new(0, 8)
    sl.Parent = section

    tabs[name] = {btn = btn, section = section}

    btn.MouseButton1Click:Connect(function()
        for n, t in pairs(tabs) do
            t.section.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
            t.btn.TextColor3 = Color3.fromRGB(140, 140, 160)
        end
        section.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextColor3 = Color3.fromRGB(18, 18, 22)
        activeTab = name
    end)

    return section
end

local function makeToggle(parent, labelText, stateKey, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    row.BorderSizePixel = 0
    row.Parent = parent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 8)
    rc.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Text = labelText
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(210, 210, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.Parent = row

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 36, 0, 20)
    toggleBg.Position = UDim2.new(1, -50, 0.5, -10)
    toggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = row

    local tbc = Instance.new("UICorner")
    tbc.CornerRadius = UDim.new(1, 0)
    tbc.Parent = toggleBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(160, 160, 175)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local function refresh()
        local on = State[stateKey]
        TweenService:Create(toggleBg, TweenInfo.new(0.15), {
            BackgroundColor3 = on and Color3.fromRGB(100, 200, 120) or Color3.fromRGB(50, 50, 62)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = on and UDim2.new(0, 19, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
            BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175)
        }):Play()
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = row

    btn.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        refresh()
        if callback then callback(State[stateKey]) end
    end)

    refresh()
    return row
end

local function makeSlider(parent, labelText, stateKey, minVal, maxVal, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 54)
    row.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    row.BorderSizePixel = 0
    row.Parent = parent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 8)
    rc.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 0, 24)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(210, 210, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 50, 0, 24)
    valLbl.Position = UDim2.new(1, -60, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.TextColor3 = Color3.fromRGB(120, 200, 140)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 13
    valLbl.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -28, 0, 4)
    track.Position = UDim2.new(0, 14, 0, 36)
    track.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    track.BorderSizePixel = 0
    track.Parent = row

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 200, 120)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0)
    fc.Parent = fill

    local function updateSlider(val)
        val = math.clamp(math.floor(val), minVal, maxVal)
        State[stateKey] = val
        local pct = (val - minVal) / (maxVal - minVal)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        lbl.Text = labelText
        valLbl.Text = tostring(val)
        if callback then callback(val) end
    end

    updateSlider(State[stateKey])

    local dragging = false
    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = track.AbsolutePosition
            local size = track.AbsoluteSize
            local pct = math.clamp((inp.Position.X - abs.X) / size.X, 0, 1)
            updateSlider(minVal + (maxVal - minVal) * pct)
        end
    end)

    return row
end

local function makeSectionHeader(parent, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(90, 90, 110)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.Parent = parent
    return lbl
end

-- ── Build Tabs ────────────────────────────────────────
local uniSection = makeTab("Universal")

makeSectionHeader(uniSection, "Movement")
makeToggle(uniSection, "Fly", "flyEnabled", function(on) end)
makeSlider(uniSection, "Fly Speed", "flySpeed", 10, 200)
makeToggle(uniSection, "Noclip", "noclipEnabled")
makeToggle(uniSection, "Speed Boost", "speedEnabled", function(on)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = on and State.speedValue or 16 end
    end
end)
makeSlider(uniSection, "Walk Speed", "speedValue", 16, 300, function(v)
    if State.speedEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end
end)
makeToggle(uniSection, "Jump Boost", "jumpEnabled", function(on)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = on and State.jumpValue or 50 end
    end
end)
makeSlider(uniSection, "Jump Power", "jumpValue", 50, 300, function(v)
    if State.jumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = v end
        end
    end
end)
makeToggle(uniSection, "Infinite Jump", "infiniteJump")

makeSectionHeader(uniSection, "Visuals")
makeToggle(uniSection, "ESP", "espEnabled")
makeToggle(uniSection, "ESP — Show Names", "espShowNames")
makeToggle(uniSection, "ESP — Show Boxes", "espShowBoxes")
makeToggle(uniSection, "ESP — Show Distance", "espShowDistance")

if currentGame == "BLOX_FRUITS" then
    local bf = makeTab("Blox Fruits")
    makeSectionHeader(bf, "Farming")
    makeToggle(bf, "Auto Farm", "autoFarm")
    makeSectionHeader(bf, "Fruits")
    makeToggle(bf, "Fruit Sniper", "fruitSnipe")

elseif currentGame == "ARSENAL" then
    local ar = makeTab("Arsenal")
    makeSectionHeader(ar, "Combat")
    makeToggle(ar, "Silent Aim", "silentAim")
    makeToggle(ar, "Fast Shoot", "fastShoot")

elseif currentGame == "ADOPT_ME" then
    local am = makeTab("Adopt Me")
    makeSectionHeader(am, "Money")
    makeToggle(am, "Auto Collect Bucks", "autoCollect")
    makeSectionHeader(am, "Visuals")
    makeToggle(am, "Pet ESP", "petESP")

elseif currentGame == "MURDER_MYSTERY" then
    local mm = makeTab("MM2")
    makeSectionHeader(mm, "Farming")
    makeToggle(mm, "Coin Farm", "coinFarm")
    makeSectionHeader(mm, "Visuals")
    makeToggle(mm, "Role ESP (Sheriff/Murderer)", "roleESP")
end

-- Activate first tab
do
    local first = true
    for name, t in pairs(tabs) do
        if first then
            t.section.Visible = true
            t.btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            t.btn.TextColor3 = Color3.fromRGB(18, 18, 22)
            first = false
        end
    end
end

-- ── Fly Logic ─────────────────────────────────────────
local flyBodyVel, flyBodyGyro

local function enableFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    flyBodyVel = Instance.new("BodyVelocity")
    flyBodyVel.Velocity = Vector3.zero
    flyBodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBodyVel.Parent = root
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBodyGyro.D = 100
    flyBodyGyro.Parent = root
end

local function disableFly()
    if flyBodyVel then flyBodyVel:Destroy() flyBodyVel = nil end
    if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
end

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")

    if State.flyEnabled then
        if not flyBodyVel or not flyBodyVel.Parent then enableFly() end
        if flyBodyVel and flyBodyGyro then
            local cf = Camera.CFrame
            local vel = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel = vel - Vector3.new(0,1,0) end
            flyBodyVel.Velocity = vel * State.flySpeed
            flyBodyGyro.CFrame = cf
        end
    else
        disableFly()
    end

    if State.noclipEnabled then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.infiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

-- ── ESP Logic ─────────────────────────────────────────
local espObjects = {}

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    espObjects = {}
end

local function updateESP()
    clearESP()
    if not State.espEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum  = plr.Character:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                if State.espShowNames then
                    local bb = Instance.new("BillboardGui")
                    bb.Size = UDim2.new(0, 100, 0, 30)
                    bb.StudsOffset = Vector3.new(0, 3, 0)
                    bb.AlwaysOnTop = true
                    bb.Adornee = root
                    bb.Parent = root
                    local nl = Instance.new("TextLabel")
                    nl.Size = UDim2.new(1, 0, 1, 0)
                    nl.BackgroundTransparency = 1
                    nl.Text = plr.Name .. (State.espShowDistance and
                        ("\n" .. math.floor((LocalPlayer.Character and
                        LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                        (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 0) .. "m") or "")
                    nl.TextColor3 = Color3.fromRGB(255, 80, 80)
                    nl.Font = Enum.Font.GothamBold
                    nl.TextSize = 13
                    nl.TextStrokeTransparency = 0.4
                    nl.Parent = bb
                    table.insert(espObjects, bb)
                end
                if State.espShowBoxes then
                    local highlight = Instance.new("SelectionBox")
                    highlight.Adornee = plr.Character
                    highlight.Color3 = Color3.fromRGB(255, 60, 60)
                    highlight.LineThickness = 0.05
                    highlight.SurfaceTransparency = 0.85
                    highlight.SurfaceColor3 = Color3.fromRGB(255, 60, 60)
                    highlight.Parent = Workspace
                    table.insert(espObjects, highlight)
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(updateESP)

-- ── MM2 Role ESP ──────────────────────────────────────
RunService.Heartbeat:Connect(function()
    if currentGame ~= "MURDER_MYSTERY" or not State.roleESP then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root and not root:FindFirstChild("RoleESP_LL") then
                local roleName = "?"
                local ok, role = pcall(function()
                    return plr.Character:FindFirstChild("Role") and plr.Character.Role.Value
                end)
                if ok and role then roleName = role end
                local bb = Instance.new("BillboardGui")
                bb.Name = "RoleESP_LL"
                bb.Size = UDim2.new(0, 80, 0, 24)
                bb.StudsOffset = Vector3.new(0, 5, 0)
                bb.AlwaysOnTop = true
                bb.Adornee = root
                bb.Parent = root
                local rl = Instance.new("TextLabel")
                rl.Size = UDim2.new(1, 0, 1, 0)
                rl.BackgroundTransparency = 1
                rl.Text = "[" .. roleName .. "]"
                rl.TextColor3 = roleName == "Murderer" and Color3.fromRGB(255,50,50) or Color3.fromRGB(80,180,255)
                rl.Font = Enum.Font.GothamBold
                rl.TextSize = 12
                rl.TextStrokeTransparency = 0.3
                rl.Parent = bb
            end
        end
    end
end)

print("[LegendLua] Hub loaded successfully. Press RightShift to toggle UI.")
