local textLabel = script.Parent

local function update()
	local eggs = workspace.HiddenEggs:GetChildren()
	textLabel.Text = "Hidden Eggs: " .. #eggs
end

update()

workspace.HiddenEggs.ChildAdded:Connect(function()
	update()
end)

workspace.HiddenEggs.ChildRemoved:Connect(function()
	update()
end)
