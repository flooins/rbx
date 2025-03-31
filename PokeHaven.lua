local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 115,0, 56)
toggleButton.Position = UDim2.new(0.659, 0,-0.05, 0)
toggleButton.Text = "Start"
toggleButton.Parent = screenGui

local isFiring = false
local firingCoroutine = nil
local Humanoid : Humanoid = player.Character:WaitForChild('Humanoid')
Humanoid.Died:Connect(Reset)

local function toggleFiring()
	if isFiring then
		isFiring = false
		if firingCoroutine then
			coroutine.close(firingCoroutine)
			firingCoroutine = nil
		end
		toggleButton.Text = "Start"
	else
		isFiring = true
		toggleButton.Text = "Stop"
		firingCoroutine = coroutine.create(function()
			while isFiring do
				for _, item in ipairs(workspace.GameAssets.PlacedItems:GetChildren()) do
                    if not item:FindFirstChild("Handle") then continue end
                    if not item["Handle"]:FindFirstChild("ClickDetector") then continue end

                    if string.find(item.Name,"Jar") or string.find(item.Name,"Tray") or string.find(item.Name,"Trash") or string.find(item.Name,"Ship") or string.find(item.Name,"Vending") or string.find(item.Name,"Chest")or string.find(item.Name,"Box")then continue end
                    fireclickdetector(item["Handle"]:FindFirstChild("ClickDetector"))

                end
                wait(0.4)
			end
		end)
		coroutine.resume(firingCoroutine)
	end
end
toggleButton.MouseButton1Click:Connect(toggleFiring)
