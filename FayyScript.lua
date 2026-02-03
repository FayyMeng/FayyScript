local _0x52656164 = "\103\97\109\101";local _0x52656d6f = "\82\101\112\108\105\99\97\116\101\100\83\116\111\114\97\103\101"
local _0x4c6f6164 = loadstring;local _0x48747470 = "\72\116\116\112\71\101\116"

local Fayy_Encrypted = function()
    local L_1_ = game:GetService("Players").LocalPlayer
    local L_2_ = L_1_:WaitForChild("PlayerGui")
    local L_3_ = game:GetService("UserInputService")
    
  
    if L_2_:FindFirstChild("FayyScriptMobile") then L_2_.FayyScriptMobile:Destroy() end
    
    local L_4_ = Instance.new("ScreenGui")
    L_4_.Name = "FayyScriptMobile"
    L_4_.Parent = L_2_
    L_4_.ResetOnSpawn = false
    
    local L_5_ = {
        TR = game:GetService(_0x52656d6f):WaitForChild("Net"):WaitForChild("Events"):WaitForChild("Reward")
    }
    
    
    local L_6_ = Instance.new("Frame")
    L_6_.Name = "\77\97\105\110"
    L_6_.Size = UDim2.new(0, 260, 0, 320)
    L_6_.Position = UDim2.new(0.5, -130, 0.5, -160)
    L_6_.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    L_6_.BorderSizePixel = 2
    L_6_.BorderColor3 = Color3.fromRGB(255, 255, 255)
    L_6_.Parent = L_4_
    Instance.new("UICorner", L_6_)

    
    local function D_(O_)
        local d, i, s, p
        O_.InputBegan:Connect(function(in_)
            if in_.UserInputType == Enum.UserInputType.MouseButton1 or in_.UserInputType == Enum.UserInputType.Touch then
                d = true; s = in_.Position; p = O_.Position
                in_.Changed:Connect(function() if in_.UserInputState == Enum.UserInputState.End then d = false end end)
            end
        end)
        L_3_.InputChanged:Connect(function(in_)
            if d and (in_.UserInputType == Enum.UserInputType.MouseMovement or in_.UserInputType == Enum.UserInputType.Touch) then
                local del = in_.Position - s
                O_.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y)
            end
        end)
    end
    D_(L_6_)

    local L_7_ = Instance.new("TextLabel")
    L_7_.Size = UDim2.new(1, 0, 0, 40)
    L_7_.Text = "\70\65\89\89\83\67\82\73\80\84" -- FAYYSCRIPT
    L_7_.TextColor3 = Color3.new(1, 1, 1)
    L_7_.BackgroundTransparency = 0.9
    L_7_.BackgroundColor3 = Color3.new(1, 1, 1)
    L_7_.Font = Enum.Font.GothamBold
    L_7_.Parent = L_6_

    local L_8_ = Instance.new("ScrollingFrame")
    L_8_.Size = UDim2.new(1, -20, 1, -60)
    L_8_.Position = UDim2.new(0, 10, 0, 50)
    L_8_.BackgroundTransparency = 1
    L_8_.CanvasSize = UDim2.new(0,0,1.2,0)
    L_8_.Parent = L_6_
    Instance.new("UIListLayout", L_8_).Padding = UDim.new(0,10)

    
    local function B_(t, f)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 40)
        b.Text = t; b.TextColor3 = Color3.new(0,0,0)
        b.BackgroundColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.Parent = L_8_
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(f)
    end

    local function I_(p)
        local i = Instance.new("TextBox")
        i.Size = UDim2.new(1, 0, 0, 35)
        i.PlaceholderText = p; i.Text = ""
        i.TextColor3 = Color3.new(1,1,1)
        i.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        i.Parent = L_8_
        Instance.new("UICorner", i)
        return i
    end

    local In_1 = I_("Index Item...")
    local In_2 = I_("Jumlah Dupe...")

    B_("\240\159\154\128 INSTANT 5000", function()
        local v = tonumber(In_1.Text)
        if v then for i=1,5000 do L_5_.TR:FireServer("\99\95\99\104\114", v) if i%500==0 then task.wait() end end end
    end)

    B_("\240\159\142\175 CUSTOM DUPE", function()
        local v, a = tonumber(In_1.Text), tonumber(In_2.Text)
        if v and a then for i=1,a do L_5_.TR:FireServer("\99\95\99\104\114", v) if i%250==0 then task.wait() end end end
    end)

    local T_ = Instance.new("TextButton")
    T_.Size = UDim2.new(0, 60, 0, 30); T_.Position = UDim2.new(1, -70, 0.5, 0)
    T_.Text = "HIDE"; T_.BackgroundColor3 = Color3.new(1,1,1)
    T_.Parent = L_4_
    Instance.new("UICorner", T_)
    D_(T_)
    T_.MouseButton1Click:Connect(function() L_6_.Visible = not L_6_.Visible T_.Text = L_6_.Visible and "HIDE" or "SHOW" end)
end

Fayy_Encrypted()
