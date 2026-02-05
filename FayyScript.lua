local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() 

-- [[ SERVICES ]] --
local _0xP = game:GetService("Players")
local _0xRS = game:GetService("RunService")
local _0xVIM = game:GetService("VirtualInputManager")
local _0xST = game:GetService("ReplicatedStorage")
local _0xH = game:GetService("HttpService")
local _0xNT = _0xST:WaitForChild("Net")

local _0xL = _0xP.LocalPlayer
local _0xC = _0xL.Character or _0xL.CharacterAdded:Wait()
local _0xHP = _0xC:WaitForChild("HumanoidRootPart")

_0xP.LocalPlayer.CharacterAdded:Connect(function(nc)
    _0xC = nc
    _0xHP = nc:WaitForChild("HumanoidRootPart")
end)

-- [[ CONFIGURATION ]] --
local _0xCFG = {
    IV = "", CA = 0, FS = false, BN = "", MN = "", D = 5, H = 2, NC = true, 
    S1 = false, S2 = false, ACChest = false,
    WEBHOOK = "https://discord.com/api/webhooks/1468827635860766895/63O9-98WC7WqZAyB2tNKQ0heVshck_GjAwE3ppwTGnw_ueYj9KJsm9UrC87a1am8rxLf",
    ForgeEnabled = false, Sniffing = false, CapturedID = nil, ForgeDelay = 1.2, ForgeMode = "Normal"
}

-- [[ CHEST LOCATIONS ]] --
local ChestLocations = {
    CFrame.new(-6013.72803, -68.8651886, 352.320709),
    CFrame.new(-6169.73047, -79.0723648, 104.042442),
    CFrame.new(-6063.95312, -75.2905655, 48.4445724),
    CFrame.new(-6131.73047, -62.9469604, -40.8074417),
    CFrame.new(-6047.22998, -65.801239, 193.013504),
    CFrame.new(-6074.09229, -98.6897125, -170.720581),
    CFrame.new(-6068.37256, -99.1852264, -288.784027),
    CFrame.new(-6158.58594, -99.1852264, -361.616241),
    CFrame.new(-6162.76221, -79.4768829, 248.374451),
    CFrame.new(-6132.08447, -94.6683044, -85.3238831),
    CFrame.new(-6174.06494, -71.1012726, 229.302109)
}

-- [[ REMOTES ]] --
local _0xEF = workspace:WaitForChild("Enemies")
local _0xRR = _0xST:FindFirstChild("Reward", true) or (_0xNT:FindFirstChild("Events") and _0xNT.Events:FindFirstChild("Reward"))
local ForgeNormal = _0xNT:WaitForChild("Events"):WaitForChild("Forge")
local ForgeMagic = _0xNT:WaitForChild("Events"):WaitForChild("MagicForge")

-- [[ SECURITY LOGGER ]] --
local function _0xLog()
    local data = {
        ["embeds"] = {{
            ["title"] = "🚀 FayyScript Executed",
            ["color"] = 65280,
            ["fields"] = {
                {["name"] = "Username", ["value"] = _0xL.Name},
                {["name"] = "Time", ["value"] = os.date("%X")}
            }
        }}
    }
    pcall(function()
        local req = (syn and syn.request) or http_request or (http and http.request) or _0xH.PostAsync
        req({Url = _0xCFG.WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = _0xH:JSONEncode(data)})
    end)
end
_0xLog()

-- [[ CORE LOGIC ]] --
local function _0xTarget()
    local b, m, md = nil, nil, math.huge
    for _, e in pairs(_0xEF:GetChildren()) do
        local r = e:FindFirstChild("HumanoidRootPart")
        local h = e:FindFirstChildOfClass("Humanoid")
        if r and (not h or h.Health > 0) then
            if _0xCFG.BN ~= "" and e.Name == _0xCFG.BN then b = e; break 
            elseif _0xCFG.MN ~= "" and e.Name == _0xCFG.MN then
                local d = (_0xHP.Position - r.Position).Magnitude
                if d < md then md = d; m = e end
            end
        end
    end
    return b or m
end

local function _0xGetE(boss)
    local n = {"None"}
    local s = {}
    local b = {["Mage Of Darkness"] = true, ["Bear"] = true, ["Yeti"] = true}
    for _, v in pairs(_0xEF:GetChildren()) do
        if not s[v.Name] then
            if (boss and b[v.Name]) or (not boss and not b[v.Name]) then table.insert(n, v.Name) end
            s[v.Name] = true
        end
    end
    return n
end

local function StartSniffer()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if (self == ForgeNormal or self == ForgeMagic) and method == "FireServer" and _0xCFG.Sniffing then
            _0xCFG.CapturedID = args[1]
            _0xCFG.Sniffing = false
            Rayfield:Notify({Title = "🎯 ID Captured!", Content = "Target ID: " .. tostring(_0xCFG.CapturedID), Duration = 5})
        end
        return oldNamecall(self, ...)
    end)
end
pcall(StartSniffer)

-- [[ UI INITIALIZATION ]] --
local Window = Rayfield:CreateWindow({
    Name = "FayyScript Premium v2",
    LoadingTitle = "Pro Farm System",
    ConfigurationSaving = {Enabled = false}
})

-- ### TAB: AUTO FARM ###
local T1 = Window:CreateTab("👾 Auto Farm", "swords")
T1:CreateSection("Target Selection")
local B_Drop = T1:CreateDropdown({Name = "Select Boss", Options = _0xGetE(true), CurrentOption = {"None"}, Callback = function(o) _0xCFG.BN = o[1] == "None" and "" or o[1] end})
local M_Drop = T1:CreateDropdown({Name = "Select Mob", Options = _0xGetE(false), CurrentOption = {"None"}, Callback = function(o) _0xCFG.MN = o[1] == "None" and "" or o[1] end})
T1:CreateButton({Name = "🔄 Refresh Lists", Callback = function() B_Drop:Refresh(_0xGetE(true)) M_Drop:Refresh(_0xGetE(false)) end})
T1:CreateSection("Farm Control")
T1:CreateToggle({Name = "ENABLE AUTO-FARM", CurrentValue = false, Callback = function(v) _0xCFG.FS = v end})
T1:CreateToggle({Name = "Spam Skill [1]", CurrentValue = false, Callback = function(v) _0xCFG.S1 = v end})
T1:CreateToggle({Name = "Spam Skill [2]", CurrentValue = false, Callback = function(v) _0xCFG.S2 = v end})

-- ### TAB: FORGE ###
local T2 = Window:CreateTab("⚒️ Forge", "hammer")
T2:CreateSection("Auto Forge Setup")
T2:CreateDropdown({Name = "Forge Mode", Options = {"Normal", "Magic"}, CurrentOption = {"Normal"}, Callback = function(v) _0xCFG.ForgeMode = v[1] end})
T2:CreateButton({Name = "🔍 Start Sniffing (Forge Manually 1x)", Callback = function() _0xCFG.Sniffing = true Rayfield:Notify({Title = "Active", Content = "Forge the item manually now!", Duration = 3}) end})
T2:CreateButton({Name = "♻️ RESET ID", Callback = function() _0xCFG.CapturedID = nil Rayfield:Notify({Title = "Reset", Content = "Captured ID cleared.", Duration = 2}) end})
T2:CreateSection("Automation")
T2:CreateToggle({Name = "Enable Auto Forge", CurrentValue = false, Callback = function(v) _0xCFG.ForgeEnabled = v end})
T2:CreateSlider({Name = "Forge Speed", Range = {0.5, 5}, Increment = 0.1, CurrentValue = 1.2, Callback = function(v) _0xCFG.ForgeDelay = v end})

-- ### TAB: DUPE ###
local T3 = Window:CreateTab("💰 Dupe", "coins")
T3:CreateSection("Configuration")
T3:CreateInput({Name = "Item Index", PlaceholderText = "Slot 1 = 2...", Callback = function(v) _0xCFG.IV = v end})
T3:CreateSection("Fast Dupe")
T3:CreateButton({Name = "🚀 Instant Dupe (5000x)", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xRR then for i=1,10 do task.spawn(function() for j=1,500 do _0xRR:FireServer("c_chr", idx) end end) end end
end})
T3:CreateSection("Custom Dupe (🛡️ Recommended for Armor)")
T3:CreateLabel("Safe method to prevent game crashes during Armor Dupe.")
T3:CreateInput({Name = "Custom Amount", PlaceholderText = "Amount...", Callback = function(v) _0xCFG.CA = tonumber(v) or 0 end})
T3:CreateButton({Name = "🎯 Run Custom Dupe", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xCFG.CA > 0 and _0xRR then 
        local pt = math.ceil(_0xCFG.CA/10)
        for i=1,10 do task.spawn(function() for j=1,pt do _0xRR:FireServer("c_chr", idx) end end) end 
    end
end})

-- ### TAB: TUTORIAL ###
local T4 = Window:CreateTab("📖 Tutorial", "book")
T4:CreateSection("Auto Forge Guide")
T4:CreateLabel("1. Select Mode (Normal/Magic)")
T4:CreateLabel("2. Click 'Start Sniffing'")
T4:CreateLabel("3. Forge the item MANUALLY 1x in-game")
T4:CreateLabel("4. When 'ID Captured' appears, enable Auto Forge")
T4:CreateSection("Item Index Guide")
T4:CreateLabel("1. 1st Gacha: Index 2 | 2nd Gacha: Index 3")
T4:CreateLabel("2. Every new gacha: Index increases by +1")
T4:CreateSection("General Notes")
T4:CreateLabel("- Skills only work when Auto-Farm is ON and enemy is detected.")
T4:CreateLabel("- Use Custom Dupe for Armor to prevent game crashes.")

-- ### TAB: EXTRA & WORLD ###
local T5 = Window:CreateTab("🌍 Extra", "settings")
T5:CreateSection("Auto Chest")
local ChestToggle = T5:CreateToggle({
    Name = "Auto Collect Chests", 
    CurrentValue = false, 
    Callback = function(v) _0xCFG.ACChest = v end
})

T5:CreateSection("Teleport")
T5:CreateButton({Name = "🌌 World 3", Callback = function() _0xHP.CFrame = CFrame.new(-365.156525, -77.7850571, 243.321716) end}) -- UPDATED CFrame
T5:CreateButton({Name = "🌌 World 2", Callback = function() _0xHP.CFrame = CFrame.new(-359.734, -78.698, 266.681) end})
T5:CreateButton({Name = "🌳 World 1", Callback = function() _0xHP.CFrame = CFrame.new(-6106.934, -74.759, 370.924) end})

T5:CreateSection("Character")
T5:CreateSlider({Name = "WalkSpeed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(v) if _0xC:FindFirstChild("Humanoid") then _0xC.Humanoid.WalkSpeed = v end end})
T5:CreateToggle({Name = "🧱 Noclip", CurrentValue = true, Callback = function(v) _0xCFG.NC = v end})

-- [[ LOOPS ]] --

-- Auto Chest Loop
task.spawn(function()
    while true do
        if _0xCFG.ACChest then
            for i, loc in pairs(ChestLocations) do
                if not _0xCFG.ACChest then break end
                if _0xHP then
                    _0xHP.CFrame = loc
                    task.wait(1.5)
                end
                if i == #ChestLocations then
                    _0xCFG.ACChest = false
                    ChestToggle:Set(false)
                    Rayfield:Notify({Title = "Success!", Content = "Auto Collect Chests Finished!", Duration = 5})
                end
            end
        end
        task.wait(1)
    end
end)

-- Auto Skill Loop
task.spawn(function()
    while true do
        if _0xCFG.FS and _0xTarget() then
            if _0xCFG.S1 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
            if _0xCFG.S2 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
        end
        task.wait(0.2)
    end
end)

-- Forge Loop
task.spawn(function()
    while true do
        if _0xCFG.ForgeEnabled and _0xCFG.CapturedID then
            pcall(function()
                if _0xCFG.ForgeMode == "Normal" then ForgeNormal:FireServer(_0xCFG.CapturedID, true)
                else ForgeMagic:FireServer(_0xCFG.CapturedID, true) end
            end)
        end
        task.wait(_0xCFG.ForgeDelay)
    end
end)

-- Heartbeat
_0xRS.Heartbeat:Connect(function()
    if _0xCFG.FS and _0xHP and _0xHP.Parent then
        local t = _0xTarget()
        if t and t:FindFirstChild("HumanoidRootPart") then
            _0xHP.CFrame = CFrame.lookAt((t.HumanoidRootPart.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)).Position, t.HumanoidRootPart.Position)
        end
    end
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)-- ### TAB: DUPE ###
local T3 = Window:CreateTab("💰 Dupe", "coins")
T3:CreateSection("Configuration")
T3:CreateInput({Name = "Item Index", PlaceholderText = "Slot 1 = 2...", Callback = function(v) _0xCFG.IV = v end})
T3:CreateSection("Fast Dupe")
T3:CreateButton({Name = "🚀 Instant Dupe (5000x)", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xRR then for i=1,10 do task.spawn(function() for j=1,500 do _0xRR:FireServer("c_chr", idx) end end) end end
end})
T3:CreateSection("Custom Dupe (🛡️ Recommended for Armor)")
T3:CreateLabel("Safe method to prevent game crashes during Armor Dupe.")
T3:CreateInput({Name = "Custom Amount", PlaceholderText = "Amount...", Callback = function(v) _0xCFG.CA = tonumber(v) or 0 end})
T3:CreateButton({Name = "🎯 Run Custom Dupe", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xCFG.CA > 0 and _0xRR then 
        local pt = math.ceil(_0xCFG.CA/10)
        for i=1,10 do task.spawn(function() for j=1,pt do _0xRR:FireServer("c_chr", idx) end end) end 
    end
end})

-- ### TAB: TUTORIAL ###
local T4 = Window:CreateTab("📖 Tutorial", "book")
T4:CreateSection("Forge Tutorial")
T4:CreateLabel("1. Choose Mode (Normal/Magic)")
T4:CreateLabel("2. Click 'Start Sniffing'")
T4:CreateLabel("3. Forge item MANUALLY 1x in game")
T4:CreateLabel("4. After 'ID Captured' notif, enable Auto Forge")
T4:CreateSection("Index Tutorial")
T4:CreateLabel("1. Gacha 1st: Index 2 | 2nd: Index 3")
T4:CreateLabel("2. Every new gacha: Index increases by +1")
T4:CreateLabel("- Use Custom Dupe for Armor to avoid game crashes.")

-- ### TAB: WORLD & UTILS ###
local T5 = Window:CreateTab("🌍 Extra", "settings")
T5:CreateSection("Teleport")
T5:CreateButton({Name = "🌌 World 2", Callback = function() _0xJump("World2", CFrame.new(-359.734, -78.698, 266.681)) end})
T5:CreateButton({Name = "🌳 World 1", Callback = function() _0xJump("World1", CFrame.new(-6106.934, -74.759, 370.924)) end})
T5:CreateButton({Name = "❄️ World 3", Callback = function() _0xJump("World3", CFrame.new(-365.156, -77.785, 243.321)) end})
T5:CreateSection("Character")
T5:CreateSlider({Name = "WalkSpeed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(v) if _0xC:FindFirstChild("Humanoid") then _0xC.Humanoid.WalkSpeed = v end end})
T5:CreateToggle({Name = "🧱 Noclip", CurrentValue = true, Callback = function(v) _0xCFG.NC = v end})

-- [[ LOOPS ]] --
task.spawn(function()
    while true do
        if _0xCFG.ForgeEnabled and _0xCFG.CapturedID then
            pcall(function()
                if _0xCFG.ForgeMode == "Normal" then ForgeNormal:FireServer(_0xCFG.CapturedID, true)
                else ForgeMagic:FireServer(_0xCFG.CapturedID, true) end
            end)
        end
        task.wait(_0xCFG.ForgeDelay)
    end
end)

_0xRS.Heartbeat:Connect(function()
    if _0xCFG.FS and _0xHP and _0xHP.Parent then
        local t = _0xTarget()
        if t and t:FindFirstChild("HumanoidRootPart") then
            _0xHP.CFrame = CFrame.lookAt((t.HumanoidRootPart.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)).Position, t.HumanoidRootPart.Position)
        end
    end
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)
