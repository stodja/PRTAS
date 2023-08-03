local Running = false
local Frames = {}
local TimeStart = tick()

local Player = game:GetService("Players").LocalPlayer
local getChar = function()
    local Character = Player.Character
    if Character then
        return Character
    else
        Player.CharacterAdded:Wait()
        return getChar()
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Global TAS",
   LoadingTitle = "\"its not working pls fix\"",
   LoadingSubtitle = "by tomato.txt",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = ""
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Control", 4483362458)
local Section = Tab:CreateSection("Save")
local Button = Tab:CreateButton({
   Name = "Start recording",
   Callback = function()
        Frames = {}
        Running = true
        TimeStart = tick()
        while Running == true do
            game:GetService("RunService").Heartbeat:wait()
            table.insert(Frames, {
                CF = getChar().HumanoidRootPart.CFrame,
                V = getChar().HumanoidRootPart.Velocity,
                T = tick() - TimeStart
            })
        end
   end,
})
local Button = Tab:CreateButton({
   Name = "Stop recording.",
   Callback = function()
        Running = false
   end,
})

local Button = Tab:CreateButton({
   Name = "Play",
   Callback = function()
        local Character = getChar()
        local TimePlay = tick()
        local TASLoop
        TASLoop = game:GetService("RunService").Heartbeat:Connect(function()
            local FrameCount = #Frames
            local CurrentTime = tick()
            if CurrentTime - TimePlay >= Frames[FrameCount].T then TASLoop:Disconnect() end
            for i = 1, FrameCount do
                local Frame = Frames[i]
                if Frame.T <= CurrentTime - TimePlay then
                    Character.HumanoidRootPart.CFrame = Frame.CF
                    Character.HumanoidRootPart.Velocity = Frame.V
                end
            end
        end)
   end,
})
