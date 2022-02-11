local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FriendsLocator = require(ReplicatedStorage:WaitForChild("FriendsLocator"))

FriendsLocator.configure({
	alwaysOnTop = true,
	showAllPlayers = false,
	teleportToFriend = true,
	thresholdDistance = 100,
	maxLocators = 10
})
