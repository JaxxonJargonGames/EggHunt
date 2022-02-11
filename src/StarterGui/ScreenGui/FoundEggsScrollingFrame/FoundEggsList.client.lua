local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local FoundEggsListEvent = ReplicatedFirst:WaitForChild("FoundEggsListEvent")

local foundEggsCount = 0
local foundEggsList = {}

local function getTextLabel(text)
	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 0
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Size = UDim2.new(0, 280, 0, 40)
	textLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
	textLabel.Text = text
	textLabel.TextColor3 = Color3.new(255, 255, 255)
	textLabel.TextSize = 20
	textLabel.TextStrokeTransparency = 0
	textLabel.Visible = true
	return textLabel
end

FoundEggsListEvent.Event:Connect(function(egg)
	foundEggsCount += 1
	local text = "#" .. tostring(foundEggsCount) .. ": " .. tostring(egg.BrickColor)
	local textLabel = getTextLabel(text)
	textLabel.BackgroundColor3 = egg.Color
	textLabel.Parent = script.Parent
end)
