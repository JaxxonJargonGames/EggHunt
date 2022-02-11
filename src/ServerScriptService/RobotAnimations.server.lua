local animations = {
	"507770677", -- cheer
	"616156119", -- climb
	"507771019", -- dance A1
	"507776043", -- dance B1
	"507777268", -- dance C1
	"507770818", -- laugh
	"507770453", -- point
	"885545458", -- pose
	"3489173414", -- run
	"3489174223", -- walk
	"507770239", -- wave
}

local random = Random.new()

local function animate(id, animator)
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://" .. id
	local animationTrack = animator:LoadAnimation(animation)
	animationTrack.Looped = false
	animationTrack:Play()
end

while task.wait(0.1) do
	for _, robot in ipairs(workspace["Robots"]:GetChildren()) do
		local humanoid = robot:FindFirstChild("Humanoid")
		if humanoid then
			local animator = humanoid:WaitForChild("Animator")
			local index = random:NextInteger(1, #animations)
			local id = animations[index]
			animate(id, animator)
			task.wait(math.random())
		end
	end
end
