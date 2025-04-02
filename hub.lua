if not game:IsLoaded() then
	game.Loaded:Wait()
end

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local ws = game:GetService("Workspace")
local cg = game:GetService("CoreGui")
local pg = lp:FindFirstChildOfClass("PlayerGui")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local stepped = rs.Stepped
local renderstepped = rs.RenderStepped
local heartbeat = rs.Heartbeat
local guiname = tostring((game.PlaceId - lp.UserId) / 2)
local currentplayer = lp
local shp = sethiddenproperty or set_hidden_property or sethiddenprop or set_hidden_prop
local ssr = setsimulationradius or setsimradius or set_simulation_radius
local v3 = Vector3.new
local v3_0 = v3(0, 0, 0)
local cf = CFrame.new
local flycf = false

local function gp(parent, name, className)
	local ret = nil
	pcall(function()
		for i, v in pairs(parent:GetChildren()) do
			if (v.Name == name) and v:IsA(className) then
				ret = v
				break
			end
		end
	end)
	return ret
end

local gui = gp(cg, guiname, "ScreenGui") or gp(pg, guiname, "ScreenGui")
if gui then
	gui:Destroy()
end

gui = Instance.new("ScreenGui")
gui.Name = guiname
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false
gui.IgnoreGuiInset = true
pcall(function()
    gui.Parent = cg
end)
if gui.Parent ~= cg then
    gui.Parent = pg
end
gui:GetPropertyChangedSignal("Parent"):Connect(function()
    if not (gui and gui.Parent) then
        gui = false
    end
end)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "mainFrame"
mainFrame.Parent = gui
mainFrame.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0, 0, 1, -200)
mainFrame.Size = UDim2.new(1, 0, 0, 200)
local mf = Instance.new("Frame")
mf.Name = "mf"
mf.Parent = mainFrame
mf.BackgroundColor3 = mainFrame.BackgroundColor3
mf.BorderSizePixel = 0
mf.Position = UDim2.new(0, 0, 1, 0)
mf.Size = UDim2.new(1, 0, 1, 0)
local scriptName = Instance.new("TextLabel")
scriptName.Name = "scriptName"
scriptName.Parent = mainFrame
scriptName.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
scriptName.BackgroundTransparency = 1.000
scriptName.BorderSizePixel = 0
scriptName.Size = UDim2.new(1, 0, 0, 20)
scriptName.Font = Enum.Font.SourceSans
scriptName.Text = "LERXNA"
scriptName.TextColor3 = Color3.fromRGB(226, 226, 226)
scriptName.TextSize = 20.000
scriptName.TextWrapped = true
local line = Instance.new("Frame")
line.Name = "line"
line.Parent = scriptName
line.BackgroundColor3 = Color3.fromRGB(2226, 226, 226)
line.BackgroundTransparency = 0.700
line.BorderSizePixel = 0
line.Position = UDim2.new(0, 5, 1, 0)
line.Size = UDim2.new(1, -10, 0, 1)
local showhide = Instance.new("TextButton")
showhide.Name = "showhide"
showhide.Parent = mainFrame
showhide.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
showhide.BorderSizePixel = 0
showhide.Position = UDim2.new(0.5, -25, 0, -30)
showhide.Size = UDim2.new(0, 50, 0, 30)
showhide.Font = Enum.Font.SourceSans
showhide.Text = "\\/"
showhide.TextColor3 = Color3.fromRGB(235, 235, 235)
showhide.TextSize = 20.000
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "scrollingFrame"
scrollingFrame.Parent = mainFrame
scrollingFrame.Active = true
scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scrollingFrame.BackgroundTransparency = 1.000
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ClipsDescendants = false
scrollingFrame.Position = UDim2.new(0, 5, 0, 30)
scrollingFrame.Size = UDim2.new(1, -10, 1, -35)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.ScrollBarThickness = 10
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = scrollingFrame
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local event = Instance.new("BindableEvent", gui)
local fps = 60
fps = 1 / fps
local tf = 0
local con = nil
con = renderstepped:Connect(function(s)
    if not gui then
	    con:Disconnect()
	    return
	end
	tf += s
	if tf >= fps then
		for i=1, math.floor(tf / fps) do
			event:Fire(true)
		end
		tf = 0
	end
end)
local event = event.Event

local sn = scriptName.Text
local function notify(msg)
	spawn(function()
		local msg1 = sn .. " - " .. msg
		scriptName.Text = msg1
		wait(3)
		if scriptName.Text == msg1 then
			scriptName.Text = sn
		end
	end)
end

if gui.Parent == pg then
    notify("gui in playerGui")
end

local ancprt = nil
local function weldtp(part, cfr)
	if not (part and part.Parent and part:IsA("BasePart") and (not part:IsGrounded())) then
		return nil
	end
	if not (ancprt and ancprt.Parent and ancprt:IsA("BasePart") and ancprt:IsGrounded() and ancprt:IsDescendantOf(ws)) then
		for i, v in pairs(ws:GetDescendants()) do
			if v and v.Parent and v:IsA("BasePart") and v:IsGrounded() then
				ancprt = v
				break
			end
		end
	end
	if not ancprt then
		ancprt = Instance.new("Part", ws)
		ancprt.Anchored = true
		ancprt.Transparency = 1
		ancprt.CanCollide = false
		ancprt.Name = "weldtp part"
	end
	local weld = Instance.new("Weld")
	weld.Part0 = part
	weld.C0 = cfr:Inverse()
	weld.Part1 = ancprt
	weld.C1 = ancprt.CFrame:Inverse()
	weld.Parent = ws
	stepped:Wait()
	pcall(function()
		weld:Destroy()
	end)
end

local function makeFrame(parent, text, color)
	local frame = Instance.new("Frame")
	frame.Name = "frame_" .. text
	frame.Parent = parent
	frame.BackgroundColor3 = color
	frame.Size = UDim2.new(0, 300, 0, 145)
	frame.BorderSizePixel = 0
	local framelabel = Instance.new("TextLabel")
	framelabel.Name = "framelabel"
	framelabel.Parent = frame
	framelabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	framelabel.BackgroundTransparency = 1.000
	framelabel.BorderSizePixel = 0
	framelabel.Size = UDim2.new(1, 0, 0, 20)
	framelabel.Font = Enum.Font.SourceSans
	framelabel.Text = text
	framelabel.TextColor3 = Color3.fromRGB(197, 197, 197)
	framelabel.TextSize = 14.000
	local line = Instance.new("Frame")
	line.Name = "line"
	line.Parent = framelabel
	line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	line.BackgroundTransparency = 0.700
	line.BorderSizePixel = 0
	line.Position = UDim2.new(0, 5, 1, 0)
	line.Size = UDim2.new(1, -10, 0, 1)
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Parent = frame
	ScrollingFrame.Active = true
	ScrollingFrame.Name = "ScrollingFrame"
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0, 5, 0, 25)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -30)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ScrollBarThickness = 7
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = ScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)
	return frame
end

showhide.MouseButton1Click:Connect(function()
	if showhide.Text == "/\\" then
		showhide.Text = "\\/"
		mainFrame:TweenPosition(UDim2.new(0, 0, 1, -200), "Out", "Elastic", 1)
	else
		showhide.Text = "/\\"
		mainFrame:TweenPosition(UDim2.new(0, 0, 1, -5), "Out", "Elastic", 1)
	end
end)

local controllable = {}
local lastc = nil
local con = nil
con = lp.CharacterAdded:Connect(function(c)
    if not gui then
        con:Disconnect()
        return
    end
    if lastc == c then
        return
    end
    if c and c.Parent then
        lastc = c
        controllable = {}
        for i, v in pairs(plrs:GetPlayers()) do
            local c = v.Character
            if c and c.Parent then
                table.insert(controllable, c)
            end
        end
    end
end)

local viewedPlayer = nil
local viewbutton = {Text = ""}

local playersframe = makeFrame(scrollingFrame, "Players", Color3.fromRGB(50, 50, 50))
local playercframe = makeFrame(playersframe, "Playersontrol", Color3.fromRGB(12, 59, 100))
playercframe.BorderSizePixel = 1.000
playercframe.BorderColor3 = Color3.fromRGB(27, 42, 53)
playercframe.Position = UDim2.new(0, 10, -1, -40)
playercframe.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playercframe.Visible = true
local playerframef = makeFrame(playercframe, "Friends", Color3.fromRGB(0, 150, 0))
playerframef.Position = UDim2.new(1, 10, 0, 5)

local function addbtn(parent, plr)
	local playerbutton = Instance.new("TextButton")
	playerbutton.Name = plr.Name
	playerbutton.Parent = parent
	if plr == lp then
		playerbutton.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	else
		playerbutton.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	end
	playerbutton.BorderSizePixel = 0
	playerbutton.Size = UDim2.new(1, -10, 0, 20)
	playerbutton.Font = Enum.Font.SourceSans
	playerbutton.Text = plr.Name
	if plr.Name ~= plr.DisplayName then
		playerbutton.Text = playerbutton.Text .. " (" .. plr.DisplayName .. ")"
	end
	playerbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
	playerbutton.TextSize = 15.000
	playerbutton.MouseButton1Click:Connect(function()
		playercframe.framelabel.Text = "Selected Player : " .. playerbutton.Text
		currentplayer = plr
		playercframe.Visible = true
		playerframef.Visible = false
		viewbutton.Text = ((viewedPlayer == plr) and "Uview") or "View"
	end)
end

local function unview()
    viewedPlayer = nil
    viewbutton.Text = "View"
	local c = lp.Character
	if c and c.Parent then
	    local subject = c:FindFirstChildOfClass("Humanoid") or c:FindFirstChildWhichIsA("BasePart")
	    if subject then
    	    ws.CurrentCamera.CameraType = Enum.CameraType.Custom
    		ws.CurrentCamera.CameraSubject = subject
		else
		    notify("No Part To View")
		end
	else
		notify("Character Not Found")
	end
end

local playersScroll = playersframe.ScrollingFrame

for i, v in pairs(plrs:GetPlayers()) do
	addbtn(playersScroll, v)
end
local reset = function() end
local con = nil
con = plrs.PlayerAdded:Connect(function(plr)
	if gui then
		addbtn(playersScroll, plr)
	else
	    con:Disconnect()
	end
end)
local con = nil
con = plrs.PlayerRemoving:Connect(function(plr)
	if gui then
		local playerbutton = gp(playersScroll, plr.Name, "TextButton")
		if playerbutton then
			playerbutton:Destroy()
		end
		if plr == currentplayer then
			playercframe.Visible = false
		end
		if plr == viewedPlayer then
		    unview()
		end
	else
	    con:Disconnect()
	end
end)
local hideplayerc = Instance.new("TextButton")
hideplayerc.Name = "addpositionbutton"
hideplayerc.Parent = playercframe.framelabel
hideplayerc.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
hideplayerc.BorderSizePixel = 0
hideplayerc.Position = UDim2.new(1, -17, 0, 2)
hideplayerc.Size = UDim2.new(0, 15, 0, 15)
hideplayerc.Font = Enum.Font.SourceSans
hideplayerc.Text = "X"
hideplayerc.TextColor3 = Color3.fromRGB(0, 0, 0)
hideplayerc.TextSize = 14.000
hideplayerc.MouseButton1Click:Connect(function()
	playercframe.Visible = false
end)
local function makeplrbutton(buttontext)
	local button = Instance.new("TextButton")
	button.Name = "plrButton"
	button.Parent = playercframe.ScrollingFrame
	button.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	button.BorderSizePixel = 0
	button.Size = UDim2.new(1, -10, 0, 20)
	button.Font = Enum.Font.SourceSans
	button.Text = buttontext
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 15.000
	return button
end
makeplrbutton("Goto").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local tp = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
		if tp then
			local c1 = currentplayer.Character
			if c1 and c1.Parent then
				local to = gp(c1, "HumanoidRootPart", "BasePart") or gp(c1, "Head", "BasePart") or c1:FindFirstChildWhichIsA("BasePart")
				if to then
					if flycf then
						flycf = to.CFrame
					else
						weldtp(tp, to.CFrame)
					end
					notify("Goto: " .. currentplayer.Name)
				else
					notify("No Target Part Found")
				end
			else
				notify("Target Character Not Found")
			end
		else
			notify("No Part Found")
		end
	else
		notify("Character Not Found")
	end
end)
viewbutton = makeplrbutton("View")
viewbutton.MouseButton1Click:Connect(function()
    if viewedPlayer == currentplayer then
        unview()
    else
	    viewedPlayer = currentplayer
	    viewbutton.Text = "Unview"
	end
end)

local cbringb = makeplrbutton("Character Bring")

local function noanimations()
	local c = lp.Character
	if c and c.Parent then
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			local animate = gp(c, "Animate", "LocalScript")
			if animate then
				animate.Disabled = true
			end
			for i, v in pairs(hum:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		else
			notify("humanoid not found")
		end
	else
		notify("character not found")
	end
end

local function isConnected(part0, part1, tested)
    if not ((typeof(part0) == "Instance") and part0:IsA("BasePart")) then
        return false
    end
    if not ((typeof(part1) == "Instance") and part1:IsA("BasePart")) then
        return false
    end
    if not tested then
        tested = {}
    end
    local ret = false
    table.insert(tested, part0)
    for i, v in pairs(part0:GetConnectedParts()) do
        if part1 == v then
            return true
        elseif not table.find(tested, v) then
            ret = ret or isConnected(v, part1, tested)
        end
    end
    return ret
end

local function attach(c1)
    local bck = lp:FindFirstChildOfClass("Backpack")
	local c = lp.Character
	--checks for: model, humanoid, arm, torso for main character:
	if not (c and c.Parent) then
	    notify("character not found")
	    return false
	end
	local hum = c:FindFirstChildOfClass("Humanoid")
	if not hum then
	    notify("humanoid not found")
	    return false
	end 
	local arm = gp(c, "Right Arm", "BasePart") or gp(c, "RightHand", "BasePart")
	if not arm then
	    notify("arm not found")
	    return false
	end
	local torso = gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart")
	if not torso then
	    notify("torso not found")
	    return
	end
	if torso:IsGrounded() then
	    notify("torso is grounded")
	    return
	end
	if not isConnected(arm, torso) then
	    notify("arm and toso not connected")
	    return
	end
	--checks for: tool:
	local tool = c:FindFirstChildOfClass("Tool")
	if (not tool) and bck then
		tool = bck:FindFirstChildOfClass("Tool")
	end
	if not tool then
	    notify("No Tool Found")
	    return false
	end
	local handle = gp(tool, "Handle", "BasePart")
	if not handle then
	    notify("Tool Handle Not Found")
	    return
	end
	--checks for: model, humanoid, arm, torso for target character:
	if not (c1 and c1.Parent) then
	    notify("Target Character Not Found")
	    return false
	end
	local hum1 = c1:FindFirstChildOfClass("Humanoid")
	if not hum1 then
	    notify("Target Humanoid Not Found")
	    return false
	end
	local arm1 = gp(c1, "Right Arm", "BasePart") or gp(c1, "RightHand", "BasePart")
	if not arm1 then
	    notify("Target Arm Not Found")
	    return false
	end
	local torso1 = gp(c1, "Torso", "BasePart") or gp(c1, "UpperTorso", "BasePart")
	if not torso1 then
	    notify("Target Torso Not Found")
	    return
	end
	if torso1:IsGrounded() then
	    notify("Target Torso Is Grounded")
	    return
	end
	if not isConnected(arm1, torso1) then
	    notify("Target Arm And Toso Not Connected")
	    return
	end
	--all checks good
	if bck then
    	for i, v in pairs(c:GetChildren()) do
    	    if v:IsA("Tool") then
    	        v.Parent = bck
    	    end
    	end
	end
	local nhum = hum:Clone()
	hum:Destroy()
	hum = nhum
	hum.Parent = c
	hum:EquipTool(tool)
	for i, v in pairs(c1:GetDescendants()) do
		if v and v.Parent and v:IsA("BasePart") then
			v.Massless = true
		end
	end
	while stepped:Wait() do
	    --checks for: model, humanoid, arm, torso for main character:
	    if not (c and c.Parent) then
	        notify("Character Removed")
	        return false
	    end
	    if (not hum and hum.Parent) then
	        notify("Humanoid Removed")
	        return false
	    end
	    if not (arm and arm.Parent) then
	        notify("Arm Removed")
	        return false
	    end
	    if not (torso and torso.Parent) then
	        notify("Torso Removed")
	        return false
	    end
	    if torso:IsGrounded() then
    	    notify("Torso Got Grounded")
    	    return
    	end
	    if not isConnected(arm, torso) then
    	    notify("Arm And Toso Connection Removed")
    	    return
    	end
	    --checks for: model, humanoid, arm, torso for target character:
	    if not (c1 and c1.Parent) then
	        notify("Target Character Removed")
	        return false
	    end
	    if not (hum1 and hum1.Parent) then
	        notify("Target Humanoid Removed")
	        return false
	    end
	    if not (arm1 and arm1.Parent) then
	        notify("Target Arm Removed")
	        return false
	    end
	    if not (torso1 and torso1.Parent) then
	        notify("Target Torso Removed")
	        return false
	    end
	    if torso:IsGrounded() then
            notify("Target Torso Got Grounded")
            return
        end
	    if not isConnected(arm1, torso1) then
    	    notify("Target Arm And Toso Connection Removed")
    	    return
    	end
    	--checks for: tool
	    if not (tool and tool.Parent) then
	        notify("Tool Removed")
	        return false
	    end
	    if not (handle and handle.Parent) then
	        notify("Tool Handle Removed")
	        return false
	    end
	    if (tool.Parent ~= c) and (tool.Parent ~= c1) and (tool.Parent ~= bck) then
	        notify("Unexpected Tool Parent")
	        return false
	    end
	    --all checks good
	    if (tool.Parent == c1) then
	        break
	    end
	    tool.Parent = c
	    weldtp(arm1, handle.CFrame)
	    if (tool.Parent == c1) then
	        break
	    end
	end
	return handle
end

makeplrbutton("Bring").MouseButton1Click:Connect(function()
    local plr = currentplayer
    local c1 = plr.Character
    if not (c1 and c1.Parent) then
        notify("Target Character Not Found")
        return
    end
    if not table.find(controllable, c1) then
        reset(true)
        wait(0.1)
    end
    if not (plr and plr.Parent) then
        notify("Target Player Left")
        return
    end
    if not (c1 and c1.Parent) then
        c1 = currentplayer.Character
    end
    if not (c1 and c1.Parent) then
        notify("Target Character Not Found")
        return
    end
	local c = lp.Character
	if not (c and c.Parent) then
	    notify("Character Not Found")
        return
	end
	local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "Head", "BasePart")
	if not part then
	    notify("Part Not Found")
	    return
	end
	local cfr = part.CFrame
	local joint = attach(currentplayer.Character)
	if not joint then
	    return
	end
	weldtp(part, cfr)
	wait(0.5)
	if c and c.Parent and part and part.Parent and joint and joint.Parent then
		weldtp(part, cfr)
		if not (joint and joint.Parent) then
		    notify("Joint Removed")
		    reset(false)
		    return
		end
		joint:BreakJoints()
		reset(false)
		notify("Brought " .. currentplayer.Name)
	end
end)

makeplrbutton("Kill").MouseButton1Click:Connect(function()
	local plr = currentplayer
    local c1 = plr.Character
    if not (c1 and c1.Parent) then
        notify("Target Character Not Found")
        return
    end
    if not table.find(controllable, c1) then
        reset(true)
        wait(0.1)
    end
    if not (plr and plr.Parent) then
        notify("Target Player Left")
        return
    end
    if not (c1 and c1.Parent) then
        notify("Target Character Removed")
        return
    end
	local c = lp.Character
	if not (c and c.Parent) then
	    notify("Character Not Found")
        return
	end
	local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "Head", "BasePart")
	if not part then
	    notify("Part Not Found")
	    return
	end
	local cfr = part.CFrame
	local joint = attach(currentplayer.Character)
	if not joint then
	    return
	end
	weldtp(part, cfr)
	local con, con1 = nil, nil
	con = heartbeat:Connect(function()
	    if not (part and part.Parent) then
	        con:Disconnect()
	        con1:Disconnect()
	        return
	    end
	    part.Velocity = v3(0, -200000, 0)
	end)
	con1 = stepped:Connect(function()
	    if not (part and part.Parent) then
	        con:Disconnect()
	        con1:Disconnect()
	        return
	    end
	    part.Velocity = v3_0
	end)
	wait(0.5)
	con:Disconnect()
	con1:Disconnect()
	if c and c.Parent and part and part.Parent and joint and joint.Parent then
		weldtp(part, cfr)
		if not (joint and joint.Parent) then
		    notify("Joint Removed")
		    reset(false)
		    return
		end
		joint:BreakJoints()
		reset(false)
		notify("Attempted To Kill " .. currentplayer.Name)
	else
	    notify("Something Went Wrong")
	end
end)

makeplrbutton("Attach").MouseButton1Click:Connect(function()
	return attach(currentplayer.Character) and notify("Attached To " .. currentplayer.Name)
end)

makeplrbutton("View Friends").MouseButton1Click:Connect(function()
	playerframef.Visible = not playerframef.Visible
	if not playerframef.Visible then
		return
	end
	playerframef.framelabel.Text = "Friends In Game: " .. currentplayer.Name
	local scroll = playerframef.ScrollingFrame
	for i, v in pairs(scroll:GetChildren()) do
		if v and v.Parent and v:IsA("TextButton") then
			v:Destroy()
		end
	end
	for i, v in pairs(plrs:GetPlayers()) do
		spawn(function()
			if v and v.Parent and currentplayer:IsFriendsWith(v.UserId) then
				addbtn(playerframef.ScrollingFrame, v)
			end
		end)
	end
end)

local function makeflingbutton(partname)
	makeplrbutton("Fling (" .. partname .. ")").MouseButton1Click:Connect(function()
		local c = lp.Character
		if c and c.Parent then
			local hrp = gp(c, partname, "BasePart")
			if hrp then
				local c1 = currentplayer.Character
				if c1 and c1.Parent then
					local hrp1 = gp(c1, partname, "BasePart")
					if hrp1 then						
						c:BreakJoints()
						hrp.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.01, 0.01, 0.01, 0.01)
						for i, v in pairs(c:GetChildren()) do
							if (v ~= hrp) and v and v.Parent and v:IsA("BasePart") then
								v:Destroy()
							end
						end
						hrp.Transparency = 0.5
						while heartbeat:Wait() and c and c.Parent and hrp and hrp.Parent and c1 and c1.Parent and hrp1 and hrp1.Parent do
							local pos = {x=0, y=0, z=0}
							pos.x = hrp1.Position.X
							pos.y = hrp1.Position.Y
							pos.z = hrp1.Position.Z
							pos.x += hrp1.Velocity.X / 2
							pos.y += hrp1.Velocity.Y / 2
							pos.z += hrp1.Velocity.Z / 2
							local heightlock = ws.FallenPartsDestroyHeight + 5
							if pos.y < heightlock then
								pos.y = heightlock
							end
							hrp.CanCollide = false
							hrp.Position = v3(pos.x, pos.y, pos.z)
							hrp.Velocity = v3(0, 1000, 0)
							hrp.RotVelocity = v3(10000, 10000, 10000)
							ws.CurrentCamera.CameraSubject = hrp1
						end
						wait(0.1)
						ws.CurrentCamera.CameraSubject = (lp.Character and lp.Character.Parent and lp.Character:FindFirstChildOfClass("Humanoid")) or nil
					else
						notify("Target Part Not Found")
					end
				else
					notify("Target Character Not Found")
				end
			else
				notify("Part Not Found")
			end
		else
			notify("Character Not Found")
		end
	end)
end
makeflingbutton("Head")
makeflingbutton("HumanoidRootPart")
makeflingbutton("Torso")

local graphicsframe = makeFrame(scrollingFrame, "Enviroment", Color3.fromRGB(50, 50, 50))
local function makegraphicsbutton(buttontext)
	local button = Instance.new("TextButton")
	button.Name = "removefog"
	button.Parent = graphicsframe.ScrollingFrame
	button.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	button.BorderSizePixel = 0
	button.Size = UDim2.new(1, -10, 0, 20)
	button.Font = Enum.Font.SourceSans
	button.Text = buttontext
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 15.000
	return button
end
local lig = game:GetService("Lighting")
makegraphicsbutton("Remove Fog").MouseButton1Click:Connect(function()
	lig.FogStart = 9e9
	lig.FogEnd = 9e9
end)
local function setupremove(button, classname)
	button.MouseButton1Click:Connect(function()
		for i, v in pairs(game:GetDescendants()) do
			if v:IsA(classname) then
				v:Destroy()
			end
		end
	end)
end
setupremove(makegraphicsbutton("Remove Atmosphere Effects"), "Atmosphere")
setupremove(makegraphicsbutton("Remove Blur"), "BlurEffect")
setupremove(makegraphicsbutton("Remove Decals"), "Decal")
setupremove(makegraphicsbutton("Default Sky"), "Sky")
setupremove(makegraphicsbutton("Remove Sun Rays"), "SunRaysEffect")
setupremove(makegraphicsbutton("Remove Particles"), "ParticleEmitter")
setupremove(makegraphicsbutton("Remove Color Correction Effects"), "ColorCorrectionEffect")

local cfly = nil
local fhrp = nil
local flyspeed = 1

local positionsframe = makeFrame(scrollingFrame, "Teleport Locations", Color3.fromRGB(50, 50, 50))
local addpositionbutton = Instance.new("TextButton")
addpositionbutton.Name = "addpositionbutton"
addpositionbutton.Parent = positionsframe.framelabel
addpositionbutton.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
addpositionbutton.BorderSizePixel = 0
addpositionbutton.Position = UDim2.new(1, -86, 0, 2)
addpositionbutton.Size = UDim2.new(0, 83, 1, -4)
addpositionbutton.Font = Enum.Font.SourceSans
addpositionbutton.Text = "+ ADD CURRENT"
addpositionbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
addpositionbutton.TextSize = 14.000
addpositionbutton.MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local hrp = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
		if hrp then
			local cfr = hrp.CFrame
			local positionframe = Instance.new("Frame")
			local loadposbutton = Instance.new("TextButton")
			local removeposbutton = Instance.new("TextButton")
			local positionName = Instance.new("TextBox")
			positionframe.Name = "positionframe"
			positionframe.Parent = positionsframe.ScrollingFrame
			positionframe.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
			positionframe.BorderSizePixel = 0
			positionframe.Size = UDim2.new(1, -10, 0, 30)
			loadposbutton.Name = "loadposbutton"
			loadposbutton.Parent = positionframe
			loadposbutton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			loadposbutton.BorderSizePixel = 0
			loadposbutton.Position = UDim2.new(1, -70, 0, 5)
			loadposbutton.Size = UDim2.new(0, 40, 1, -10)
			loadposbutton.Font = Enum.Font.SourceSans
			loadposbutton.Text = "load"
			loadposbutton.TextColor3 = Color3.fromRGB(226, 226, 226)
			loadposbutton.TextSize = 16.000
			removeposbutton.Name = "removeposbutton"
			removeposbutton.Parent = positionframe
			removeposbutton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			removeposbutton.BorderSizePixel = 0
			removeposbutton.Position = UDim2.new(1, -25, 0, 5)
			removeposbutton.Size = UDim2.new(0, 20, 1, -10)
			removeposbutton.Font = Enum.Font.SourceSans
			removeposbutton.Text = "X"
			removeposbutton.TextColor3 = Color3.fromRGB(226, 226, 226)
			removeposbutton.TextSize = 16.000
			positionName.Name = "positionName"
			positionName.Parent = positionframe
			positionName.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
			positionName.BackgroundTransparency = 1.000
			positionName.BorderSizePixel = 0
			positionName.Position = UDim2.new(0, 5, 0, 5)
			positionName.Size = UDim2.new(1, -80, 1, -10)
			positionName.Font = Enum.Font.SourceSans
			positionName.Text = "Position"
			positionName.ClearTextOnFocus = false
			positionName.TextColor3 = Color3.fromRGB(0, 0, 0)
			positionName.TextSize = 25.000
			positionName.TextXAlignment = Enum.TextXAlignment.Left
			loadposbutton.MouseButton1Click:Connect(function()
				c = lp.Character
				if c and c.Parent then
					hrp = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
					if hrp then
						if flycf then
							flycf = cfr
						else
							weldtp(hrp, cfr)
						end
					else
						notify("Part Not Found")
					end
				else
					notify("Character Not Found")
				end
			end)
			removeposbutton.MouseButton1Click:Connect(function()
				positionframe:Destroy()
			end)
		end
	end
end)

local charframe = makeFrame(scrollingFrame, "You", Color3.fromRGB(50, 50, 50))
local function makecharbutton(buttontext)
	local button = Instance.new("TextButton")
	button.Name = "charButton"
	button.Parent = charframe.ScrollingFrame
	button.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	button.BorderSizePixel = 0
	button.Size = UDim2.new(1, -10, 0, 20)
	button.Font = Enum.Font.SourceSans
	button.Text = buttontext
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 15.000
	return button
end
local function respawnRequest()
	local ccfr = ws.CurrentCamera.CFrame
	local c = lp.Character
	lp.Character = nil
	lp.Character = c
	ws.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
	ws.CurrentCamera.CFrame = ccfr
end
local loopr = false
local fakevoidp = nil
reset = function(respawn)
    if fakevoidp then
        fakevoidp = nil
        wait(0.3)
    end
	local c = lp.Character
	local partName, cfr, ccfr = nil, nil, nil
	if not (c and c.Parent) then
		respawnRequest()
		if not loopr then
			notify("Character Not Found, Trying To Respawn")
		end
		return
	end
	local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
	if not part then
	    respawnRequest()
		if not loopr then
			notify("No Part Found In The Character, Trying To Respawn")
		end
		return
	end
	partName, cfr, ccfr = part.Name, part.CFrame, ws.CurrentCamera.CFrame
	spawn(function()
		local c, part = c, nil
		while c and c.Parent do
			stepped:Wait()
		end
		while not (c and c.Parent) do
			stepped:Wait()
			c = lp.Character
		end
		while stepped:Wait() and c and c.Parent and (not part) do
			part = gp(c, partName, "BasePart")
		end
		if not part then
			if not loopr then
				notify("Failed To TP Back")
			end
			return
		end
		weldtp(part, cfr)
		ws.CurrentCamera.CFrame = ccfr
		cfr = false
		if not loopr then
			notify("Respawned")
		end
	end)
	if respawn and (not loopr) then
		notify("Respawning...")
	end
	if respawn and (plrs.RespawnTime > 0.5) then
		spawn(function()
			while c and c.Parent do
				if part and part.Parent then
					cfr = part.CFrame
				end
				ccfr = ws.CurrentCamera.CFrame
				stepped:Wait()
			end
		end)
		local spamrequest = true
		spawn(function()
			while wait() and spamrequest and c and c.Parent do
				respawnRequest()
			end
		end)
		wait(0.5)
		spamrequest = false
		wait(plrs.RespawnTime - 0.5)
		part = nil
	end
	if c and c.Parent then
		if respawn then
			local hum = c:FindFirstChildOfClass("Humanoid")
			if hum then
				hum:Destroy()
			end
		end
		c:BreakJoints()
		while respawn and gui and cfr do
	        stepped:Wait()
	    end
	end
end
makecharbutton("Respawn").MouseButton1Click:Connect(function()
	if not loopr then
		reset(true)
	end
end)
makecharbutton("Reset").MouseButton1Click:Connect(function()
	reset(false)
end)
local looprb = makecharbutton("Loop Respawn")
spawn(function()
	while wait() and gui do
		if loopr then
			reset(true)
		end
	end
end)
looprb.MouseButton1Click:Connect(function()
	loopr = not loopr
	looprb.Text = "Loop Respawn" .. ((loopr and " (ENABLED)") or "")
end)
makecharbutton("Remove Meshes").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		for i, v in pairs(c:GetDescendants()) do
			if v and v.Parent and (v:IsA("Mesh") or v:IsA("SpecialMesh") or v:IsA("CharacterMesh")) then
				v:Destroy()
			end
		end
		notify("Removed Meshes")
	else
		notify("No Character")
	end
end)
makecharbutton("Break Joints").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		c:BreakJoints()
		notify("Broken Joints")
	else
		notify("No Character")
	end
end)
local noclipb = makecharbutton("Noclip")
local antiflingb = makecharbutton("Anti-Fling")
local noclip = false
local antifling = false
noclipb.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipb.Text = "Noclip" .. ((noclip and " (ENABLED)") or "")
end)
antiflingb.MouseButton1Click:Connect(function()
	antifling = not antifling
	antiflingb.Text = "Anti-Fling" .. ((antifling and " (ENABLED)") or "")
end)
local fakevoidb = makecharbutton("Fake Void")
fakevoidb.MouseButton1Click:Connect(function()
    if fakevoidp then
        fakevoidp = nil
        fakevoidb.Text = "Fake Void"
    else
        local c = lp.Character
        if not (c and c.Parent) then
            notify("character Not Found")
            return
        end
        local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
        if not part then
            notify("No Part Found")
            return
        end
        fakevoidp = part
        fakevoidb.Text = "Fake Void (ENABLED)"
        notify("Character Teleported Under FallenPartsDestroyHeight")
        
        local dh = ws.FallenPartsDestroyHeight
        local cfr = fakevoidp.CFrame
        local newcf = cf(0, dh - 100, 0)
        local camcf = ws.CurrentCamera.CFrame
        ws.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        ws.FallenPartsDestroyHeight = dh - 200
        while stepped:Wait() and gui and c and c.Parent and fakevoidp and fakevoidp.Parent do
            weldtp(fakevoidp, newcf)
        end
        ws.FallenPartsDestroyHeight = dh
        fakevoidb.Text = "Fake Void"
        if c and c.Parent then
            unview()
            ws.CurrentCamera.CFrame = camcf
            if part and part.Parent then
                weldtp(part, cfr)
                notify("Teleported Back")
            else
                notify("Part Removed")
            end
        else
            notify("Character Removed")
        end
    end
end)
makecharbutton("Block Tool").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local tool = c:FindFirstChildOfClass("Tool")
		if tool then
			local found = false
			for i, v in pairs(tool:GetDescendants()) do
				if v and v.Parent and v:IsA("Mesh") or v:IsA("SpecialMesh") then
					v:Destroy()
				end
			end
			if found then
				notify("Removed Tool Meshes")
			else
				notify("No Meshes Found")
			end
		else
			notify("Tool Not Found")
		end
	else
		notify("No Character")
	end
end)
local infjumpb = makecharbutton("Infinite Jump")
local infjump = false
local con = nil
con = game:GetService("UserInputService").JumpRequest:Connect(function()
	if not gui then
	    con:Disconnect()
	    return
	end
	if infjump then
		local c = lp.Character
		if c and c.Parent then
			local hum = c:FindFirstChildOfClass("Humanoid")
			if hum then
				hum:ChangeState("Jumping")
			end
		end
	end
end)
infjumpb.MouseButton1Click:Connect(function()
	infjump = not infjump
	infjumpb.Text = "Infinite Jump" .. ((infjump and " (ENABLED)") or "")
end)
makecharbutton("God (Remove Humanoid)").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Archivable = true
			local hum1 = hum:Clone()
			hum:Destroy()
			hum1.Parent = c
			notify("Humanoid Client Sided")
		else
			notify("Humanoid Not Found")
		end
	else
		notify("Character Not Found")
	end
end)
local loopgb = makecharbutton("Loop God Mode")
local loopg = false
spawn(function()
	while wait() and gui do
		if loopg then
			local c = lp.Character
			if c and c.Parent then
				local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
				if part then
					local hum = c:FindFirstChildOfClass("Humanoid")
					if hum then
					    local partName = part.Name
						local new = hum:Clone()
						hum:Destroy()
						new.Parent = c
						ws.CurrentCamera.CameraSubject = c
    					local currentcfr = part.CFrame
    					local camcfr = ws.CurrentCamera.CFrame
    					while wait() and c and c.Parent and part and part.Parent do
    						currentcfr = part.CFrame
    						camcfr = ws.CurrentCamera.CFrame
    						local ff = c:FindFirstChildOfClass("ForceField")
    						if ff then
    							ff:Destroy()
    						end
    					end
    					part = nil
    					while not (part and part.Parent) do
    						wait()
    						c = lp.Character
    						part = gp(c, partName, "BasePart")
    					end
						weldtp(part, currentcfr)
						ws.CurrentCamera.CFrame = camcfr
    				end
				end
			end
		end
	end
end)
loopgb.MouseButton1Click:Connect(function()
	loopg = not loopg
	loopgb.Text = "Loop God Mode" .. ((loopg and " (ENABLED)") or "")
end)
local flyb = makecharbutton("Fly")
flyb.MouseButton1Click:Connect(function()
	if cfly and cfly.Parent then
		cfly = nil
	else
		cfly = lp.Character
		flyb.Text = "Fly (ENABLED)"
	end
end)

local ctrlf = {
	["w"] = false,
	["a"] = false,
	["s"] = false,
	["d"] = false
}
local con = nil
con = mouse.KeyDown:Connect(function(key)
    if not gui then
        con:Disconnect()
        return
    end
	key = key:lower()
	if ctrlf[key] ~= nil then
		ctrlf[key] = true
	end
end)
local con = nil
con = mouse.KeyUp:Connect(function(key)
    if not gui then
        con:Disconnect()
        return
    end
	key = key:lower()
	if ctrlf[key] ~= nil then
		ctrlf[key] = false
	end
end)
local con = nil
con = event:Connect(function()
    if not gui then
        con:Disconnect()
        return
    end
    if not flycf then
        return
    end
    local fb = ((ctrlf["w"] and flyspeed) or 0) + ((ctrlf["s"] and -flyspeed) or 0)
	local lr = ((ctrlf["a"] and -flyspeed) or 0) + ((ctrlf["d"] and flyspeed) or 0)
	local camcf = ws.CurrentCamera.CFrame
	local caX, caY, caZ, ca1, ca2, ca3, ca4, ca5, ca6, ca7, ca8, ca9 = camcf:GetComponents()
	flycf = cf(flycf.X, flycf.Y, flycf.Z, ca1, ca2, ca3, ca4, ca5, ca6, ca7, ca8, ca9)
	flycf += camcf.lookVector * fb
	flycf += camcf.rightVector * lr
end)
spawn(function()
    while stepped:Wait() and gui do
    	if cfly and cfly.Parent then
    		fhrp = (fhrp and (fhrp.Parent == cfly) and fhrp) or gp(cfly, "HumanoidRootPart", "BasePart") or gp(cfly, "Head", "BasePart") or cfly:FindFirstChildWhichIsA("BasePart")
    		if fhrp then
    		    flycf = flycf or fhrp.CFrame
    			weldtp(fhrp, flycf)
    		end
    	else
    		flycf = false
    		fhrp = nil
    		flyb.Text = "Fly"
    	end
	end
end)

local hiddenfling = false
spawn(function()
    local hrp, c, vel = nil, nil, nil
    while gui do
        heartbeat:Wait()
        if hiddenfling then
            while gui and hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
                heartbeat:Wait()
                c = lp.Character
                hrp = gp(c, "HumanoidRootPart", "BasePart")
            end
            if gui and hiddenfling then 
                vel = hrp.Velocity
                hrp.Velocity = hrp.Velocity.Unit * v3(20000, 0, 20000) + v3(0, 5000, 0)
                renderstepped:Wait()
                if c and c.Parent and hrp and hrp.Parent then
                    hrp.Velocity = vel
                end
            end
        end
    end
end)
local hiddenflingB = makecharbutton("Hidden Fling")
hiddenflingB.MouseButton1Click:Connect(function()
    hiddenfling = not hiddenfling
    hiddenflingB.Text = "Hidden Fling" .. ((hiddenfling and " (ENABLED)") or "")
end)

makecharbutton("Anti-Respawn (Wait 5 s)").MouseButton1Click:Connect(respawnRequest)
makecharbutton("No Animations").MouseButton1Click:Connect(noanimations)
makecharbutton("Sit").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Sit = not hum.Sit
		else
			notify("Humanoid Not Found")
		end
	else
		notify("Character Not Found")
	end
end)
makecharbutton("Fake Sit").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
		    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			hum.Sit = true
			notify("Humanoid.Sit Set To True")
		else
			notify("Humanoid Not Found")
		end
	else
		notify("Character Not Found")
	end
end)
makecharbutton("Remove Humanoidroot").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c then
		local cpar = c.Parent
		if cpar then
			local hrp = gp(c, "HumanoidRootPart", "BasePart")
			if hrp then
				c.Parent = nil
				hrp:Destroy()
				c.Parent = cpar
				notify("HRP Removed")
			else
				notify("HRP Not Found")
			end
		else
			notify("Character Not Found")
		end
	else
		notify("Character Not Found")
	end
end)
makecharbutton("Set CanTouch To False").MouseButton1Click:Connect(function()
	local c = lp.Character
	if c and c.Parent then
		local tool = c:FindFirstChildOfClass("Tool")
		for i, v in pairs(c:GetDescendants()) do
			if v and v.Parent and v:IsA("BasePart") and ((not tool) or (not v:IsDescendantOf(tool))) then
				v.CanTouch = false
			end
		end
		notify("CanTouch Has Been Set To false")
	else
		notify("Character Not Found")
	end
end)
local ctrltp = false
local clicktpbutton = makecharbutton("CTRL Click TP")
clicktpbutton.MouseButton1Click:Connect(function()
    ctrltp = not ctrltp
    clicktpbutton.Text = "CTRL Click TP" .. ((ctrltp and " (ENABLED)") or "")
end)
local con = nil
con = mouse.Button1Down:Connect(function()
    if not gui then
        con:Disconnect()
        return
    end
    if not ctrltp then
        return
    end
    if not (mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl)) then
        return
    end
    local to = mouse.Hit.Position + v3(0, 3, 0)
    to = cf(to, to + v3(-1, 0, -1) * ws.CurrentCamera.CFrame.LookVector)
    if flycf then
        flycf = to
        return
    end
    local c = lp.Character
    if not (c and c.Parent) then
        return
    end
    local hrp = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
    if hrp then
        weldtp(hrp, to)
    end
end)
makecharbutton("View").MouseButton1Click:Connect(unview)

local utilframe = makeFrame(scrollingFrame, "Utilities", Color3.fromRGB(50, 50, 50))
local utilscroll = utilframe.ScrollingFrame

local function makeutilbutton(buttontext)
	local button = Instance.new("TextButton")
	button.Name = "utilButton"
	button.Parent = utilscroll
	button.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	button.BorderSizePixel = 0
	button.Size = UDim2.new(1, -10, 0, 20)
	button.Font = Enum.Font.SourceSans
	button.Text = buttontext
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 15.000
	return button
end

local netb = makeutilbutton("Net Bypass")
local net = false
netb.MouseButton1Click:Connect(function()
	if net then
		net = false
	else
		net = shp and function(Radius) 
			shp(lp, "SimulationRadius", Radius) 
		end
		net = net or ssr
		if net then
			pcall(function()
				shp(lp, "MaximumSimulationRadius", 9e9)
			end)
		else
			notify("Exploit Not Supported")
		end
	end
	netb.Text = "Net Bypass" .. ((net and " (ENABLED)") or "")
end)

local espb = makeutilbutton("ESP")
local esp = false
espb.MouseButton1Click:Connect(function()
	esp = not esp
	espb.Text = "ESP" .. ((esp and " (ENABLED)") or "")
end)
local teamcheckb = makeutilbutton("ESP Team Check")
local espTeamCheck = false
teamcheckb.MouseButton1Click:Connect(function()
	espTeamCheck = not espTeamCheck
	teamcheckb.Text = "ESP Team Check" .. ((espTeamCheck and " (ENABLED)") or "")
end)

local espcolor = Color3.fromRGB(226, 226, 226)

local vpf = Instance.new("ViewportFrame", gui)
vpf.BackgroundTransparency = 1
vpf.BorderSizePixel = 0
vpf.ImageTransparency = 0.5
vpf.ImageColor3 = espcolor
vpf.BackgroundColor3 = espcolor
vpf.Size = UDim2.new(1, 0, 1, 0)
vpf.Visible = true
vpf.Name = "ESP"

local con = nil
con = renderstepped:Connect(function()
    if not gui then
        con:Disconnect()
        return
    end
	if net then
		net(9e9)
	end
	vpf:ClearAllChildren()
	if esp then
	    vpf.CurrentCamera = ws.CurrentCamera
		for i, plr in pairs(plrs:GetPlayers()) do
			if ( (not espTeamCheck) or (plr.Team ~= lp.Team) ) and (plr ~= lp) then
				local c = plr.Character
				if c and c.Parent then
					for i, part in pairs(c:GetDescendants()) do
						if part:IsA("BasePart") then
							local part1 = Instance.new("Part", vpf)
							part1.Color = espcolor
							part1.Size = part.Size
							part1.CFrame = part.CFrame
						end
					end
				end
			end
		end
	end
	if viewedPlayer then
	    local c = viewedPlayer.Character
	    if c and c.Parent then
    	    local subject = c:FindFirstChildOfClass("Humanoid") or c:FindFirstChildWhichIsA("BasePart")
    	    if subject then
    	        ws.CurrentCamera.CameraType = Enum.CameraType.Custom
    	        ws.CurrentCamera.CameraSubject = subject
    	    end
	    end
	end
end)

makeutilbutton("Rejoin").MouseButton1Click:Connect(function()
	if #plrs:GetPlayers() == 1 then
		lp:Kick()
		wait()
		game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
	else
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
	end
end)

makeutilbutton("Serverhop").MouseButton1Click:Connect(function()
	local servers = nil
	pcall(function()
		servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
	end)
	if type(servers) ~= "table" then
		notify("Error Getting Server List")
		return
	end
	local jobIds = {}
	for i, v in pairs(servers) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			table.insert(jobIds, v.id)
		end
	end
	if #jobIds > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobIds[math.random(1, #jobIds)])
	else
		notify("No Server Found")
	end
end)

makeutilbutton("Instant Leave").MouseButton1Click:Connect(function()
	lp:Kick()
	wait()
	game:Shutdown()
end)


local cbringframe = makeFrame(scrollingFrame, "Character Bring", Color3.fromRGB(50, 50, 50))
local cbringscroll = cbringframe.ScrollingFrame

local cbring = {}

local togglecbring = nil

local function makecbringframe(name)
	local plrcbringf = Instance.new("Frame")
	local uncbringbtn = Instance.new("TextButton")
	local cbringplrname = Instance.new("TextBox")
	plrcbringf.Name = name
	plrcbringf.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	plrcbringf.BorderSizePixel = 0
	plrcbringf.Size = UDim2.new(1, -10, 0, 30)
	plrcbringf.Parent = cbringscroll
	uncbringbtn.Name = "removeposbutton"
	uncbringbtn.Parent = plrcbringf
	uncbringbtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	uncbringbtn.BorderSizePixel = 0
	uncbringbtn.Position = UDim2.new(1, -25, 0, 5)
	uncbringbtn.Size = UDim2.new(0, 20, 1, -10)
	uncbringbtn.Font = Enum.Font.SourceSans
	uncbringbtn.Text = "X"
	uncbringbtn.TextColor3 = Color3.fromRGB(226, 226, 226)
	uncbringbtn.TextSize = 16.000
	cbringplrname.Parent = plrcbringf
	cbringplrname.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
	cbringplrname.BackgroundTransparency = 1.000
	cbringplrname.BorderSizePixel = 0
	cbringplrname.Position = UDim2.new(0, 5, 0, 5)
	cbringplrname.Size = UDim2.new(1, -80, 1, -10)
	cbringplrname.Font = Enum.Font.SourceSans
	cbringplrname.Text = name
	cbringplrname.TextColor3 = Color3.fromRGB(0, 0, 0)
	cbringplrname.TextSize = 25.000
	cbringplrname.TextXAlignment = Enum.TextXAlignment.Left
	uncbringbtn.MouseButton1Click:Connect(function()
		togglecbring(name)
	end)
	return plrcbringf
end

togglecbring = function(name)
	local frame = gp(cbringscroll, name, "Frame")
	if frame then
		pcall(function()
			table.remove(cbring, table.find(cbring, name))
		end)
		frame:Destroy()
		notify("Removed " .. name .. " from Character Bring")
	else
		table.insert(cbring, name)
		makecbringframe(name)
		notify("Added " .. name .. " To Character Bring")
	end
end

cbringb.MouseButton1Click:Connect(function()
	togglecbring(currentplayer.Name)
end)

local cbringallbtn = Instance.new("TextButton")
cbringallbtn.Name = "cbringallbtn"
cbringallbtn.Parent = cbringframe.framelabel
cbringallbtn.BackgroundColor3 = Color3.fromRGB(226, 226, 226)
cbringallbtn.BorderSizePixel = 0
cbringallbtn.Position = UDim2.new(1, -57, 0, 2)
cbringallbtn.Size = UDim2.new(0, 55, 1, -4)
cbringallbtn.Font = Enum.Font.SourceSans
cbringallbtn.Text = "+ ADD ALL"
cbringallbtn.TextColor3 = Color3.fromRGB(0, 0, 0)
cbringallbtn.TextSize = 14.000
cbringallbtn.MouseButton1Click:Connect(function()
	for i, v in pairs(plrs:GetPlayers()) do
		if (v ~= lp) and v and v.Parent and (not table.find(cbring, v.Name)) then
			togglecbring(v.Name)
		end
	end
end)

spawn(function()
	while gui do
		local waited = false
		local lpc = lp.Character
		if lpc and lpc.Parent then
			local part0 = gp(lpc, "Torso", "BasePart") or gp(lpc, "HumanoidRootPart", "BasePart") or gp(lpc, "Head", "BasePart") or lpc:FindFirstChildWhichIsA("BasePart")
			if part0 then
				for i, v in pairs(plrs:GetPlayers()) do
					if v ~= lp then
						local c = v.Character
						if c and c.Parent then
							if table.find(cbring, v.Name) then
								local part1 = gp(c, part0.Name, "BasePart") or gp(c, "Torso", "BasePart") or gp(c, "HumanoidRootPart", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
								if part1 then
									local p1cf = part0.CFrame
									waited = true
									weldtp(part1, p1cf + p1cf.LookVector * 2)
								end
							end
						end
					end
				end
			end
		end
		if not waited then
			stepped:Wait()
		end
	end
end)

local con = nil
con = stepped:Connect(function()
    if not gui then
        con:Disconnect()
        return
    end
	local lpc = lp.Character
	if noclip and lpc and lpc.Parent then
		for i, v in pairs(lpc:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

local con0, con1 = nil, nil
local function antiflingF()
    if not gui then
        con0:Disconnect()
        con1:Disconnect()
        return
    end
    if antifling then
		for i, v in pairs(plrs:GetPlayers()) do
			if v ~= lp then
				local c = v.Character
				if c and c.Parent then
					for i1, v1 in pairs(c:GetDescendants()) do
						if v1:IsA("BasePart") then
							v1.CanCollide = false
							v1.Velocity = v3_0
							v1.RotVelocity = v3_0
						end
					end
				end
			end
        end
    end
end
con0 = stepped:Connect(antiflingF)
con1 = heartbeat:Connect(antiflingF)

gui.Enabled = true
renderstepped:Wait()
playercframe.Visible = false
