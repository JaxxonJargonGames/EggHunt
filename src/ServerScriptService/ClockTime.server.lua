local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ClockTime = require(ReplicatedStorage:WaitForChild("ClockTime"))

-- Begin at sunset/moonrise.
local SIX_OCLOCK_AM = 6
game.Lighting.ClockTime = SIX_OCLOCK_AM

-- Increment the game clock by one minute for every second (approximately) that goes by.
while true do
	task.wait(0.1)
	if not ClockTime.ClockTimePaused then
		-- Divide this by 10 since we wait for one tenth of a second.
		game.Lighting.ClockTime += ClockTime.ONE_MINUTE / 10
	end
end
