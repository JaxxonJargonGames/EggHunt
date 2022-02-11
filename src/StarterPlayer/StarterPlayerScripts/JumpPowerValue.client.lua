local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local JumpPowerChangedEvent = ReplicatedStorage:WaitForChild("JumpPowerChangedEvent")

local jumpPower = require(script.Parent:WaitForChild("JumpPower"))

local player = Players.LocalPlayer

local INITIAL_JUMP_POWER = 0
local MAX_JUMP_POWER = 1000

local function setupJumpPower()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.JumpPower = INITIAL_JUMP_POWER
end

setupJumpPower()

workspace.FoundEggs.ChildAdded:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	if humanoid.JumpPower < MAX_JUMP_POWER then
		humanoid.JumpPower += 10
	end
end)

player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.JumpPower = jumpPower.currentJumpPower
end)

player.CharacterRemoving:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	jumpPower.currentJumpPower = humanoid.JumpPower
end)

JumpPowerChangedEvent.OnClientEvent:Connect(function(power)
	player.Character.Humanoid.JumpPower = power
end)