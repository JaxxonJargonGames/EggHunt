local Players = game:GetService("Players")

local walkSpeed = require(script.Parent:WaitForChild("WalkSpeed"))

local player = Players.LocalPlayer

local INITIAL_WALK_SPEED = 16
local MAX_WALK_SPEED = 48

local function setupWalkSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = INITIAL_WALK_SPEED
end

setupWalkSpeed()

workspace.FoundEggs.ChildAdded:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	if humanoid.WalkSpeed < MAX_WALK_SPEED then
		humanoid.WalkSpeed += 1
	end
end)

player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = walkSpeed.currentWalkSpeed
end)

player.CharacterRemoving:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	walkSpeed.currentWalkSpeed = humanoid.WalkSpeed
end)
