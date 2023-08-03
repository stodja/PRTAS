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


local StartRecord = function()
    Frames = {}
    Running = true
    TimeStart = tick()
    while Running == true do
        game:GetService("RunService").Heartbeat:wait()
        local Character = getChar()
        table.insert(Frames, {
            CF = Character.HumanoidRootPart.CFrame,
            V = Character.HumanoidRootPart.Velocity,
            T = tick() - TimeStart,
            S = Character.Humanoid:GetState().Value
        })
    end
end

local StopRecord = function()
    Running = false
end

local PlayTAS = function()
    local Character = getChar()
    local TimePlay = tick()
    local FrameCount = #Frames
    local NewFrames = FrameCount
    local OldFrame = 1
    local TASLoop
    TASLoop = game:GetService("RunService").Heartbeat:Connect(function()
        local NewFrames = OldFrame + 60
        local CurrentTime = tick()
        if (CurrentTime - TimePlay) >= Frames[FrameCount].T then
            TASLoop:Disconnect()
        end
        for i = OldFrame, NewFrames do
            local Frame = Frames[i]
            if Frame.T <= CurrentTime - TimePlay then
                OldFrame = i
                Character.HumanoidRootPart.CFrame = Frame.CF
                Character.HumanoidRootPart.Velocity = Frame.V
                Character.Humanoid:ChangeState(Frame.S)
            end
        end
    end)
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
   Callback = StartRecord,
})
local Button = Tab:CreateButton({
   Name = "Stop recording.",
   Callback = StopRecord,
})

local Button = Tab:CreateButton({
   Name = "Play",
   Callback = PlayTAS,
})


local Keybind = Tab:CreateKeybind({
   Name = "Stop Recording BIND",
   CurrentKeybind = "",
   HoldToInteract = false,
   Flag = "1",
   Callback = StartRecord,
})

local Keybind = Tab:CreateKeybind({
   Name = "Stop Recording BIND",
   CurrentKeybind = "",
   HoldToInteract = false,
   Flag = "2",
   Callback = StopRecord,
})

local Keybind = Tab:CreateKeybind({
   Name = "Play BIND",
   CurrentKeybind = "",
   HoldToInteract = false,
   Flag = "3",
   Callback = PlayTAS,
})

