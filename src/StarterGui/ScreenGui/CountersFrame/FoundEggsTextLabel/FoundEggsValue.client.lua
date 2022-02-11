local textLabel = script.Parent

local function update()
	local eggs = workspace.FoundEggs:GetChildren()
	textLabel.Text = "Found Eggs: " .. #eggs
end

update()

workspace.FoundEggs.ChildAdded:Connect(function()
	update()
end)

workspace.FoundEggs.ChildRemoved:Connect(function()
	update()
end)
