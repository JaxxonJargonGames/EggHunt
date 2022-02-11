local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local EggDisplayedEvent = ReplicatedStorage:WaitForChild("EggDisplayedEvent")

local basket = workspace.EggBasket.Basket.Basket
local player = game.Players.LocalPlayer
local prompt = basket.Attachment.ProximityPrompt

local applauseSound = Instance.new("Sound")
applauseSound.SoundId = "rbxassetid://1869741275" -- Applause.
applauseSound.Volume = 5

local eggsGotAdded = false

local function getExplosion()
	local explosion = Instance.new("ParticleEmitter")
	explosion.Enabled = false
	explosion.Texture = "rbxassetid://6101261905"
	explosion.Drag = 10
	explosion.Lifetime = NumberRange.new(0.2, 0.6)
	explosion.Speed = NumberRange.new(20, 40)
	explosion.SpreadAngle = Vector2.new(180, 180)
	return explosion
end

prompt.Triggered:Connect(function()
	for _, item in ipairs(workspace.FoundEggs:GetChildren()) do
		if item:GetAttribute("InBasket") then
			continue
		end
		eggsGotAdded = true
		item:SetAttribute("InBasket", false)
		local egg
		local gem
		local hasGem = item:FindFirstChild("Gem")
		if hasGem then
			-- item is a model containing an Egg and a Gem.
			egg = item.Egg
			gem = item.Gem
		else
			-- item is an Egg with no Gem.
			egg = item
		end
		local basketEgg = ReplicatedStorage.Egg:Clone()
		basketEgg.Anchored = false
		basketEgg.BrickColor = egg.BrickColor
		-- Drop the egg into the basket from a slight height and offset.
		basketEgg.Position = basket.Position + Vector3.new(math.random(0, 1), 2, math.random(0, 1))
		basketEgg.Transparency = 0
		basketEgg.Parent = basket
		item:SetAttribute("InBasket", true)
		EggDisplayedEvent:FireServer()
		task.wait(0.1)
	end
	if eggsGotAdded then
		applauseSound.Parent = basket
		applauseSound:Play()
		applauseSound.Parent = SoundService
		local explosion = getExplosion()
		explosion.Parent = basket
		explosion:Emit(400)
	end
	eggsGotAdded = false
end)
