local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "FAYYSCRIPT",
   Icon = 0,
   LoadingTitle = "FAYYSCRIPT",
   LoadingSubtitle = "Forge, Dupe, & Utils Ready",
   ConfigurationSaving = { Enabled = false }
})

-- [ DATA & REMOTE SERVICES ]
local RS = game:GetService("ReplicatedStorage")
local Net = RS:WaitForChild("Net")
local NormalForge = Net:WaitForChild("Events"):WaitForChild("Forge")
local MagicForge = Net:WaitForChild("Events"):WaitForChild("MagicForge")
local RewardRemote = RS:FindFirstChild("Reward", true) or (Net:FindFirstChild("Events") and Net.Events:FindFirstChild("Reward"))

-- [ GLOBALS ]
local SelectedItemID = ""
local AutoForge = false
local ForgeMode = "Auto Step (+6 -> +10)"
local CaptureMode = false
local IndexVal = ""
local CustomAmt = 0
local Noclip = false

-- ==========================================
-- REMOTE SPY LOGIC
-- ==========================================
local function StartSpy()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if CaptureMode and (self == NormalForge or self == MagicForge) and (method == "FireServer" or method == "fireServer") then
            if args[1] and type(args[1]) == "string" then
                SelectedItemID = args[1]
                Rayfield:Notify({Title = "FAYYSCRIPT", Content = "ID Captured: " .. SelectedItemID, Duration = 2})
            end
        end
        return oldNamecall(self, ...)
    end))
end
pcall(StartSpy)

-- ==========================================
-- TAB 1: ⚒️ SMART FORGE
-- ==========================================
local ForgeTab = Window:CreateTab("⚒️ Forge", 4483362458)

ForgeTab:CreateSection("📖 Auto Forge Tutorial (Armor Only)")
ForgeTab:CreateLabel("1. Turn on 'Enable ID Scanner'")
ForgeTab:CreateLabel("2. Upgrade any Armor you want once")
ForgeTab:CreateLabel("3. Turn off Scanner to stop notifications")
ForgeTab:CreateLabel("4. Use 'Reset ID' if you want to upgrade other items")
ForgeTab:CreateLabel("⚠️ Note: This feature is for ARMOR ONLY (Not for Weapons)")

ForgeTab:CreateSection("ID Grabber")

ForgeTab:CreateToggle({
   Name = "🔍 Enable ID Scanner",
   CurrentValue = false,
   Callback = function(Value) CaptureMode = Value end,
})

local IdLabel = ForgeTab:CreateLabel("Current ID: Waiting for scan...")

ForgeTab:CreateDropdown({
   Name = "Forge Mode",
   Options = {"Normal Only (+6)", "Magic Only (+10)", "Auto Step (+6 -> +10)"},
   CurrentOption = "Auto Step (+6 -> +10)",
   Callback = function(Option) ForgeMode = Option end,
})

ForgeTab:CreateToggle({
   Name = "🔥 START AUTO FORGE",
   CurrentValue = false,
   Callback = function(Value)
      AutoForge = Value
      task.spawn(function()
         while AutoForge do
            if SelectedItemID == "" then 
                Rayfield:Notify({Title = "FAYYSCRIPT", Content = "ID Empty! Scan your item first.", Duration = 2})
                AutoForge = false break 
            end
            
            pcall(function()
                if ForgeMode == "Normal Only (+6)" then
                    NormalForge:FireServer(SelectedItemID, true)
                    task.wait(0.8)
                elseif ForgeMode == "Magic Only (+10)" then
                    MagicForge:FireServer(SelectedItemID, true)
                    task.wait(0.6)
                else
                    NormalForge:FireServer(SelectedItemID, true)
                    task.wait(0.4)
                    MagicForge:FireServer(SelectedItemID, true)
                    task.wait(0.4)
                end
            end)
            IdLabel:Set("Processing: " .. SelectedItemID)
         end
      end)
   end,
})

ForgeTab:CreateButton({
   Name = "🗑️ Reset ID",
   Callback = function() SelectedItemID = "" IdLabel:Set("Current ID: Empty") end,
})

-- ==========================================
-- TAB 2: 💰 COMPLETE DUPE
-- ==========================================
local DupeTab = Window:CreateTab("💰 Dupe System", 4483345998)

DupeTab:CreateSection("📖 Dupe Tutorial")
DupeTab:CreateLabel("1. Gacha/Roll any item you want")
DupeTab:CreateLabel("2. Enter the Item Index (1st Gacha = 2, 2nd = 3, etc.)")
DupeTab:CreateLabel("3. For each new gacha, index increases by +1")
DupeTab:CreateLabel("4. Recommended: Use Custom Dupe for Armor")

DupeTab:CreateSection("Dupe Execution")

DupeTab:CreateInput({
   Name = "Item Index",
   PlaceholderText = "Example: 2",
   Callback = function(Text) IndexVal = Text end,
})

DupeTab:CreateButton({
   Name = "🚀 INSTANT DUPE (5000)",
   Callback = function()
      local idx = tonumber(IndexVal)
      if idx and RewardRemote then
         for i = 1, 10 do task.spawn(function() for j = 1, 500 do RewardRemote:FireServer("c_chr", idx) end end) end
         Rayfield:Notify({Title = "FAYYSCRIPT", Content = "Sending 5000 items...", Duration = 3})
      end
   end,
})

DupeTab:CreateInput({
   Name = "Custom Amount",
   PlaceholderText = "Enter number...",
   Callback = function(Text) CustomAmt = tonumber(Text) or 0 end,
})

DupeTab:CreateButton({
   Name = "🎯 RUN CUSTOM DUPE",
   Callback = function()
      local idx = tonumber(IndexVal)
      if idx and CustomAmt > 0 and RewardRemote then
         for i = 1, 10 do task.spawn(function() for j = 1, math.ceil(CustomAmt/10) do RewardRemote:FireServer("c_chr", idx) end end) end
         Rayfield:Notify({Title = "FAYYSCRIPT", Content = "Sending "..CustomAmt.." items...", Duration = 3})
      end
   end,
})

-- ==========================================
-- TAB 3: 🏃 UTILS
-- ==========================================
local UtilsTab = Window:CreateTab("🏃 Utils", 4483362458)

UtilsTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end
   end,
})

UtilsTab:CreateToggle({
   Name = "🧱 Noclip",
   CurrentValue = false,
   Callback = function(Value)
      Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
         if Noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if v:IsA("BasePart") then v.CanCollide = false end
            end
         end
      end)
   end,
})
