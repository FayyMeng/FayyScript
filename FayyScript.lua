--[[
    FAYYSCRIPT v23.0 - MINIMALIST EDITION
    "BACK TO BASICS: DUPE, NOCLIP & SPEED"
    Loader: loadstring(game:HttpGet("https://raw.githubusercontent.com/FayyMeng/FayyScript/refs/heads/main/FayyScript.lua"))()
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "FAYYSCRIPT v23.0 | Minimalist",
   Icon = 0,
   LoadingTitle = "FayyScript Mobile",
   LoadingSubtitle = "by FayyMeng",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "FayyScriptConfigs",
      FileName = "MainConfig"
   },
   KeySystem = false
})

-- [VARIABLES]
local RS = game:GetService("ReplicatedStorage")
local TargetRemote = nil
local IndexVal = ""
local AmountVal = 0
local Noclip = false
local NoclipConn = nil

-- [REMOTE SCANNER]
task.spawn(function()
    TargetRemote = RS:FindFirstChild("Reward", true) or (RS:FindFirstChild("Net") and RS.Net:FindFirstChild("Events") and RS.Net.Events:FindFirstChild("Reward"))
end)

-- [FUNCTION DUPE]
local function ExecuteDupe(amt)
    local idx = tonumber(IndexVal)
    if idx and TargetRemote then
        Rayfield:Notify({Title = "Execution", Content = "Processing " .. amt .. " items...", Duration = 3})
        for i = 1, 10 do
            task.spawn(function()
                for j = 1, math.ceil(amt/10) do
                    TargetRemote:FireServer("c_chr", idx)
                end
            end)
        end
    else
        Rayfield:Notify({Title = "Error", Content = "Fill Index first or Remote not found!", Duration = 5})
    end
end

-- ==========================================
-- TAB: MAIN FEATURES
-- ==========================================
local MainTab = Window:CreateTab("🏠 Main", 4483362458) 

MainTab:CreateSection("Dupe Settings")

MainTab:CreateInput({
   Name = "Item Index",
   PlaceholderText = "Example: 2",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      IndexVal = Text
   end,
})

MainTab:CreateButton({
   Name = "🚀 INSTANT DUPE (5000)",
   Callback = function()
      ExecuteDupe(5000)
   end,
})

MainTab:CreateInput({
   Name = "Custom Amount",
   PlaceholderText = "Enter amount here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      AmountVal = tonumber(Text) or 0
   end,
})

MainTab:CreateButton({
   Name = "🎯 START CUSTOM DUPE",
   Callback = function()
      if AmountVal > 0 then
         ExecuteDupe(AmountVal)
      else
         Rayfield:Notify({Title = "Error", Content = "Enter a valid amount!", Duration = 5})
      end
   end,
})

MainTab:CreateSection("Character Utility")

MainTab:CreateToggle({
   Name = "🧱 Noclip",
   CurrentValue = false,
   Flag = "NoclipFlag",
   Callback = function(Value)
      Noclip = Value
      if Noclip then
         NoclipConn = game:GetService("RunService").Stepped:Connect(function()
            if game.Players.LocalPlayer.Character then
               for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if v:IsA("BasePart") then v.CanCollide = false end
               end
            end
         end)
      else
         if NoclipConn then 
            NoclipConn:Disconnect()
            -- Reset collision saat noclip mati
            if game.Players.LocalPlayer.Character then
               for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if v:IsA("BasePart") then v.CanCollide = true end
               end
            end
         end
      end
   end,
})

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WS",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

Rayfield:Notify({Title = "FayyScript v23.0", Content = "Loaded successfully!", Duration = 5})
