--[[
 WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Xeno GUI | Toggle L | Drag | Minimize | Close | Tabs | Auto scripts keep running

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EscapeTsunamiGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Xeno GUI",
		Text = "Toggle GUI with L",
		Duration = 4
	})
end)

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(520, 450)
Frame.Position = UDim2.fromScale(0.25, 0.2)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Escape Tsunami For Brainrots"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = Frame
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.Parent = Frame

-- Tabs bar
local TabsBar = Instance.new("Frame")
TabsBar.Size = UDim2.new(1, 0, 0, 35)
TabsBar.Position = UDim2.new(0, 0, 0, 30)
TabsBar.BackgroundTransparency = 1
TabsBar.Parent = Frame

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -65)
Content.Position = UDim2.new(0, 0, 0, 65)
Content.BackgroundTransparency = 1
Content.Parent = Frame

-- Minimize Logic
local minimized = false
local normalSize = Frame.Size

MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Content.Visible = false
		TabsBar.Visible = false
		Frame.Size = UDim2.new(normalSize.X.Scale, normalSize.X.Offset, 0, 35)
		MinBtn.Text = "+"
	else
		Content.Visible = true
		TabsBar.Visible = true
		Frame.Size = normalSize
		MinBtn.Text = "-"
	end
end)

-- Create Tab
local function createTab(name, xPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 110, 1, 0)
	btn.Position = UDim2.new(0, xPos, 0, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Parent = TabsBar
	Instance.new("UICorner", btn)

	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.CanvasSize = UDim2.new(0, 0, 3, 0)
	page.ScrollBarThickness = 8
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = Content

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(Content:GetChildren()) do
			if v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end
		page.Visible = true
	end)

	return page
end

-- Tabs
local MainTab = createTab("Main", 0)
local ScriptsTab = createTab("Scripts", 120)
MainTab.Visible = true

-- Button creator
local function createButton(parent, text, yPos, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 220, 0, 40)
	b.Position = UDim2.new(0.5, -110, 0, yPos)
	b.Text = text
	b.BackgroundColor3 = color
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.Parent = parent
	Instance.new("UICorner", b)
	return b
end

-- Main Buttons
createButton(MainTab, "Teleport to Spawn", 15, Color3.fromRGB(50,150,250)).MouseButton1Click:Connect(function()
	local c = Player.Character or Player.CharacterAdded:Wait()
	c.HumanoidRootPart.CFrame = CFrame.new(124, 3.1, 1)
end)

createButton(MainTab, "Go to End", 65, Color3.fromRGB(50,250,150)).MouseButton1Click:Connect(function()
	local c = Player.Character or Player.CharacterAdded:Wait()
	c.HumanoidRootPart.CFrame = CFrame.new(2606, -2.84, 1)
end)

createButton(MainTab, "Delete Tsunami", 115, Color3.fromRGB(250,80,80)).MouseButton1Click:Connect(function()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and (v.Name == "Hitbox" or v.Name == "TsunamiWave") then
			v:Destroy()
		end
	end
end)

-- Auto Collect
local autoCollect = false
local AutoBtn = createButton(MainTab, "Auto Collect Money", 165, Color3.fromRGB(80,150,250))

AutoBtn.MouseButton1Click:Connect(function()
	autoCollect = not autoCollect
	AutoBtn.Text = autoCollect and "Stop Auto Collect" or "Auto Collect Money"

	task.spawn(function()
		while autoCollect do
			local char = Player.Character or Player.CharacterAdded:Wait()
			local saveCF = char.HumanoidRootPart.CFrame

			for b = 1,4 do
				for s = 1,30 do
					if not autoCollect then break end
					local base = workspace.Bases:FindFirstChild("Base"..b)
					local slot = base and base:FindFirstChild("Slots") and base.Slots:FindFirstChild("Slot"..s)
					if slot and slot:FindFirstChild("Collect") then
						char.HumanoidRootPart.CFrame = slot.Collect.CFrame + Vector3.new(0,3,0)
						task.wait(0.01)
					end
				end
			end

			char.HumanoidRootPart.CFrame = saveCF
			task.wait(60)
		end
	end)
end)

-- Script Tab
createButton(ScriptsTab, "Instant Proximity", 15, Color3.fromRGB(80,80,80)).MouseButton1Click:Connect(function()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			v.HoldDuration = 0
		end
	end
end)

-- Toggle GUI (L)
UIS.InputBegan:Connect(function(i,g)
	if not g and i.KeyCode == Enum.KeyCode.L then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

-- Drag GUI (Stable)
local dragging, dragStart, startPos
Frame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = Frame.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
