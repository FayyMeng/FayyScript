local _0x5265=game;local _0x506c=_0x5265:GetService("Players").LocalPlayer;
local _0x4c6f=function(s)local r=""for i=1,#s do r=r..string.char(s:sub(i,i):byte()-1)end return r end

-- Enkripsi String Penting
local _0x526d = _0x4c6f("\83\102\113\109\106\91\98\116\102\100\84\116\111\114\98\104\102") -- ReplicatedStorage
local _0x4e12 = _0x4c6f("\83\102\119\98\115\101") -- Reward
local _0x435f = _0x4c6f("\100\96\105\115\116") -- c_chr

local _0x1a2b = {
    _0x52 = _0x5265:GetService("ReplicatedStorage"):WaitForChild("Net"):WaitForChild("Events"):WaitForChild(_0x4e12),
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
    L_4.Size = UDim2.new(0, 280, 0, 420); L_4.Position = UDim2.new(0.5, -140, 0.5, -210)
    L_4.BackgroundColor3 = Color3.fromRGB(10, 10, 10); L_4.BorderSizePixel = 2
    L_4.BorderColor3 = Color3.new(1, 1, 1); L_4.Parent = L_3
    Instance.new("UICorner", L_4); D(L_4)

    local Ttl = Instance.new("TextLabel")
    Ttl.Size = UDim2.new(1, 0, 0, 40); Ttl.Text = "FAYYSCRIPT v17.5"; Ttl.TextColor3 = Color3.new(1, 1, 1)
    Ttl.BackgroundTransparency = 0.9; Ttl.BackgroundColor3 = Color3.new(1, 1, 1); Ttl.Font = Enum.Font.GothamBold; Ttl.Parent = L_4

    local Scr = Instance.new("ScrollingFrame")
    Scr.Size = UDim2.new(1, -20, 1, -60); Scr.Position = UDim2.new(0, 10, 0, 50)
    Scr.BackgroundTransparency = 1; Scr.Parent = L_4; Instance.new("UIListLayout", Scr).Padding = UDim.new(0, 10)

    local Tut = Instance.new("TextLabel")
    Tut.Size = UDim2.new(1, 0, 0, 120); Tut.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tut.TextColor3 = Color3.new(0.8,0.8,0.8); Tut.TextWrapped = true; Tut.Parent = Scr; Instance.new("UICorner", Tut)
    Tut.Text = " 📜 DUPE TUTORIAL:\n 1. Roll/Gacha in-game first.\n 2. Enter index in Field 1.\n    (1st Roll = 2nd index, etc)\n 3. Enter amount in Field 2\n    (only for Custom Dupe).\n 4. Click the Dupe button!"

    local function Ci(p)
        local b = Instance.new("TextBox")
        b.Size = UDim2.new(1, 0, 0, 35); b.PlaceholderText = p; b.TextColor3 = Color3.new(1, 1, 1)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.Parent = Scr; Instance.new("UICorner", b); return b
    end

    local function Cb(t)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 40); b.Text = t; b.BackgroundColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold; b.Parent = Scr; Instance.new("UICorner", b); return b
    end

    local I1 = Ci("Field 1: Enter Index (Ex: 2)"); local I2 = Ci("Field 2: Dupe Amount (Custom)")

    local function X(a)
        local v = tonumber(I1.Text)
        if v and _0x1a2b._0x52 then
            for b = 1, 10 do task.spawn(function() for i = 1, math.ceil(a/10) do _0x1a2b._0x52:FireServer(_0x435f, v) end end) end
        end
    end

    Cb("🚀 INSTANT 5000 DUPE").MouseButton1Click:Connect(function() X(5000) end)
    Cb("🎯 START CUSTOM DUPE").MouseButton1Click:Connect(function() local a = tonumber(I2.Text) if a then X(a) end end)

    local Tg = Instance.new("TextButton")
    Tg.Size = UDim2.new(0, 60, 0, 30); Tg.Position = UDim2.new(1, -70, 0.5, 0)
    Tg.Text = "HIDE"; Tg.BackgroundColor3 = Color3.new(1, 1, 1); Tg.Parent = L_3; Instance.new("UICorner", Tg); D(Tg)

    Tg.MouseButton1Click:Connect(function() L_4.Visible = not L_4.Visible; Tg.Text = L_4.Visible and "HIDE" or "SHOW" end)
end

_0xUi()
            end
        end
    end)

    -- [EXECUTION]
    local function X(a)
        local v = tonumber(I1.Text)
        if v and _0x1a2b._0x52 then
            for b = 1, 10 do task.spawn(function() for i = 1, math.ceil(a/10) do _0x1a2b._0x52:FireServer(_0x435f, v) end end) end
        end
    end

    B1.MouseButton1Click:Connect(function() X(5000) end)
    B2.MouseButton1Click:Connect(function() local a = tonumber(I2.Text) if a then X(a) end end)

    -- [TOGGLE]
    local Tg = Instance.new("TextButton")
    Tg.Size = UDim2.new(0, 60, 0, 60); Tg.Position = UDim2.new(1, -70, 0.5, 0)
    Tg.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Tg.BorderSizePixel = 2
    Tg.BorderColor3 = Color3.new(1, 1, 1); Tg.Text = "HIDE"; Tg.TextColor3 = Color3.new(1, 1, 1)
    Tg.Font = Enum.Font.GothamBold; Tg.Parent = L_3; Instance.new("UICorner", Tg); D(Tg)

    Tg.MouseButton1Click:Connect(function()
        if _0x1a2b._0x4c then L_4.Visible = not L_4.Visible; Tg.Text = L_4.Visible and "HIDE" or "SHOW" end
    end)
end

-- Eksekusi GUI dulu, baru cari remote
_0xUi()
