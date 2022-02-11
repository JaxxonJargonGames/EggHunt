local Players = game:GetService("Players")

game.Players.CharacterAutoLoads = false

local function getIndicator()
	local indicator = Instance.new("Attachment")
	indicator.Name = "Indicator"
	indicator:SetAttribute("Color", BrickColor.new("Lime green").Color)
	indicator:SetAttribute("Enabled", true)
	indicator:SetAttribute("Image", "rbxassetid://8239526542") -- Star.
	indicator:SetAttribute("Team", BrickColor.new("White"))
	return indicator
end

-- Tag all players except the LocalPlayer.
local function onPlayerAdded(player)
	if player ~= Players.LocalPlayer then
		player.CharacterAdded:Connect(function(character)
			local indicator = getIndicator()
			indicator.Parent = character:WaitForChild("HumanoidRootPart")
		end)
	end
end

for _, player in pairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end
Players.PlayerAdded:Connect(onPlayerAdded)
