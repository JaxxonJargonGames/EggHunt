local CollectionService = game:GetService("CollectionService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local SoundService = game:GetService("SoundService")

local EggCollectedEvent = ReplicatedStorage:WaitForChild("EggCollectedEvent")
local FoundEggsListEvent = ReplicatedFirst:WaitForChild("FoundEggsListEvent")

local function getApplause()
	local applauseSound = Instance.new("Sound")
	applauseSound.SoundId = "rbxassetid://1869741275" -- Applause.
	applauseSound.Volume = 5
	return applauseSound
end

local function getExplosion()
	local explosion = Instance.new("ParticleEmitter")
	explosion.Enabled = false
	explosion.Texture = "rbxassetid://6101261905" -- Sort of looks like confetti.
	explosion.Drag = 10
	explosion.Lifetime = NumberRange.new(0.2, 0.6)
	explosion.Speed = NumberRange.new(20, 40)
	explosion.SpreadAngle = Vector2.new(180, 180)
	return explosion
end

local function getIndicator()
	local indicator = Instance.new("Attachment")
	indicator.Name = "Indicator"
	indicator.Position = Vector3.new(0, 3, 0)
	indicator:SetAttribute("Color", BrickColor.new("Lime green").Color)
	indicator:SetAttribute("Enabled", true)
	indicator:SetAttribute("Image", "rbxassetid://8239527343") -- Target.
	indicator:SetAttribute("Team", BrickColor.new("White"))
	return indicator
end

local function getNatureSound()
	local natureSound = Instance.new("Sound")
	natureSound.Looped = true
	-- Drop off quickly so the player knows when they are close to an egg and when they are not.
	natureSound.RollOffMaxDistance = 20
	natureSound.SoundId = "rbxassetid://169736440" -- ForestAmbienceVar2 (birds chirping, etc.)
	natureSound.Volume = 3
	return natureSound
end

for _, item in ipairs(workspace.HiddenEggs:GetChildren()) do
	local egg
	local gem
	local hasGem = item:FindFirstChild("Gem")
	if hasGem then
		-- item is a model containing an Egg and a Gem.
		egg = item.Egg
		gem = item.Gem
		CollectionService:AddTag(gem, "Gem") -- Tagged for the minimap.
	else
		-- item is an Egg with no Gem.
		egg = item
	end
	-- Diplay the prompt 5 studs above the egg to be more clearly visible.
	local attachment = Instance.new("Attachment")
	attachment.Position = Vector3.new(0, 5, 0)
	attachment.Parent = egg
	egg.Anchored = true
	-- Assign a random color to the egg so it is different each time the game is played.
	egg.BrickColor = BrickColor.random()
	-- Update the location indicator to match the egg color.
	local explosion = getExplosion()
	explosion.Parent = egg
	local indicator = getIndicator()
	indicator:SetAttribute("Color", egg.BrickColor.Color)
	indicator.Parent = egg
	local natureSound = getNatureSound()
	natureSound.Parent = egg
	natureSound:Play() -- Birds chirping, etc.
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Collect Egg"
	-- Default is 10, but we want the player to be closer to the egg than that.
	prompt.MaxActivationDistance = 5
	-- Include the randomly assigned egg color to the text displayed in the proximity prompt.
	prompt.ObjectText = tostring(egg.BrickColor) .. " egg"
	prompt.Parent = attachment
	prompt.Triggered:Connect(function(player)
		explosion:Emit(300) -- Lots of "confetti" (sort of).
		local position = egg.Position + Vector3.new(0, 4, 0)
		-- Assign points and other server-side activity when an egg is collected.
		EggCollectedEvent:FireServer(position)
		-- Keep track of found eggs for a UI list.
		FoundEggsListEvent:Fire(egg)
		egg.Transparency = 1
		if hasGem then
			gem.Material = Enum.Material.Plastic
			-- Untagged so the gem is removed from the minimap.
			CollectionService:RemoveTag(gem, "Gem")
		end
		-- Move the egg from the HiddenEggs folder to the FoundEggs folder.
		item.Parent = workspace.FoundEggs
		indicator:Destroy()
		natureSound:Stop()
		prompt.Enabled = false
		local applauseSound = getApplause()
		applauseSound.Parent = egg
		applauseSound:Play()
		applauseSound.Parent = SoundService
	end)
end
