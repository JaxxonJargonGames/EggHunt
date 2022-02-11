local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EggCollectedEvent = ReplicatedStorage:WaitForChild("EggCollectedEvent")
local EggDisplayedEvent = ReplicatedStorage:WaitForChild("EggDisplayedEvent")

local PlayerPoints = game:GetService("DataStoreService"):GetDataStore("PlayerPoints")

local STARTING_POINTS = 0
local EGG_COLLECTED_POINTS = 1
local EGG_DISPLAYED_POINTS = 2

game.Players.CharacterAutoLoads = false

EggCollectedEvent.OnServerEvent:Connect(function(player, position)
	player.leaderstats.Points.Value += EGG_COLLECTED_POINTS
end)

EggDisplayedEvent.OnServerEvent:Connect(function(player)
	player.leaderstats.Points.Value += EGG_DISPLAYED_POINTS
end)

local function onHumanoidDied(player)
	player:LoadCharacter()
end

local function onCharacterAdded(character, player)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		onHumanoidDied(player)
	end)
end

local function setupLeaderboard(player)
	local folder = Instance.new("Folder")
	folder.Name = "leaderstats"
	folder.Parent = player
	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Parent = folder
	local success, savedPlayerPoints = pcall(function()
		return PlayerPoints:GetAsync(player.UserId)
	end)
	if success then
		if savedPlayerPoints then
			points.Value = savedPlayerPoints
		else
			points.Value = STARTING_POINTS
		end
	end
end

local function onPlayerAdded(player)
	setupLeaderboard(player)
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(character, player)
	end)
	player:LoadCharacter()
end
game.Players.PlayerAdded:Connect(onPlayerAdded)

local function onPlayerRemoving(player)
	local success, errorMessage = pcall(function()
		PlayerPoints:SetAsync(player.UserId, player.leaderstats.Points.Value)
	end)
	if not success then
		warn(errorMessage)
	end
end
game.Players.PlayerRemoving:Connect(onPlayerRemoving)
