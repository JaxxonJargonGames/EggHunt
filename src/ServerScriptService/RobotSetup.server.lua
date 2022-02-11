CollectionService = game:GetService("CollectionService")
ServerStorage = game:GetService("ServerStorage")

game.Players.CharacterAutoLoads = false

local function setupRobots(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	for _, robotTemplate in ipairs(ServerStorage:WaitForChild("Robots"):GetChildren()) do
		local robot = robotTemplate:Clone()
		robot:SetAttribute("PlayerUserId", player.UserId)
		robot.HumanoidRootPart.Position = Vector3.new(108, 28, 168) -- Semi arbitrary location near the player spawn location.
		CollectionService:AddTag(robot.HumanoidRootPart, "Robot") -- Tagged for the minimap.
		robot.Parent = workspace.Robots
		task.wait(1)
	end
end

local function onPlayerAdded(player)
	setupRobots(player)
end
game.Players.PlayerAdded:Connect(onPlayerAdded)

local function onPlayerRemoving(player)
end
game.Players.PlayerRemoving:Connect(onPlayerRemoving)
