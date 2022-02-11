local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")

local ElapsedTimeEvent = ReplicatedFirst:WaitForChild("ElapsedTimeEvent")
local TimeOfDayEvent = ReplicatedFirst:WaitForChild("TimeOfDayEvent")

local Icon = require(ReplicatedStorage.Icon)
local IconController = require(ReplicatedStorage.Icon.IconController)
local Themes = require(ReplicatedStorage.Icon.Themes)

local player = Players.LocalPlayer
local Minimap = require(player.PlayerScripts:WaitForChild("Minimap"))

local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

local foundEggsFrame = screenGui:WaitForChild("FoundEggsScrollingFrame")
local helpTextLabel = screenGui:WaitForChild("HelpTextLabel")

IconController.setGameTheme(Themes["BlueGradient"])

local function canSendGameInvite(targetPlayer)
	local success, canSend = pcall(function()
		return SocialService:CanSendGameInviteAsync(targetPlayer)
	end)
	return success and canSend
end

local function promptGameInvite(targetPlayer)
	local success, canInvite = pcall(function()
		return SocialService:PromptGameInvite(targetPlayer)
	end)
	return success and canInvite
end

local function openGameInvitePrompt(targetPlayer)
	local canInvite = canSendGameInvite(targetPlayer)
	if canInvite then
		local promptOpened = promptGameInvite(targetPlayer)
		return promptOpened
	end
	return false
end

local elapsedTimeIcon = Icon.new()
:lock()
:setLabel("Elapsed:")

ElapsedTimeEvent.Event:Connect(function(elapsedTime)
	elapsedTimeIcon:setLabel("Elapsed: " .. tostring(elapsedTime))
end)

local foundEggsIcon = Icon.new()
:setLabel("Eggs")
:setMid()
:bindToggleItem(foundEggsFrame)

helpTextLabel.Text = 
	"Welcome to Jaxxon Jargon's Egg Hunt. "
	.. "Your goal is to find as many eggs as you can. "
	.. "When you get close to an egg you will see a prompt that lets you collect that egg. "
	.. "The glowing gems are a hint that an egg is in the area. "
	.. "When you collect an egg the gem no longer glows and your jump power and walk speed go up. "
	.. "Points are scored by collecting an egg (1 point) and by "
	.. "displaying your eggs in the basket by the Ferris Wheel. (2 points for each egg.)"

local helpIcon = Icon.new()
:setLabel("Help")
:setMid()
:bindToggleItem(helpTextLabel)

local mapIcon = Icon.new()
:setLabel("Map")
:setMid()
:bindEvent("selected", function(self)
	Minimap:Toggle()
	self:deselect()
end)

local inviteFriendsIcon = Icon.new()
:setLabel("Invite")
:setMid()
:bindEvent("selected", function(self)
	openGameInvitePrompt(player)
	self:deselect()
end)

local timeOfDayIcon = Icon.new()
:lock()
:setLabel("Time Of Day")
:setRight()

TimeOfDayEvent.Event:Connect(function(timeOfDay)
	timeOfDayIcon:setLabel(timeOfDay)
end)
