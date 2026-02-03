--[[
    FAYYSCRIPT - PROTECTED VERSION
    "ANTI-MALING, ANTI-COPAS, GOBLOKERS DILARANG BONGKAR!"
]]

local _0x5265=game;local _0x4c6f=loadstring;local _0x506c=_0x5265:GetService("Players").LocalPlayer;
local _0x4775=function(s)local r=""for i=1,#s do r=r..string.char(s:sub(i,i):byte()-1)end return r end

-- Obfuscated Remotes & Strings
local _0x526d = _0x4775("\83\102\113\109\106\91\98\116\102\101\84\117\112\115\98\104\102") -- ReplicatedStorage
local _0x4e12 = _0x4775("\83\102\119\98\115\101") -- Reward
local _0x435f = _0x4775("\100\96\105\115\116") -- c_chr

local _0x1a2b = {
    _0x52 = _0x5265:GetService(_0x526d):WaitForChild("\78\101\116"):WaitForChild("\69\118\101\110\116\115"):WaitForChild(_0x4e12),
    _0x4c = nil
}

local _0xUi = function()
    local L_1 = _0x506c:WaitForChild("PlayerGui")
    local L_2 = _0x5265:GetService("UserInputService")
    
    if L_1:FindFirstChild("FayyScriptMobile") then L_1.FayyScriptMobile:Destroy() end
    
    local L_3 = Instance.new("ScreenGui")
    L_3.Name = "FayyScriptMobile"; L_3.Parent = L_1; L_3.ResetOnSpawn = false
    
    local function D(o)
        local dg, di, ds, sp
        o.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dg = true; ds = i.Position; sp = o.Position
                i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dg = false end end)
            end
        end)
        L_2.InputChanged:Connect(function(i) if dg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local dl = i.Position - ds
            o.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dl.X, sp.Y.Scale, sp.Y.Offset + dl.Y)
        end end)
    end

    local L_4 = Instance.new("Frame")
    L_4.Size = UDim2.new(0, 280, 0, 400); L_4.Position = UDim2.new(0.5, -140, 0.5, -200)
    L_4.BackgroundColor3 = Color3.fromRGB(10, 10, 10); L_4.BorderSizePixel = 2
    L_4.BorderColor3 = Color3.new(1, 1, 1); L_4.Visible = false; L_4.Parent = L_3
    Instance.new("UICorner", L_4); D(L_4)

    local L_5 = Instance.new("Frame")
    L_5.Size = UDim2.new(0, 260, 0, 150); L_5.Position = UDim2.new(0.5, -130, 0.5, -75)
    L_5.BackgroundColor3 = Color3.fromRGB(15, 15, 15); L_5.Parent = L_3
    Instance.new("UICorner", L_5)

    local function S(l)
        _0x1a2b._0x4c = l; L_5.Visible = false; L_4.Visible = true
    end

    local L_6 = Instance.new("TextButton")
    L_6.Size = UDim2.new(0.4, 0, 0, 40); L_6.Position = UDim2.new(0.08, 0, 0.5, 0)
    L_6.Text = "INDONESIA"; L_6.Parent = L_5; L_6.MouseButton1Click:Connect(function() S("ID") end)
    
    local L_7 = Instance.new("TextButton")
    L_7.Size = UDim2.new(0.4, 0, 0, 40); L_7.Position = UDim2.new(0.52, 0, 0.5, 0)
    L_7.Text = "ENGLISH"; L_7.Parent = L_5; L_7.MouseButton1Click:Connect(function() S("EN") end)

    local L_8 = Instance.new("ScrollingFrame")
    L_8.Size = UDim2.new(1, -20, 1, -60); L_8.Position = UDim2.new(0, 10, 0, 50)
    L_8.BackgroundTransparency = 1; L_8.Parent = L_4; Instance.new("UIListLayout", L_8).Padding = UDim.new(0, 10)

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1, 0, 0, 100); T.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    T.TextColor3 = Color3.new(0.8,0.8,0.8); T.TextWrapped = true; T.Parent = L_8; Instance.new("UICorner", T)

    local function Ci(p)
        local b = Instance.new("TextBox")
        b.Size = UDim2.new(1, 0, 0, 35); b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.TextColor3 = Color3.new(1, 1, 1); b.Parent = L_8; Instance.new("UICorner", b)
        return b
    end

    local function Cb(t)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold; b.Parent = L_8; Instance.new("UICorner", b)
        return b
    end

    local I1 = Ci(""); local I2 = Ci("")
    local B1 = Cb(""); local B2 = Cb("")

    task.spawn(function()
        while task.wait(0.5) do
            if _0x1a2b._0x4c == "ID" then
                T.Text = "STEP 1: Gacha.\nSTEP 2: Masukkan index sesuai urutan.\nEx: Gacha 1 = 2, Gacha 2 = 3."; I1.PlaceholderText = "Index (Ex: 2)..."; I2.PlaceholderText = "Jumlah..."; B1.Text = "\240\159\154\128 ULTRA INSTANT"; B2.Text = "\240\159\142\175 CUSTOM"
            elseif _0x1a2b._0x4c == "EN" then
                T.Text = "STEP 1: Roll.\nSTEP 2: Enter index by order.\nEx: 1st = 2, 2nd = 3."; I1.PlaceholderText = "Index (Ex: 2)..."; I2.PlaceholderText = "Amount..."; B1.Text = "\240\159\154\128 ULTRA INSTANT"; B2.Text = "\240\159\142\175 CUSTOM"
            end
        end
    end)

    local function X(a)
        local v = tonumber(I1.Text)
        if v then
            for b = 1, 10 do task.spawn(function() for i = 1, math.ceil(a/10) do _0x1a2b._0x52:FireServer(_0x435f, v) end end) end
        end
    end

    B1.MouseButton1Click:Connect(function() X(5000) end)
    B2.MouseButton1Click:Connect(function() local a = tonumber(I2.Text) if a then X(a) end end)

    local Tg = Instance.new("TextButton")
    Tg.Size = UDim2.new(0, 60, 0, 60); Tg.Position = UDim2.new(1, -70, 0.5, 0)
    Tg.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Tg.BorderSizePixel = 2
    Tg.BorderColor3 = Color3.new(1, 1, 1); Tg.Text = "HIDE"; Tg.TextColor3 = Color3.new(1, 1, 1)
    Tg.Font = Enum.Font.GothamBold; Tg.Parent = L_3; Instance.new("UICorner", Tg); D(Tg)

    Tg.MouseButton1Click:Connect(function()
        if _0x1a2b._0x4c then L_4.Visible = not L_4.Visible; Tg.Text = L_4.Visible and "HIDE" or "SHOW" end
    end)
end

_0xUi()
