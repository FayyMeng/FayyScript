local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "FAYYSCRIPT | VERSION 1.2",
   Icon = 0,
   LoadingTitle = "FAYYSCRIPT SYSTEMS",
   LoadingSubtitle = "Stable Forge & Dupe Performance",
   ConfigurationSaving = { Enabled = false }
})

-- [ DATA & REMOTE SERVICES ]
local RS = game:GetService("ReplicatedStorage")
local Net = RS:WaitForChild("Net")
local NormalForge = Net:WaitForChild("Events"):WaitForChild("Forge")
local MagicForge = Net:WaitForChild("Events"):WaitForChild("MagicForge")
local GetExists = Net:WaitForChild("Functions"):WaitForChild("GetExists")
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
-- UNIFIED REMOTE SPY
-- ==========================================
local function StartSpy()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if CaptureMode and (self == NormalForge or self == MagicForge or self == GetExists) then
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
-- TAB: ⚒️ SMART FORGE
-- ==========================================
local ForgeTab = Window:CreateTab("⚒️ Forge", 4483362458)

ForgeTab:CreateSection("📖 Forge Tutorial (Weapon & Armor)")
ForgeTab:CreateLabel("Step 1: Turn ON 'Enable ID Scanner'")
ForgeTab:CreateLabel("Step 2: Forge the item you want to upgrade ONCE")
ForgeTab:CreateLabel("Step 3: Turn OFF 'Enable ID Scanner' (ID is now locked)")
ForgeTab:CreateLabel("Step 4: Use 'Reset ID' if you want to forge a different item")

ForgeTab:CreateSection("ID Configuration")

ForgeTab:CreateToggle({
   Name = "🔍 Enable ID Scanner",
   CurrentValue = false,
   Callback = function(Value) CaptureMode = Value end,
})

local IdLabel = ForgeTab:CreateLabel("Current ID: None")

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
                Rayfield:Notify({Title = "Error", Content = "No ID captured!", Duration = 2})
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
            IdLabel:Set("Processing ID: " .. SelectedItemID)
         end
      end)
   end,
})

ForgeTab:CreateButton({
   Name = "🗑️ Reset ID",
   Callback = function() 
      SelectedItemID = "" 
      IdLabel:Set("Current ID: None") 
      Rayfield:Notify({Title = "FAYYSCRIPT", Content = "ID Cleared successfully!", Duration = 2})
   end,
})

-- ==========================================
-- TAB: 💰 COMPLETE DUPE
-- ==========================================
local DupeTab = Window:CreateTab("💰 Dupe System", 4483345998)

DupeTab:CreateSection("📖 Dupe Tutorial")
DupeTab:CreateLabel("Step 1: Obtain an item from Gacha/Roll")
DupeTab:CreateLabel("Step 2: Use Index '2' for your 1st Gacha item")
DupeTab:CreateLabel("Step 3: Increase Index by +1 for every new Gacha slot")
DupeTab:CreateLabel("Step 4: Use 'Custom Amount' for specific quantity needs")

DupeTab:CreateSection("Execution")

DupeTab:CreateInput({
   Name = "Item Index ID",
   PlaceholderText = "Example: 2",
   Callback = function(Text) IndexVal = Text end,
})

DupeTab:CreateButton({
   Name = "🚀 INSTANT DUPE (5000x)",
   Callback = function()
      local idx = tonumber(IndexVal)
      if idx and RewardRemote then
         for i = 1, 10 do task.spawn(function() for j = 1, 500 do RewardRemote:FireServer("c_chr", idx) end end) end
         Rayfield:Notify({Title = "FAYYSCRIPT", Content = "5000 items successfully sent!", Duration = 3})
      end
   end,
})

DupeTab:CreateInput({
   Name = "Custom Amount",
   PlaceholderText = "Enter amount...",
   Callback = function(Text) CustomAmt = tonumber(Text) or 0 end,
})

DupeTab:CreateButton({
   Name = "🎯 RUN CUSTOM DUPE",
   Callback = function()
      local idx = tonumber(IndexVal)
      if idx and CustomAmt > 0 and RewardRemote then
         for i = 1, 10 do task.spawn(function() for j = 1, math.ceil(CustomAmt/10) do RewardRemote:FireServer("c_chr", idx) end end) end
         Rayfield:Notify({Title = "FAYYSCRIPT", Content = "Custom dupe initiated!", Duration = 3})
      end
   end,
})

-- ==========================================
-- TAB: 🏃 UTILS
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
