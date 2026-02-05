local _0xRoot = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [ SERVICES ]
local _0xP = game:GetService("Players")
local _0xRS = game:GetService("RunService")
local _0xTS = game:GetService("TweenService")
local _0xVIM = game:GetService("VirtualInputManager")
local _0xST = game:GetService("ReplicatedStorage")
local _0xNT = _0xST:WaitForChild("Net")

local _0xL = _0xP.LocalPlayer
local _0xC = _0xL.Character or _0xL.CharacterAdded:Wait()
local _0xH = _0xC:WaitForChild("HumanoidRootPart")

_0xP.LocalPlayer.CharacterAdded:Connect(function(nc)
    _0xC = nc
    _0xH = nc:WaitForChild("HumanoidRootPart")
end)

-- [ CONFIGURATION ]
local _0xCFG = {
    IV = "", CA = 0, FS = false, FMode = "Teleport", TS = 150,
    S1 = false, S2 = false, BN = "", MN = "", D = 5, H = 2, NC = true
}

-- [ REMOTES ]
local _0xEF = workspace:WaitForChild("Enemies")
local _0xRR = _0xST:FindFirstChild("Reward", true) or (_0xNT:FindFirstChild("Events") and _0xNT.Events:FindFirstChild("Reward"))
local _0xWR = _0xST:WaitForChild("Shared"):WaitForChild("Remotes"):WaitForChild("SetCurrentWorld")

-- [ LOGIC FUNCTIONS ]
local function _0xJump(wn, cf)
    if _0xH then
        _0xH.CFrame = cf
        task.wait(0.2)
        _0xWR:FireServer(wn)
        _0xRoot:Notify({Title = "Teleport", Content = "Traveling to " .. wn, Duration = 2})
    end
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

local function _0xTarget()
    local b, m, md = nil, nil, math.huge
    for _, e in pairs(_0xEF:GetChildren()) do
        local r = e:FindFirstChild("HumanoidRootPart")
        local h = e:FindFirstChildOfClass("Humanoid")
        if r and (not h or h.Health > 0) then
            if _0xCFG.BN ~= "" and e.Name == _0xCFG.BN then b = e; break 
            elseif _0xCFG.MN ~= "" and e.Name == _0xCFG.MN then
                local d = (_0xH.Position - r.Position).Magnitude
                if d < md then md = d; m = e end
            end
        end
    end
    return b or m
end

-- [ UI INITIALIZATION ]
local W = _0xRoot:CreateWindow({Name = "FayyScript", LoadingTitle = "FayyScript Systems", ConfigurationSaving = {Enabled = false}})

-- AUTO FARM TAB
local T1 = W:CreateTab("👾 Auto Farm", "swords")
T1:CreateSection("Target Selection")
local B_Drop = T1:CreateDropdown({Name = "Select Boss", Options = _0xGetE(true), CurrentOption = {"None"}, Callback = function(o) _0xCFG.BN = o[1] == "None" and "" or o[1] end})
local M_Drop = T1:CreateDropdown({Name = "Select Mob", Options = _0xGetE(false), CurrentOption = {"None"}, Callback = function(o) _0xCFG.MN = o[1] == "None" and "" or o[1] end})
T1:CreateButton({Name = "🔄 Refresh Lists", Callback = function() B_Drop:Refresh(_0xGetE(true)) M_Drop:Refresh(_0xGetE(false)) end})
T1:CreateSection("Farm Control")
T1:CreateToggle({Name = "ENABLE AUTO-FARM", CurrentValue = false, Callback = function(v) _0xCFG.FS = v end})
T1:CreateToggle({Name = "Auto Skill 1", CurrentValue = false, Callback = function(v) _0xCFG.S1 = v end})
T1:CreateToggle({Name = "Auto Skill 2", CurrentValue = false, Callback = function(v) _0xCFG.S2 = v end})

-- TELEPORT TAB
local T2 = W:CreateTab("🌍 Teleport", "map")
T2:CreateSection("World Navigation")
T2:CreateButton({Name = "🌌 Teleport to World 2", Callback = function() _0xJump("World2", CFrame.new(-359.734, -78.698, 266.681, 0.877, 0, 0.480, 0, 1, 0, -0.480, 0, 0.877)) end})
T2:CreateButton({Name = "🌳 Back to World 1", Callback = function() _0xJump("World1", CFrame.new(-6106.934, -74.759, 370.924, -0.057, 0, 0.998, 0, 1, 0, -0.998, 0, -0.057)) end})
T2:CreateButton({Name = "❄️ Teleport to World 3", Callback = function() _0xJump("World3", CFrame.new(-365.156, -77.785, 243.321, 0.999, 0, -0.022, 0, 1, 0, 0.022, 0, 0.999)) end})

-- FORGE TAB (MAINTENANCE)
local T3 = W:CreateTab("⚒️ Forge", "hammer")
T3:CreateSection("⚠️ System Maintenance")
T3:CreateLabel("The Auto Forge feature is currently bugged.")
T3:CreateLabel("As the developer of this script, I am working hard to fix it.")
T3:CreateLabel("Please be patient and enjoy the other available features.")
T3:CreateSection("Status: Under Repair")

-- DUPE TAB
local T4 = W:CreateTab("💰 Dupe", "coins")
T4:CreateSection("📖 Dupe Instructions")
T4:CreateLabel("Slot 1 = Index 2, Slot 2 = Index 3, etc.")
T4:CreateInput({Name = "Item Index", PlaceholderText = "e.g., 2", Callback = function(v) _0xCFG.IV = v end})
T4:CreateButton({Name = "🚀 Instant Dupe (5000x)", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xRR then 
        for i=1,10 do task.spawn(function() for j=1,500 do _0xRR:FireServer("c_chr", idx) end end) end 
        _0xRoot:Notify({Title = "Success", Content = "5000x Requests Sent", Duration = 2})
    end
end})
T4:CreateSection("🎯 Custom Dupe Amount")
T4:CreateInput({Name = "Amount", PlaceholderText = "Enter amount...", Callback = function(v) _0xCFG.CA = tonumber(v) or 0 end})
T4:CreateButton({Name = "🎯 RUN CUSTOM DUPE", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    if idx and _0xCFG.CA > 0 and _0xRR then 
        local pt = math.ceil(_0xCFG.CA/10)
        for i=1,10 do task.spawn(function() for j=1,pt do _0xRR:FireServer("c_chr", idx) end end) end 
        _0xRoot:Notify({Title = "Success", Content = "Custom Dupe Started", Duration = 2})
    end
end})

-- UTILS TAB
local T5 = W:CreateTab("⚙️ Utils", "settings")
T5:CreateSlider({Name = "WalkSpeed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(v) if _0xC:FindFirstChild("Humanoid") then _0xC.Humanoid.WalkSpeed = v end end})
T5:CreateToggle({Name = "🧱 Noclip", CurrentValue = true, Callback = function(v) _0xCFG.NC = v end})

-- [ CORE LOOPS ]
task.spawn(function()
    while true do
        if _0xCFG.FS and _0xTarget() then
            if _0xCFG.S1 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
            if _0xCFG.S2 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
        end
        task.wait(0.2)
    end
end)

_0xRS.Heartbeat:Connect(function()
    if _0xCFG.FS and _0xH and _0xH.Parent then
        local t = _0xTarget()
        if t and t:FindFirstChild("HumanoidRootPart") then
            local tr = t.HumanoidRootPart
            local tp = (tr.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)).Position
            _0xH.CFrame = CFrame.lookAt(tp, tr.Position)
        end
    end
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)
        local t = _0xTarget()
        if t and t:FindFirstChild("HumanoidRootPart") then
            local tr = t.HumanoidRootPart
            local tp = (tr.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)).Position
            _0xH.CFrame = CFrame.lookAt(tp, tr.Position)
        end
    end
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)
        for i=1,10 do task.spawn(function() for j=1,pt do _0xRR:FireServer("c_chr", idx) end end) end 
        _0xRoot:Notify({Title = "Success", Content = "Custom Dupe Started", Duration = 2})
    end
end})

-- UTILS TAB
local T5 = W:CreateTab("⚙️ Utils", "settings")
T5:CreateSlider({Name = "WalkSpeed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(v) if _0xC:FindFirstChild("Humanoid") then _0xC.Humanoid.WalkSpeed = v end end})
T5:CreateToggle({Name = "🧱 Noclip", CurrentValue = true, Callback = function(v) _0xCFG.NC = v end})

-- [ CORE LOOPS ]
task.spawn(function()
    while true do
        if _0xCFG.FS and _0xTarget() then
            if _0xCFG.S1 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
            if _0xCFG.S2 then _0xVIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
        end
        task.wait(0.2)
    end
end)

_0xRS.Heartbeat:Connect(function()
    if _0xCFG.FS and _0xH and _0xH.Parent then
        local t = _0xTarget()
        if t and t:FindFirstChild("HumanoidRootPart") then
            local tr = t.HumanoidRootPart
            local tp = (tr.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)).Position
            _0xH.CFrame = CFrame.lookAt(tp, tr.Position)
        end
    end
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

-- [ REMOTE SPY HOOK ]
local old; old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    if _0xCFG.SM and (self == _0xNF or self == _0xMF) then
        if args[1] then 
            _0xCFG.ID = args[1] 
            ID_Label:Set("Captured: ".._0xCFG.ID) 
        end
    end
    return old(self, ...)
end))
