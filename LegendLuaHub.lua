-- IIO1IlOOll10OI10lI
local _O08233c = 27850
local _O059b9a719 = math.random
;(function()





local KEY = "KEY_HERE"


local Players          = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(29+51),(31+77),(17+80),(22+99),(11+90),(6+108),(3+112)}))
local RunService       = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+42),(49+68),(18+92),(32+51),(40+61),(49+65),(30+88),(36+69),(44+55),(45+56)}))
local UserInputService = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(29+56),(48+67),(20+81),(31+83),(26+47),(10+100),(7+105),(15+102),(2+114),(17+66),(6+95),(16+98),(49+69),(27+78),(7+92),(4+97)}))
local TweenService     = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(18+66),(46+73),(39+62),(39+62),(23+87),(32+51),(37+64),(30+84),(6+112),(3+102),(34+65),(3+98)}))
local Workspace        = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(41+46),(9+102),(17+97),(6+101),(39+76),(41+71),(15+82),(35+64),(36+65)}))
local CoreGui          = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(31+36),(28+83),(43+71),(22+79),(30+41),(13+104),(32+73)}))
local HttpService      = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(31+41),(35+81),(10+106),(11+101),(4+79),(11+90),(27+87),(32+86),(1+104),(1+98),(8+93)}))

local LocalPlayer = Players.LocalPlayer


local function showKickScreen(message)
    
    if CoreGui:FindFirstChild("LegendLuaHub") then
        CoreGui:FindFirstChild("LegendLuaHub"):Destroy()
    end

    local _ll6c7c255 = ((12+5)*(8+42))
    local O1Il100O0lO = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(5+78),(50+49),(10+104),(38+63),(48+53),(4+106),(24+47),(8+109),(17+88)}))
    O1Il100O0lO.Name = "LegendLuaKick"
    O1Il100O0lO.ResetOnSpawn = false
    O1Il100O0lO.IgnoreGuiInset = true
    O1Il100O0lO.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    O1Il100O0lO.Parent = CoreGui

    
    local O010OOIO01Il = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(2+68),(10+104),(31+66),(43+66),(22+79)}))
    O010OOIO01Il.Size = UDim2.new(1, 0, 1, 0)
    O010OOIO01Il.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    O010OOIO01Il.BackgroundTransparency = 0.35
    O010OOIO01Il.BorderSizePixel = 0
    O010OOIO01Il.Parent = O1Il100O0lO

    
    local Ol0IlO100l10 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(12+58),(7+107),(37+60),(27+82),(6+95)}))
    Ol0IlO100l10.Size = UDim2.new(0, (26+394), 0, (47+153))
    Ol0IlO100l10.Position = UDim2.new(0.5, -(4+206), 0.5, -(10+90))
    Ol0IlO100l10.BackgroundColor3 = Color3.fromRGB((13+5), (15+3), (2+20))
    Ol0IlO100l10.BorderSizePixel = 0
    Ol0IlO100l10.Parent = O1Il100O0lO

    local I1lOI1I0I11O = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(2+83),(18+55),(47+20),(11+100),(7+107),(3+107),(26+75),(20+94)}))
    I1lOI1I0I11O.CornerRadius = UDim.new(0, (4+8))
    I1lOI1I0I11O.Parent = Ol0IlO100l10

    local IO1II01lI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(42+43),(30+43),(12+71),(41+75),(27+87),(7+104),(26+81),(3+98)}))
    IO1II01lI.Color = Color3.fromRGB((2+198), (36+14), (18+32))
    IO1II01lI.Thickness = 1.5
    IO1II01lI.Parent = Ol0IlO100l10

    
    local OO11O100OOO1 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(4+66),(11+103),(13+84),(2+107),(49+52)}))
    local _O09c5491b9 = math.floor(math.random()*(49+2154))
    OO11O100OOO1.Size = UDim2.new(1, 0, 0, (4+0))
    OO11O100OOO1.BackgroundColor3 = Color3.fromRGB((39+181), (1+49), (33+17))
    OO11O100OOO1.BorderSizePixel = 0
    OO11O100OOO1.Parent = Ol0IlO100l10

    local l1I111OI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(49+36),(10+63),(12+55),(7+104),(40+74),(38+72),(30+71),(49+65)}))
    l1I111OI.CornerRadius = UDim.new(0, (12+0))
    l1I111OI.Parent = OO11O100OOO1

    
    local I111Ill10 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(35+49),(3+98),(24+96),(24+92),(26+50),(16+81),(38+60),(39+62),(31+77)}))
    local _0x2c20f = tostring((18+9508))
    I111Ill10.Text = "✕"
    I111Ill10.Size = UDim2.new(0, (7+41), 0, (40+8))
    I111Ill10.Position = UDim2.new(0.5, -(18+6), 0, (11+9))
    I111Ill10.BackgroundTransparency = 1
    I111Ill10.TextColor3 = Color3.fromRGB((16+204), (29+31), (19+41))
    I111Ill10.Font = Enum.Font.GothamBold
    I111Ill10.TextSize = (6+22)
    I111Ill10.Parent = Ol0IlO100l10

    
    local lIOOlOOOI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(13+71),(22+79),(22+98),(29+87),(22+54),(33+64),(11+87),(25+76),(6+102)}))
    lIOOlOOOI.Text = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(36+29),(44+23),(2+65),(8+61),(45+38),(17+66),(6+26),(29+39),(45+24),(21+57),(14+59),(36+33),(16+52)})
    lIOOlOOOI.Size = UDim2.new(1, -(8+32), 0, (18+10))
    lIOOlOOOI.Position = UDim2.new(0, (18+2), 0, (28+44))
    lIOOlOOOI.BackgroundTransparency = 1
    lIOOlOOOI.TextColor3 = Color3.fromRGB((15+220), (8+227), (34+201))
    lIOOlOOOI.Font = Enum.Font.GothamBold
    lIOOlOOOI.TextSize = (14+3)
    lIOOlOOOI.TextXAlignment = Enum.TextXAlignment.Center
    lIOOlOOOI.Parent = Ol0IlO100l10

    
    local IO0IlI1l1 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(32+52),(22+79),(28+92),(18+98),(22+54),(27+70),(39+59),(30+71),(4+104)}))
    local _O06f9779d = (1*(21+11))
    IO0IlI1l1.Text = message
    IO0IlI1l1.Size = UDim2.new(1, -(36+4), 0, (18+32))
    IO0IlI1l1.Position = UDim2.new(0, (14+6), 0, (18+88))
    IO0IlI1l1.BackgroundTransparency = 1
    IO0IlI1l1.TextColor3 = Color3.fromRGB((27+133), (26+134), (10+165))
    IO0IlI1l1.Font = Enum.Font.Gotham
    IO0IlI1l1.TextSize = (6+7)
    IO0IlI1l1.TextWrapped = true
    IO0IlI1l1.TextXAlignment = Enum.TextXAlignment.Center
    IO0IlI1l1.Parent = Ol0IlO100l10

    
    local IIl0I0IIOO1OI1 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(5+79),(42+59),(28+92),(45+71),(11+65),(34+63),(36+62),(8+93),(17+91)}))
    IIl0I0IIOO1OI1.Size = UDim2.new(1, -(8+32), 0, (15+5))
    IIl0I0IIOO1OI1.Position = UDim2.new(0, (7+13), 0, (40+122))
    IIl0I0IIOO1OI1.BackgroundTransparency = 1
    IIl0I0IIOO1OI1.TextColor3 = Color3.fromRGB((29+71), (48+52), (20+100))
    IIl0I0IIOO1OI1.Font = Enum.Font.GothamBold
    IIl0I0IIOO1OI1.TextSize = (3+8)
    IIl0I0IIOO1OI1.TextXAlignment = Enum.TextXAlignment.Center
    IIl0I0IIOO1OI1.Parent = Ol0IlO100l10

    
    Ol0IlO100l10.Position = UDim2.new(0.5, -(12+198), 0.5, -(41+19))
    Ol0IlO100l10.BackgroundTransparency = 1
    TweenService:Create(Ol0IlO100l10, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -(17+193), 0.5, -(18+82)),
        BackgroundTransparency = 0
    }):Play()

    
    task.spawn(function()
        for i = (2+3), 1, -1 do
            IIl0I0IIOO1OI1.Text = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(42+26),(15+90),(3+112),(5+94),(22+89),(25+85),(9+101),(2+99),(1+98),(14+102),(41+64),(36+74),(49+54),(17+15),(46+59),(29+81),(31+1)}) .. i .. "s..."
            task.wait(1)
        end
        LocalPlayer:Kick("\n[LegendLua] " .. message .. "\n\nGet a key at your LegendLua portal.")
    end)
end


local function l0ll0I0OI00(k)
    return type(k) == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(24+91),(8+108),(30+84),(38+67),(36+74),(2+101)}) and k:match("^LegendLua%-%w%w%w%w%-%w%w%w%w%-%w%w%w%w$") ~= nil
end
local _0xd007fc4d = nil

if not l0ll0I0OI00(KEY) then
    showKickScreen("No valid key provided.\nPaste your key into the script before running.")
    return
end




local PORTAL_URL = "https://legendportal.up.railway.app/"

local verifySuccess, verifyResult = pcall(function()
    return HttpService:RequestAsync({
        Url = PORTAL_URL .. (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(15+32),(13+105),(37+64),(19+95),(19+86),(26+76),(12+109)}),
        Method = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(39+41),(34+45),(28+55),(6+78)}),
        Headers = { [(function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(35+32),(41+70),(28+82),(47+69),(39+62),(3+107),(17+99),(12+33),(3+81),(26+95),(29+83),(15+86)})] = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+57),(45+67),(25+87),(24+84),(15+90),(42+57),(47+50),(9+107),(12+93),(33+78),(49+61),(24+23),(21+85),(1+114),(6+105),(24+86)}) },
        Body = HttpService:JSONEncode({
            key = KEY,
            userId = tostring(LocalPlayer.UserId)
        })
    })
end)

if not verifySuccess then
    
    warn("[LegendLua] Could not reach verification server. Running in offline mode.")
else
    local OI1Ol0100, data = pcall(function()
        return HttpService:JSONDecode(verifyResult.Body)
    end)

    if not OI1Ol0100 or not data.success then
        local lIl0III1O1lIOI = (OI1Ol0100 and data.message) or "Verification failed."
        showKickScreen(lIl0III1O1lIOI)
        return
    end
end

print("[LegendLua] Key accepted: " .. KEY)
local _O009109a7 = tostring((34+6399))
print("[LegendLua] User verified: " .. LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")")


local Camera   = Workspace.CurrentCamera
local Il100OIl0l = game:GetService((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(50+27),(46+51),(41+73),(7+100),(40+61),(50+66),(2+110),(50+58),(47+50),(40+59),(7+94),(19+64),(6+95),(6+108),(42+76),(50+55),(28+71),(6+95)})):GetProductInfo(game.PlaceId).Name

local GAMES = {
    BLOX_FRUITS    = {2753915549, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+20),(22+86),(44+67),(26+94),(2+30),(46+24),(39+75),(32+85),(39+66),(23+93),(39+76)})},
    ARSENAL        = {286090429,  (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(24+41),(13+101),(9+106),(24+77),(49+61),(49+48),(2+106)})},
    ADOPT_ME       = {920587237,  (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(17+48),(20+80),(35+76),(18+94),(42+74),(6+26),(30+47),(19+82),(13+20)})},
    MURDER_MYSTERY = {142823291,  (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(7+70),(11+106),(17+97),(7+93),(11+90),(47+67),(21+11),(17+60),(41+80),(15+100),(38+78),(24+77),(12+102),(15+106),(4+28),(20+30)})},
}

local currentGame = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(39+46),(29+49),(36+37),(19+67),(39+30),(18+64),(28+55),(30+35),(30+46)})
for id, data in pairs(GAMES) do
    if game.PlaceId == data[1] then
        currentGame = id
        break
    end
end

print("[LegendLua] Game detected: " .. (GAMES[currentGame] and GAMES[currentGame][(2+0)] or Il100OIl0l))


local State = {
    flyEnabled      = false,
    flySpeed        = (14+36),
    noclipEnabled   = false,
    espEnabled      = false,
    espShowNames    = true,
    espShowBoxes    = true,
    espShowDistance = false,
    speedEnabled    = false,
    speedValue      = (26+6),
    jumpEnabled     = false,
    jumpValue       = (34+16),
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


if CoreGui:FindFirstChild("LegendLuaHub") then
    CoreGui:FindFirstChild("LegendLuaHub"):Destroy()
end

local ScreenGui = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(29+54),(31+68),(28+86),(6+95),(27+74),(1+109),(13+58),(28+89),(4+101)}))
ScreenGui.Name = "LegendLuaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local lI100l0lI1lIl = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(18+52),(26+88),(4+93),(45+64),(2+99)}))
lI100l0lI1lIl.Name = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(48+60),(11+62),(21+28),(33+15),(48+0),(5+103),(22+26),(42+66),(37+36),(15+34),(31+77),(1+72),(6+102)})
lI100l0lI1lIl.Size = UDim2.new(0, (17+463), 0, (9+511))
lI100l0lI1lIl.Position = UDim2.new(0.5, -(46+194), 0.5, -(28+232))
lI100l0lI1lIl.BackgroundColor3 = Color3.fromRGB((3+15), (13+5), (20+2))
lI100l0lI1lIl.BorderSizePixel = 0
lI100l0lI1lIl.Active = true
lI100l0lI1lIl.Draggable = true
lI100l0lI1lIl.Parent = ScreenGui

local IOI11l0II = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(27+58),(38+35),(32+35),(17+94),(33+81),(34+76),(6+95),(8+106)}))
IOI11l0II.CornerRadius = UDim.new(0, (8+2))
IOI11l0II.Parent = lI100l0lI1lIl

local O1I00l11 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(18+67),(39+34),(48+35),(12+104),(48+66),(26+85),(30+77),(45+56)}))
O1I00l11.Color = Color3.fromRGB((4+51), (31+24), (1+69))
O1I00l11.Thickness = 1
O1I00l11.Parent = lI100l0lI1lIl

local OIOI0I0Ol = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(44+26),(11+103),(17+80),(33+76),(47+54)}))
OIOI0I0Ol.Size = UDim2.new(1, 0, 0, (9+39))
OIOI0I0Ol.BackgroundColor3 = Color3.fromRGB((16+8), (1+23), (13+17))
OIOI0I0Ol.BorderSizePixel = 0
OIOI0I0Ol.Parent = lI100l0lI1lIl

local lOl1lO10O0O1 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(45+40),(24+49),(24+43),(8+103),(29+85),(35+75),(15+86),(7+107)}))
lOl1lO10O0O1.CornerRadius = UDim.new(0, (10+0))
lOl1lO10O0O1.Parent = OIOI0I0Ol

local l0I1OIlOOIlOI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(11+59),(43+71),(10+87),(13+96),(21+80)}))
l0I1OIlOOIlOI.Size = UDim2.new(1, 0, 0, (10+0))
l0I1OIlOOIlOI.Position = UDim2.new(0, 0, 1, -(6+4))
l0I1OIlOOIlOI.BackgroundColor3 = Color3.fromRGB((9+15), (13+11), (14+16))
l0I1OIlOOIlOI.BorderSizePixel = 0
l0I1OIlOOIlOI.Parent = OIOI0I0Ol

local _0x91b204 = ((8+1)*(49+3))
local l11lOl1lO0lO = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(9+75),(27+74),(42+78),(38+78),(39+37),(5+92),(9+89),(45+56),(15+93)}))
l11lOl1lO0lO.Text = "LegendLua  |  " .. (GAMES[currentGame] and GAMES[currentGame][(1+1)] or Il100OIl0l)
l11lOl1lO0lO.Size = UDim2.new(1, -(34+26), 1, 0)
l11lOl1lO0lO.Position = UDim2.new(0, (10+6), 0, 0)
l11lOl1lO0lO.BackgroundTransparency = 1
l11lOl1lO0lO.TextColor3 = Color3.fromRGB((35+205), (50+190), (14+226))
l11lOl1lO0lO.TextXAlignment = Enum.TextXAlignment.Left
l11lOl1lO0lO.Font = Enum.Font.GothamBold
l11lOl1lO0lO.TextSize = (4+10)
l11lOl1lO0lO.Parent = OIOI0I0Ol

local O0Ol1lOIll = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(30+54),(50+51),(2+118),(34+82),(43+23),(38+79),(35+81),(21+95),(33+78),(40+70)}))
O0Ol1lOIll.Size = UDim2.new(0, (20+12), 0, (7+25))
O0Ol1lOIll.Position = UDim2.new(1, -(4+38), 0, (1+7))
O0Ol1lOIll.BackgroundColor3 = Color3.fromRGB((14+36), (25+25), (26+34))
O0Ol1lOIll.Text = "✕"
O0Ol1lOIll.TextColor3 = Color3.fromRGB((4+176), (41+139), (31+159))
O0Ol1lOIll.Font = Enum.Font.GothamBold
O0Ol1lOIll.TextSize = (6+7)
O0Ol1lOIll.BorderSizePixel = 0
O0Ol1lOIll.Parent = OIOI0I0Ol

local OlOI0lOI10 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+45),(12+61),(18+49),(17+94),(33+81),(40+70),(9+92),(37+77)}))
OlOI0lOI10.CornerRadius = UDim.new(0, (4+2))
OlOI0lOI10.Parent = O0Ol1lOIll

O0Ol1lOIll.MouseButton1Click:Connect(function()
    lI100l0lI1lIl.Visible = not lI100l0lI1lIl.Visible
end)

local OI0IIOOI0IOl00 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(12+72),(15+86),(16+104),(31+85),(42+34),(40+57),(50+48),(30+71),(11+97)}))
OI0IIOOI0IOl00.Text = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(3+77),(1+113),(24+77),(29+86),(36+79),(23+9),(18+14),(18+64),(42+63),(7+96),(14+90),(47+69),(47+36),(14+90),(41+64),(18+84),(36+80),(21+11),(12+20),(25+91),(1+110),(22+10),(9+107),(16+95),(14+89),(32+71),(33+75),(47+54)})
OI0IIOOI0IOl00.Size = UDim2.new(0, (23+177), 0, (2+16))
OI0IIOOI0IOl00.Position = UDim2.new(0.5, -(22+78), 1, (1+5))
OI0IIOOI0IOl00.BackgroundTransparency = 1
OI0IIOOI0IOl00.TextColor3 = Color3.fromRGB((30+60), (15+75), (17+93))
OI0IIOOI0IOl00.Font = Enum.Font.Gotham
OI0IIOOI0IOl00.TextSize = (11+0)
OI0IIOOI0IOl00.Parent = lI100l0lI1lIl

UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightShift then
        lI100l0lI1lIl.Visible = not lI100l0lI1lIl.Visible
    end
end)

local llO00Ill = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(44+26),(48+66),(27+70),(27+82),(12+89)}))
llO00Ill.Size = UDim2.new(1, -(5+15), 0, (7+27))
llO00Ill.Position = UDim2.new(0, (9+1), 0, (43+13))
llO00Ill.BackgroundTransparency = 1
llO00Ill.Parent = lI100l0lI1lIl

local O00llII0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(17+68),(11+62),(9+67),(17+88),(14+101),(40+76),(18+58),(47+50),(36+85),(43+68),(18+99),(36+80)}))
O00llII0.FillDirection = Enum.FillDirection.Horizontal
O00llII0.Padding = UDim.new(0, (3+3))
O00llII0.Parent = llO00Ill

local l0OOIIIOO = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(7+76),(9+90),(11+103),(26+85),(6+102),(24+84),(23+82),(42+68),(46+57),(30+40),(27+87),(11+86),(21+88),(43+58)}))
l0OOIIIOO.Size = UDim2.new(1, -(11+9), 1, -(1+109))
l0OOIIIOO.Position = UDim2.new(0, (10+0), 0, (49+49))
l0OOIIIOO.BackgroundTransparency = 1
l0OOIIIOO.BorderSizePixel = 0
local _ll8f7bc1 = ((10+71)*(2+1))
l0OOIIIOO.ScrollBarThickness = (3+0)
l0OOIIIOO.ScrollBarImageColor3 = Color3.fromRGB((11+69), (31+49), (9+91))
l0OOIIIOO.CanvasSize = UDim2.new(0, 0, 0, 0)
l0OOIIIOO.AutomaticCanvasSize = Enum.AutomaticSize.Y
l0OOIIIOO.Parent = lI100l0lI1lIl

local OI0IOIlO0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(21+64),(6+67),(20+56),(42+63),(39+76),(25+91),(38+38),(37+60),(35+86),(41+70),(4+113),(33+83)}))
OI0IOIlO0.Padding = UDim.new(0, (5+3))
OI0IOIlO0.Parent = l0OOIIIOO


local OI00I011II0O0 = nil
local O01110II1IOIIO = {}

local function Ol0O01l11I1ll(name)
    local O1lI000111l0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(13+71),(23+78),(11+109),(46+70),(13+53),(32+85),(43+73),(25+91),(11+100),(38+72)}))
    O1lI000111l0.Size = UDim2.new(0, 0, 1, 0)
    O1lI000111l0.AutomaticSize = Enum.AutomaticSize.X
    O1lI000111l0.BackgroundColor3 = Color3.fromRGB((9+21), (29+1), (10+28))
    O1lI000111l0.Text = "  " .. name .. "  "
    O1lI000111l0.TextColor3 = Color3.fromRGB((43+97), (6+134), (39+121))
    O1lI000111l0.Font = Enum.Font.GothamSemibold
    O1lI000111l0.TextSize = (11+1)
    O1lI000111l0.BorderSizePixel = 0
    O1lI000111l0.Parent = llO00Ill

    local l1I111OI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(13+72),(6+67),(45+22),(12+99),(32+82),(23+87),(38+63),(24+90)}))
    l1I111OI.CornerRadius = UDim.new(0, (1+5))
    l1I111OI.Parent = O1lI000111l0

    local II10I1IIIIOl = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(13+57),(40+74),(11+86),(34+75),(4+97)}))
    II10I1IIIIOl.Size = UDim2.new(1, 0, 0, 0)
    II10I1IIIIOl.AutomaticSize = Enum.AutomaticSize.Y
    II10I1IIIIOl.BackgroundTransparency = 1
    II10I1IIIIOl.Visible = false
    local _0x1fac9 = ((43+48)*(4+24))
    II10I1IIIIOl.Parent = l0OOIIIOO

    local II01III0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(3+82),(33+40),(36+40),(5+100),(8+107),(21+95),(47+29),(35+62),(38+83),(39+72),(30+87),(9+107)}))
    II01III0.Padding = UDim.new(0, (5+3))
    II01III0.Parent = II10I1IIIIOl

    O01110II1IOIIO[name] = {O1lI000111l0 = O1lI000111l0, II10I1IIIIOl = II10I1IIIIOl}

    O1lI000111l0.MouseButton1Click:Connect(function()
        for n, t in pairs(O01110II1IOIIO) do
            t.II10I1IIIIOl.Visible = false
            t.O1lI000111l0.BackgroundColor3 = Color3.fromRGB((21+9), (29+1), (15+23))
            t.O1lI000111l0.TextColor3 = Color3.fromRGB((16+124), (4+136), (14+146))
        end
        II10I1IIIIOl.Visible = true
        O1lI000111l0.BackgroundColor3 = Color3.fromRGB((44+211), (9+246), (1+254))
        O1lI000111l0.TextColor3 = Color3.fromRGB((6+12), (2+16), (15+7))
        OI00I011II0O0 = name
    end)

    return II10I1IIIIOl
end

local function OI1OOOI0l(parent, labelText, stateKey, callback)
    local O0l0OlO110lll = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(18+52),(2+112),(23+74),(46+63),(15+86)}))
    O0l0OlO110lll.Size = UDim2.new(1, 0, 0, (19+19))
    O0l0OlO110lll.BackgroundColor3 = Color3.fromRGB((6+20), (14+12), (26+6))
    O0l0OlO110lll.BorderSizePixel = 0
    O0l0OlO110lll.Parent = parent

    local II1l01ll = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(5+80),(38+35),(47+20),(27+84),(2+112),(20+90),(46+55),(17+97)}))
    II1l01ll.CornerRadius = UDim.new(0, (5+3))
    II1l01ll.Parent = O0l0OlO110lll

    local O0lO0OI0I0I111 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+38),(35+66),(14+106),(37+79),(10+66),(43+54),(29+69),(6+95),(42+66)}))
    O0lO0OI0I0I111.Text = labelText
    O0lO0OI0I0I111.Size = UDim2.new(1, -(35+25), 1, 0)
    O0lO0OI0I0I111.Position = UDim2.new(0, (10+4), 0, 0)
    O0lO0OI0I0I111.BackgroundTransparency = 1
    O0lO0OI0I0I111.TextColor3 = Color3.fromRGB((18+192), (35+175), (21+199))
    O0lO0OI0I0I111.TextXAlignment = Enum.TextXAlignment.Left
    O0lO0OI0I0I111.Font = Enum.Font.Gotham
    O0lO0OI0I0I111.TextSize = (8+5)
    O0lO0OI0I0I111.Parent = O0l0OlO110lll

    local l0ll0IIIIIOOO = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(24+46),(17+97),(33+64),(50+59),(11+90)}))
    l0ll0IIIIIOOO.Size = UDim2.new(0, (16+20), 0, (14+6))
    l0ll0IIIIIOOO.Position = UDim2.new(1, -(44+6), 0.5, -(6+4))
    l0ll0IIIIIOOO.BackgroundColor3 = Color3.fromRGB((30+20), (44+6), (33+29))
    l0ll0IIIIIOOO.BorderSizePixel = 0
    l0ll0IIIIIOOO.Parent = O0l0OlO110lll

    local I0lO1O100OO0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(39+46),(2+71),(39+28),(40+71),(43+71),(39+71),(22+79),(19+95)}))
    I0lO1O100OO0.CornerRadius = UDim.new(1, 0)
    I0lO1O100OO0.Parent = l0ll0IIIIIOOO

    local O111IOlllO10 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(50+20),(10+104),(17+80),(44+65),(45+56)}))
    O111IOlllO10.Size = UDim2.new(0, (6+8), 0, (6+8))
    local _llaff27 = ((25+12)*(42+42))
    O111IOlllO10.Position = UDim2.new(0, (2+1), 0.5, -(7+0))
    O111IOlllO10.BackgroundColor3 = Color3.fromRGB((38+122), (22+138), (12+163))
    O111IOlllO10.BorderSizePixel = 0
    O111IOlllO10.Parent = l0ll0IIIIIOOO

    local I1O1IIlI0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(17+68),(10+63),(8+59),(15+96),(6+108),(5+105),(36+65),(38+76)}))
    I1O1IIlI0.CornerRadius = UDim.new(1, 0)
    local __397cc6d69 = ((41+48)*(47+45))
    I1O1IIlI0.Parent = O111IOlllO10

    local function I10lll000I()
        local I10I10lIO10O1I = State[stateKey]
        TweenService:Create(l0ll0IIIIIOOO, TweenInfo.new(0.15), {
            BackgroundColor3 = I10I10lIO10O1I and Color3.fromRGB((45+55), (35+165), (41+79)) or Color3.fromRGB((1+49), (34+16), (21+41))
        }):Play()
        TweenService:Create(O111IOlllO10, TweenInfo.new(0.15), {
            Position = I10I10lIO10O1I and UDim2.new(0, (18+1), 0.5, -(4+3)) or UDim2.new(0, (2+1), 0.5, -(7+0)),
            BackgroundColor3 = I10I10lIO10O1I and Color3.fromRGB((35+220), (5+250), (9+246)) or Color3.fromRGB((44+116), (27+133), (48+127))
        }):Play()
    end

    local O1lI000111l0 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(36+48),(24+77),(38+82),(36+80),(29+37),(45+72),(21+95),(27+89),(38+73),(18+92)}))
    O1lI000111l0.Size = UDim2.new(1, 0, 1, 0)
    O1lI000111l0.BackgroundTransparency = 1
    O1lI000111l0.Text = ""
    O1lI000111l0.Parent = O0l0OlO110lll

    O1lI000111l0.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        I10lll000I()
        if callback then callback(State[stateKey]) end
    end)

    I10lll000I()
    return O0l0OlO110lll
end

local function llOII0IIl1O0(parent, labelText, stateKey, minVal, maxVal, callback)
    local O0l0OlO110lll = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(7+63),(9+105),(43+54),(14+95),(5+96)}))
    O0l0OlO110lll.Size = UDim2.new(1, 0, 0, (38+16))
    O0l0OlO110lll.BackgroundColor3 = Color3.fromRGB((21+5), (17+9), (23+9))
    O0l0OlO110lll.BorderSizePixel = 0
    O0l0OlO110lll.Parent = parent

    local II1l01ll = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(21+64),(31+42),(35+32),(10+101),(27+87),(17+93),(42+59),(43+71)}))
    II1l01ll.CornerRadius = UDim.new(0, (7+1))
    II1l01ll.Parent = O0l0OlO110lll

    local O0lO0OI0I0I111 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(3+81),(49+52),(19+101),(6+110),(23+53),(18+79),(11+87),(12+89),(7+101)}))
    local _O08e9f4ab9f = tostring((6+9217))
    O0lO0OI0I0I111.Size = UDim2.new(1, -(7+53), 0, (4+20))
    O0lO0OI0I0I111.Position = UDim2.new(0, (6+8), 0, 0)
    O0lO0OI0I0I111.BackgroundTransparency = 1
    O0lO0OI0I0I111.TextColor3 = Color3.fromRGB((39+171), (27+183), (11+209))
    O0lO0OI0I0I111.TextXAlignment = Enum.TextXAlignment.Left
    O0lO0OI0I0I111.Font = Enum.Font.Gotham
    O0lO0OI0I0I111.TextSize = (3+10)
    O0lO0OI0I0I111.Parent = O0l0OlO110lll

    local I00O0OII = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(38+46),(40+61),(11+109),(24+92),(46+30),(34+63),(41+57),(21+80),(20+88)}))
    I00O0OII.Size = UDim2.new(0, (7+43), 0, (4+20))
    I00O0OII.Position = UDim2.new(1, -(6+54), 0, 0)
    I00O0OII.BackgroundTransparency = 1
    I00O0OII.TextColor3 = Color3.fromRGB((48+72), (11+189), (22+118))
    I00O0OII.TextXAlignment = Enum.TextXAlignment.Right
    I00O0OII.Font = Enum.Font.GothamBold
    I00O0OII.TextSize = (6+7)
    I00O0OII.Parent = O0l0OlO110lll

    local lIOO1010 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(36+34),(10+104),(35+62),(25+84),(32+69)}))
    lIOO1010.Size = UDim2.new(1, -(24+4), 0, (2+2))
    lIOO1010.Position = UDim2.new(0, (14+0), 0, (32+4))
    lIOO1010.BackgroundColor3 = Color3.fromRGB((30+15), (36+9), (48+10))
    lIOO1010.BorderSizePixel = 0
    lIOO1010.Parent = O0l0OlO110lll

    local OlOlllIlIl11 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(22+63),(6+67),(41+26),(15+96),(31+83),(38+72),(29+72),(43+71)}))
    OlOlllIlIl11.CornerRadius = UDim.new(1, 0)
    OlOlllIlIl11.Parent = lIOO1010

    local O11OIIllI = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(41+29),(27+87),(11+86),(47+62),(45+56)}))
    local _0xb23e68 = ((1+5)*(9+12))
    O11OIIllI.Size = UDim2.new(0, 0, 1, 0)
    O11OIIllI.BackgroundColor3 = Color3.fromRGB((12+88), (1+199), (21+99))
    O11OIIllI.BorderSizePixel = 0
    O11OIIllI.Parent = lIOO1010

    local Ol0I1lOIOIlOII = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(48+37),(25+48),(45+22),(11+100),(20+94),(31+79),(22+79),(9+105)}))
    Ol0I1lOIOIlOII.CornerRadius = UDim.new(1, 0)
    Ol0I1lOIOIlOII.Parent = O11OIIllI

    local function ll1ll10lIll1(val)
        val = math.clamp(math.floor(val), minVal, maxVal)
        State[stateKey] = val
        local l10I1I110O1 = (val - minVal) / (maxVal - minVal)
        O11OIIllI.Size = UDim2.new(l10I1I110O1, 0, 1, 0)
        O0lO0OI0I0I111.Text = labelText
        I00O0OII.Text = tostring(val)
        if callback then callback(val) end
    end

    ll1ll10lIll1(State[stateKey])

    local lOO11110O0III = false
    lIOO1010.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            lOO11110O0III = true
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            lOO11110O0III = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if lOO11110O0III and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local l100I0llOI01I = lIOO1010.AbsolutePosition
            local l0l0IIII0l0I = lIOO1010.AbsoluteSize
            local l10I1I110O1 = math.clamp((inp.Position.X - l100I0llOI01I.X) / l0l0IIII0l0I.X, 0, 1)
            ll1ll10lIll1(minVal + (maxVal - minVal) * l10I1I110O1)
        end
    end)

    return O0l0OlO110lll
end

local function Il1O0l1lIOl1Ol(parent, text)
    local O0lO0OI0I0I111 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(39+45),(11+90),(4+116),(9+107),(16+60),(43+54),(16+82),(22+79),(7+101)}))
    O0lO0OI0I0I111.Size = UDim2.new(1, 0, 0, (11+11))
    local _0x8f3263 = nil
    O0lO0OI0I0I111.BackgroundTransparency = 1
    O0lO0OI0I0I111.Text = text:upper()
    O0lO0OI0I0I111.TextColor3 = Color3.fromRGB((49+41), (12+78), (5+105))
    O0lO0OI0I0I111.TextXAlignment = Enum.TextXAlignment.Left
    O0lO0OI0I0I111.Font = Enum.Font.GothamBold
    O0lO0OI0I0I111.TextSize = (2+8)
    O0lO0OI0I0I111.Parent = parent
    return O0lO0OI0I0I111
end


local l101lOO0 = Ol0O01l11I1ll((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(5+80),(21+89),(3+102),(19+99),(31+70),(34+80),(1+114),(17+80),(1+107)}))

Il1O0l1lIOl1Ol(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(49+28),(21+90),(45+73),(9+92),(30+79),(18+83),(18+92),(5+111)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+24),(20+88),(15+106)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(49+53),(14+94),(49+72),(35+34),(46+64),(37+60),(25+73),(35+73),(21+80),(9+91)}), function(I10I10lIO10O1I) end)
llOII0IIl1O0(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(3+67),(26+82),(18+103),(17+15),(4+79),(24+88),(49+52),(4+97),(49+51)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(22+80),(15+93),(4+117),(8+75),(39+73),(40+61),(45+56),(9+91)}), (5+5), (4+196))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+32),(29+82),(20+79),(42+66),(6+99),(8+104)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(27+83),(22+89),(36+63),(8+100),(27+78),(39+73),(4+65),(5+105),(21+76),(34+64),(43+65),(46+55),(37+63)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(20+63),(29+83),(48+53),(49+52),(18+82),(18+14),(32+34),(26+85),(40+71),(4+111),(34+82)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(14+101),(47+65),(35+66),(21+80),(49+51),(38+31),(21+89),(8+89),(15+83),(42+66),(12+89),(43+57)}), function(I10I10lIO10O1I)
    local Oll01IO1I = LocalPlayer.Character
    if Oll01IO1I then
        local ll00II1OI1 = Oll01IO1I:FindFirstChildOfClass("Humanoid")
        if ll00II1OI1 then ll00II1OI1.WalkSpeed = I10I10lIO10O1I and State.speedValue or (3+13) end
    end
end)
llOII0IIl1O0(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(37+50),(27+70),(1+107),(46+61),(8+24),(4+79),(22+90),(29+72),(30+71),(42+58)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(19+96),(48+64),(24+77),(42+59),(27+73),(6+80),(22+75),(1+107),(31+86),(4+97)}), (8+8), (43+257), function(v)
    if State.speedEnabled then
        local Oll01IO1I = LocalPlayer.Character
        if Oll01IO1I then
            local ll00II1OI1 = Oll01IO1I:FindFirstChildOfClass("Humanoid")
            if ll00II1OI1 then ll00II1OI1.WalkSpeed = v end
        end
    end
end)
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(38+36),(26+91),(48+61),(38+74),(19+13),(17+49),(49+62),(37+74),(37+78),(17+99)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(25+81),(42+75),(13+96),(2+110),(27+42),(8+102),(19+78),(24+74),(40+68),(32+69),(39+61)}), function(I10I10lIO10O1I)
    local Oll01IO1I = LocalPlayer.Character
    if Oll01IO1I then
        local ll00II1OI1 = Oll01IO1I:FindFirstChildOfClass("Humanoid")
        if ll00II1OI1 then ll00II1OI1.JumpPower = I10I10lIO10O1I and State.jumpValue or (37+13) end
    end
end)
llOII0IIl1O0(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(35+39),(5+112),(47+62),(28+84),(22+10),(22+58),(6+105),(44+75),(48+53),(47+67)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(1+105),(8+109),(38+71),(30+82),(24+62),(42+55),(31+77),(24+93),(7+94)}), (48+2), (36+264), function(v)
    if State.jumpEnabled then
        local Oll01IO1I = LocalPlayer.Character
        if Oll01IO1I then
            local _ll3be13e07 = nil
            local ll00II1OI1 = Oll01IO1I:FindFirstChildOfClass("Humanoid")
            if ll00II1OI1 then ll00II1OI1.JumpPower = v end
        end
    end
end)
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(7+66),(13+97),(47+55),(43+62),(22+88),(4+101),(21+95),(43+58),(15+17),(28+46),(47+70),(3+106),(37+75)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(48+57),(32+78),(5+97),(11+94),(43+67),(23+82),(15+101),(18+83),(6+68),(43+74),(5+104),(33+79)}))

Il1O0l1lIOl1Ol(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(44+42),(18+87),(13+102),(25+92),(8+89),(43+65),(39+76)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(12+57),(8+75),(17+63)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(41+60),(18+97),(21+91),(3+66),(1+109),(21+76),(34+64),(30+78),(2+99),(28+72)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(20+49),(40+43),(19+61),(17+15),(21+8191),(19+13),(38+45),(16+88),(43+68),(8+111),(8+24),(24+54),(25+72),(27+82),(19+82),(23+92)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+55),(15+100),(43+69),(1+82),(19+85),(17+94),(19+100),(1+77),(30+67),(33+76),(48+53),(3+112)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(16+53),(10+73),(35+45),(23+9),(44+8168),(19+13),(50+33),(25+79),(27+84),(49+70),(26+6),(2+64),(8+103),(17+103),(37+64),(18+97)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(35+66),(30+85),(18+94),(41+42),(35+69),(21+90),(38+81),(42+24),(31+80),(36+84),(48+53),(18+97)}))
OI1OOOI0l(l101lOO0, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(9+60),(27+56),(16+64),(22+10),(34+8178),(1+31),(34+49),(44+60),(5+106),(25+94),(8+24),(45+23),(31+74),(15+100),(44+72),(4+93),(13+97),(30+69),(10+91)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(28+73),(27+88),(31+81),(45+38),(35+69),(2+109),(28+91),(22+46),(17+88),(30+85),(4+112),(11+86),(9+101),(21+78),(3+98)}))

if currentGame == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(47+19),(6+70),(4+75),(25+63),(46+49),(36+34),(50+32),(6+79),(35+38),(46+38),(19+64)}) then
    local IOO00OIllllI = Ol0O01l11I1ll((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(41+25),(50+58),(20+91),(28+92),(22+10),(33+37),(35+79),(11+106),(33+72),(10+106),(48+67)}))
    Il1O0l1lIOl1Ol(IOO00OIllllI, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(2+68),(19+78),(50+64),(35+74),(39+66),(49+61),(43+60)}))
    OI1OOOI0l(IOO00OIllllI, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(34+31),(21+96),(35+81),(32+79),(17+15),(36+34),(8+89),(45+69),(10+99)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(43+54),(40+77),(46+70),(20+91),(2+68),(16+81),(13+101),(39+70)}))
    local _ll056ace2bb = tostring((10+8209))
    Il1O0l1lIOl1Ol(IOO00OIllllI, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(49+21),(36+78),(28+89),(11+94),(49+67),(19+96)}))
    OI1OOOI0l(IOO00OIllllI, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(14+56),(10+104),(2+115),(34+71),(37+79),(3+29),(26+57),(45+65),(32+73),(50+62),(45+56),(13+101)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(32+70),(12+102),(6+111),(37+68),(24+92),(6+77),(43+67),(33+72),(42+70),(43+58)}))

elseif currentGame == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(30+35),(44+38),(36+47),(34+35),(26+52),(4+61),(34+42)}) then
    local OO1IOIl11l1 = Ol0O01l11I1ll((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(44+21),(19+95),(5+110),(3+98),(27+83),(11+86),(46+62)}))
    Il1O0l1lIOl1Ol(OO1IOIl11l1, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(25+42),(38+73),(2+107),(50+48),(36+61),(6+110)}))
    OI1OOOI0l(OO1IOIl11l1, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(23+60),(24+81),(38+70),(42+59),(26+84),(23+93),(12+20),(35+30),(27+78),(44+65)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(15+100),(7+98),(36+72),(28+73),(11+99),(39+77),(6+59),(37+68),(18+91)}))
    OI1OOOI0l(OO1IOIl11l1, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(27+43),(29+68),(28+87),(13+103),(3+29),(33+50),(34+70),(4+107),(23+88),(44+72)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(30+72),(28+69),(42+73),(25+91),(36+47),(15+89),(36+75),(6+105),(34+82)}))

elseif currentGame == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(41+24),(34+34),(7+72),(23+57),(23+61),(25+70),(14+63),(21+48)}) then
    local lOOOOIO1I = Ol0O01l11I1ll((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(24+41),(32+68),(40+71),(16+96),(42+74),(21+11),(30+47),(3+98)}))
    Il1O0l1lIOl1Ol(lOOOOIO1I, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(37+40),(49+62),(8+102),(12+89),(33+88)}))
    OI1OOOI0l(lOOOOIO1I, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(12+53),(16+101),(39+77),(19+92),(8+24),(46+21),(39+72),(39+69),(1+107),(40+61),(26+73),(36+80),(13+19),(14+52),(29+88),(12+87),(29+78),(29+86)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(26+71),(13+104),(14+102),(27+84),(2+65),(43+68),(32+76),(45+63),(46+55),(25+74),(16+100)}))
    Il1O0l1lIOl1Ol(lOOOOIO1I, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(16+70),(3+102),(20+95),(47+70),(9+88),(6+102),(34+81)}))
    OI1OOOI0l(lOOOOIO1I, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(32+48),(8+93),(39+77),(17+15),(28+41),(10+73),(41+39)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(44+68),(9+92),(30+86),(37+32),(4+79),(1+79)}))

elseif currentGame == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(38+39),(30+55),(30+52),(6+62),(24+45),(11+71),(8+87),(26+51),(12+77),(46+37),(17+67),(46+23),(7+75),(13+76)}) then
    local OI1II0I10IIO = Ol0O01l11I1ll((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(4+73),(34+43),(43+7)}))
    Il1O0l1lIOl1Ol(OI1II0I10IIO, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(1+69),(40+57),(15+99),(4+105),(19+86),(16+94),(23+80)}))
    OI1OOOI0l(OI1II0I10IIO, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(8+59),(3+108),(9+96),(39+71),(21+11),(14+56),(5+92),(23+91),(24+85)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(43+56),(8+103),(2+103),(33+77),(28+42),(17+80),(17+97),(28+81)}))
    Il1O0l1lIOl1Ol(OI1II0I10IIO, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(9+77),(16+89),(6+109),(36+81),(28+69),(25+83),(21+94)}))
    OI1OOOI0l(OI1II0I10IIO, (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+42),(32+79),(22+86),(5+96),(6+26),(35+34),(21+62),(17+63),(30+2),(38+2),(17+66),(47+57),(21+80),(41+73),(47+58),(11+91),(28+74),(30+17),(50+27),(43+74),(47+67),(12+88),(46+55),(42+72),(29+72),(1+113),(8+33)}), (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+74),(25+86),(14+94),(46+55),(30+39),(36+47),(2+78)}))
end


do
    local _ll4415da = ((13+41)*(42+32))
    local I1l1OlIlII0O0l = true
    for name, t in pairs(O01110II1IOIIO) do
        if I1l1OlIlII0O0l then
            t.II10I1IIIIOl.Visible = true
            t.O1lI000111l0.BackgroundColor3 = Color3.fromRGB((47+208), (7+248), (28+227))
            t.O1lI000111l0.TextColor3 = Color3.fromRGB((5+13), (12+6), (10+12))
            I1l1OlIlII0O0l = false
        end
    end
end


local II0100I00, flyBodyGyro

local _ll24a96 = ((3+10)*(12+2))
local function I11O0IO100ll11()
    local Oll01IO1I = LocalPlayer.Character
    if not Oll01IO1I then return end
    local O10l1l10OIOO = Oll01IO1I:FindFirstChild("HumanoidRootPart")
    if not O10l1l10OIOO then return end
    II0100I00 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(39+27),(7+104),(50+50),(48+73),(15+71),(47+54),(39+69),(26+85),(41+58),(26+79),(37+79),(19+102)}))
    II0100I00.Velocity = Vector3.zero
    II0100I00.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    II0100I00.Parent = O10l1l10OIOO
    flyBodyGyro = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(15+51),(14+97),(2+98),(25+96),(12+59),(2+119),(34+80),(25+86)}))
    flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBodyGyro.D = (28+72)
    flyBodyGyro.Parent = O10l1l10OIOO
end

local function IIOlII0O1()
    if II0100I00 then II0100I00:Destroy() II0100I00 = nil end
    if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
end

RunService.Heartbeat:Connect(function()
    local Oll01IO1I = LocalPlayer.Character
    if not Oll01IO1I then return end
    local O10l1l10OIOO = Oll01IO1I:FindFirstChild("HumanoidRootPart")
    local ll00II1OI1  = Oll01IO1I:FindFirstChildOfClass("Humanoid")

    if State.flyEnabled then
        if not II0100I00 or not II0100I00.Parent then I11O0IO100ll11() end
        if II0100I00 and flyBodyGyro then
            local OII0I0lI01 = Camera.CFrame
            local I0O10O1IIlIO1I = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then I0O10O1IIlIO1I = I0O10O1IIlIO1I + OII0I0lI01.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then I0O10O1IIlIO1I = I0O10O1IIlIO1I - OII0I0lI01.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then I0O10O1IIlIO1I = I0O10O1IIlIO1I - OII0I0lI01.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then I0O10O1IIlIO1I = I0O10O1IIlIO1I + OII0I0lI01.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then I0O10O1IIlIO1I = I0O10O1IIlIO1I + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then I0O10O1IIlIO1I = I0O10O1IIlIO1I - Vector3.new(0,1,0) end
            II0100I00.Velocity = I0O10O1IIlIO1I * State.flySpeed
            flyBodyGyro.CFrame = OII0I0lI01
        end
    else
        IIOlII0O1()
    end

    if State.noclipEnabled then
        for _, part in ipairs(Oll01IO1I:GetDescendants()) do
            if part:IsA((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(40+26),(35+62),(24+91),(8+93),(14+66),(11+86),(32+82),(47+69)})) then part.CanCollide = false end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.infiniteJump then
        local Oll01IO1I = LocalPlayer.Character
        if Oll01IO1I then
            local ll00II1OI1 = Oll01IO1I:FindFirstChildOfClass("Humanoid")
            if ll00II1OI1 then ll00II1OI1:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)


local Oll10111 = {}

local function IIlll1ll()
    for _, obj in pairs(Oll10111) do
        if obj and obj.Parent then obj:Destroy() end
    end
    Oll10111 = {}
end

local function II1I0I1O()
    IIlll1ll()
    if not State.espEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local O10l1l10OIOO = plr.Character:FindFirstChild("HumanoidRootPart")
            local ll00II1OI1  = plr.Character:FindFirstChildOfClass("Humanoid")
            if O10l1l10OIOO and ll00II1OI1 and ll00II1OI1.Health > 0 then
                if State.espShowNames then
                    local l1IIll0I0l1O = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(33+33),(4+101),(23+85),(24+84),(42+56),(17+94),(15+82),(7+107),(36+64),(16+55),(45+72),(35+70)}))
                    l1IIll0I0l1O.Size = UDim2.new(0, (8+92), 0, (6+24))
                    l1IIll0I0l1O.StudsOffset = Vector3.new(0, (3+0), 0)
                    l1IIll0I0l1O.AlwaysOnTop = true
                    l1IIll0I0l1O.Adornee = O10l1l10OIOO
                    l1IIll0I0l1O.Parent = O10l1l10OIOO
                    local l01O0l0100O = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(17+67),(49+52),(26+94),(3+113),(27+49),(17+80),(39+59),(33+68),(35+73)}))
                    l01O0l0100O.Size = UDim2.new(1, 0, 1, 0)
                    l01O0l0100O.BackgroundTransparency = 1
                    l01O0l0100O.Text = plr.Name .. (State.espShowDistance and
                        ("\n" .. math.floor((LocalPlayer.Character and
                        LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                        (O10l1l10OIOO.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 0) .. "m") or "")
                    l01O0l0100O.TextColor3 = Color3.fromRGB((22+233), (20+60), (49+31))
                    l01O0l0100O.Font = Enum.Font.GothamBold
                    l01O0l0100O.TextSize = (8+5)
                    l01O0l0100O.TextStrokeTransparency = 0.4
                    l01O0l0100O.Parent = l1IIll0I0l1O
                    table.insert(Oll10111, l1IIll0I0l1O)
                end
                if State.espShowBoxes then
                    local I110lO110I10 = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(16+67),(29+72),(49+59),(26+75),(26+73),(50+66),(43+62),(44+67),(10+100),(21+45),(28+83),(16+104)}))
                    I110lO110I10.Adornee = plr.Character
                    I110lO110I10.Color3 = Color3.fromRGB((18+237), (43+17), (11+49))
                    I110lO110I10.LineThickness = 0.05
                    I110lO110I10.SurfaceTransparency = 0.85
                    I110lO110I10.SurfaceColor3 = Color3.fromRGB((32+223), (26+34), (44+16))
                    I110lO110I10.Parent = Workspace
                    table.insert(Oll10111, I110lO110I10)
                end
            end
        end
    end
end

local _O0c4f97 = tostring((33+5381))
RunService.RenderStepped:Connect(II1I0I1O)


RunService.Heartbeat:Connect(function()
    if currentGame ~= (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(33+44),(22+63),(15+67),(3+65),(5+64),(9+73),(9+86),(36+41),(2+87),(5+78),(27+57),(11+58),(30+52),(4+85)}) or not State.roleESP then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local O10l1l10OIOO = plr.Character:FindFirstChild("HumanoidRootPart")
            if O10l1l10OIOO and not O10l1l10OIOO:FindFirstChild((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(46+36),(20+91),(39+69),(17+84),(26+43),(22+61),(4+76),(12+83),(35+41),(8+68)})) then
                local IO10l0l1 = "?"
                local OI1Ol0100, role = pcall(function()
                    return plr.Character:FindFirstChild((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(17+65),(26+85),(48+60),(40+61)})) and plr.Character.Role.Value
                end)
                if OI1Ol0100 and role then IO10l0l1 = role end
                local l1IIll0I0l1O = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(19+47),(38+67),(5+103),(23+85),(32+66),(23+88),(13+84),(39+75),(50+50),(35+36),(27+90),(36+69)}))
                l1IIll0I0l1O.Name = (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(14+68),(28+83),(21+87),(47+54),(28+41),(30+53),(17+63),(47+48),(41+35),(36+40)})
                l1IIll0I0l1O.Size = UDim2.new(0, (36+44), 0, (19+5))
                l1IIll0I0l1O.StudsOffset = Vector3.new(0, (2+3), 0)
                l1IIll0I0l1O.AlwaysOnTop = true
                l1IIll0I0l1O.Adornee = O10l1l10OIOO
                l1IIll0I0l1O.Parent = O10l1l10OIOO
                local IO1lOI10lO = Instance.new((function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(21+63),(42+59),(24+96),(47+69),(13+63),(43+54),(10+88),(28+73),(3+105)}))
                IO1lOI10lO.Size = UDim2.new(1, 0, 1, 0)
                IO1lOI10lO.BackgroundTransparency = 1
                IO1lOI10lO.Text = "[" .. IO10l0l1 .. "]"
                local _O0362865 = math.floor(math.random()*(42+5660))
                IO1lOI10lO.TextColor3 = IO10l0l1 == (function(_t)local _s=""for _i=1,#_t do _s=_s..string.char(_t[_i])end return _s end)({(35+42),(44+73),(18+96),(18+82),(25+76),(11+103),(1+100),(18+96)}) and Color3.fromRGB((17+238),(19+31),(10+40)) or Color3.fromRGB((29+51),(5+175),(20+235))
                IO1lOI10lO.Font = Enum.Font.GothamBold
                IO1lOI10lO.TextSize = (3+9)
                IO1lOI10lO.TextStrokeTransparency = 0.3
                IO1lOI10lO.Parent = l1IIll0I0l1O
            end
        end
    end
end)

print("[LegendLua] Hub loaded successfully. Press RightShift to toggle UI.")
end)()
