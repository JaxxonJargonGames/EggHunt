local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local EggCollectedEvent = ReplicatedStorage:WaitForChild("EggCollectedEvent")

EggCollectedEvent.OnServerEvent:Connect(function(player, position)
	local butterfly = ServerStorage:WaitForChild("Butterfly"):Clone()
	butterfly.GEO_Butterfly_01.Position = position
	butterfly.Parent = workspace.Butterflies
end)
