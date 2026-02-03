--[[
    FAYYSCRIPT v18.7 - FINAL POSITION ADJUSTMENT
    "TOGGLE BUTTON MOVED TO RIGHT + DRAGGABLE + STABLE"
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")

if PlayerGui:FindFirstChild("FayyScriptMobile") then PlayerGui.FayyScriptMobile:Destroy() end

local TargetRemote = nil
task.spawn(function()
    TargetRemote = RS:FindFirstChild("Reward", true) or (RS:FindFirstChild("Net") and RS.Net:FindFirstChild("Events") and RS.Net.Events:FindFirstChild("Reward"))
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FayyScriptMobile"; ScreenGui.Parent = PlayerGui; ScreenGui.ResetOnSpawn = false

-- FUNGSI DRAG
local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 280, 0, 410)
Main.Position = UDim2.new(0.5, -140, 0.5, -205)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.new(1, 1, 1)
Main.Parent = ScreenGui; Instance.new("UICorner", Main)
MakeDraggable(Main)

-- TITLE
local Ttl = Instance.new("TextLabel")
Ttl.Size = UDim2.new(1, 0, 0, 40); Ttl.Text = "FAYYSCRIPT v18.7"; Ttl.TextColor3 = Color3.new(1, 1, 1)
Ttl.Font = Enum.Font.GothamBold; Ttl.BackgroundTransparency = 0.9; Ttl.BackgroundColor3 = Color3.new(1, 1, 1); Ttl.Parent = Main

-- SCROLL CONTAINER
local Scr = Instance.new("ScrollingFrame")
Scr.Size = UDim2.new(1, -20, 1, -60); Scr.Position = UDim2.new(0, 10, 0, 50); Scr.BackgroundTransparency = 1; Scr.Parent = Main
local List = Instance.new("UIListLayout", Scr); List.Padding = UDim.new(0, 10)

-- TUTORIAL BOX
local Tut = Instance.new("TextLabel")
Tut.Size = UDim2.new(1, 0, 0, 110); Tut.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Tut.TextColor3 = Color3.fromRGB(200, 200, 200); Tut.TextSize = 12; Tut.TextWrapped = true; Tut.Font = Enum.Font.Gotham; Tut.Parent = Scr
Tut.Text = " 📜 DUPE TUTORIAL:\n 1. Roll/Gacha in-game first.\n 2. Enter index in Field 1.\n    (1st Roll = 2nd index, etc)\n 3. Enter amount in Field 2\n    (only for Custom Dupe).\n 4. Click the Dupe button!"
Instance.new("UICorner", Tut)

-- INPUTS
local function Ci(p)
    local b = Instance.new("TextBox")
    b.Size = UDim2.new(1, 0, 0, 35); b.PlaceholderText = p; b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.Parent = Scr; Instance.new("UICorner", b); return b
end
local I1 = Ci("Field 1: Index (Ex: 2)"); local I2 = Ci("Field 2: Amount (Custom)")

-- BUTTONS
local function Cb(t, c)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 40); b.Text = t; b.BackgroundColor3 = Color3.new(1, 1, 1)
    b.TextColor3 = Color3.new(0, 0, 0); b.Font = Enum.Font.GothamBold; b.Parent = Scr; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(c)
end

local function X(a)
    local v = tonumber(I1.Text)
    if v and TargetRemote then
        for i = 1, 10 do task.spawn(function() for j = 1, math.ceil(a/10) do TargetRemote:FireServer("c_chr", v) end end) end
    end
end

Cb("🚀 INSTANT 5000", function() X(5000) end)
Cb("🎯 CUSTOM DUPE", function() local a = tonumber(I2.Text) if a then X(a) end end)

-- TOGGLE BUTTON (MOVED TO RIGHT)
local Tg = Instance.new("TextButton")
Tg.Size = UDim2.new(0, 70, 0, 35)
Tg.Position = UDim2.new(1, -80, 0.5, 0) -- POSISI KANAN
Tg.Text = "HIDE"
Tg.BackgroundColor3 = Color3.new(1, 1, 1)
Tg.TextColor3 = Color3.new(0, 0, 0)
Tg.Font = Enum.Font.GothamBold
Tg.Parent = ScreenGui
Instance.new("UICorner", Tg)

MakeDraggable(Tg)

Tg.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    Tg.Text = Main.Visible and "HIDE" or "SHOW"
end)
