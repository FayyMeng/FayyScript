local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() 

-- [ SERVICES ]
local _0xP = game:GetService("Players")
local _0xRS = game:GetService("RunService")
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
    IV = "", CA = 0, FS = false, BN = "", MN = "", D = 5, H = 2, NC = true, S1 = false, S2 = false
}

-- [ REMOTES ]
local _0xEF = workspace:WaitForChild("Enemies")
local _0xRR = _0xST:FindFirstChild("Reward", true) or (_0xNT:FindFirstChild("Events") and _0xNT.Events:FindFirstChild("Reward"))
local _0xWR = _0xST:WaitForChild("Shared"):WaitForChild("Remotes"):WaitForChild("SetCurrentWorld")

-- [ LOGIC FUNCTIONS ]
local function _0xJump(wn, cf)
    if _0xH then
        _0xH.CFrame = cf
        task.wait(0.3)
        if _0xWR then 
            _0xWR:FireServer(wn) 
        end
        Rayfield:Notify({Title = "Teleport Success", Content = "Arrived at " .. wn, Duration = 2})
    end
end

-- [ UI INITIALIZATION ]
local Window = Rayfield:CreateWindow({
    Name = "FayyScript v2",
    LoadingTitle = "FayyScript Systems",
    ConfigurationSaving = {Enabled = false}
})

-- TAB: TELEPORT (FULL CFRAME RESTORED)
local T2 = Window:CreateTab("🌍 Teleport", "map")
T2:CreateSection("World Navigation")

T2:CreateButton({
    Name = "🌌 Teleport to World 2", 
    Callback = function() 
        -- Koordinat lengkap dengan data rotasi agar tidak hilang
        _0xJump("World2", CFrame.new(-359.734, -78.698, 266.681, 0.877, 0, 0.480, 0, 1, 0, -0.480, 0, 0.877)) 
    end
})

T2:CreateButton({
    Name = "🌳 Back to World 1", 
    Callback = function() 
        _0xJump("World1", CFrame.new(-6106.934, -74.759, 370.924, -0.057, 0, 0.998, 0, 1, 0, -0.998, 0, -0.057)) 
    end
})

T2:CreateButton({
    Name = "❄️ Teleport to World 3", 
    Callback = function() 
        _0xJump("World3", CFrame.new(-365.156, -77.785, 243.321, 0.999, 0, -0.022, 0, 1, 0, 0.022, 0, 0.999)) 
    end
})

-- (Sisa fitur Farm, Dupe, dan Utils tetap aman di bawah sini sesuai kode sebelumnya)
