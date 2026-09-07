-- // Functions //
local TwoWayTeleporterScript = {}

function TwoWayTeleporterScript.Client(Teleporter: Model)
    -- // Variables & Objects //
    local Position0: Part =  Teleporter:WaitForChild("Position0")
    local Position1: Part =  Teleporter:WaitForChild("Position1")
    local IsInvisible: boolean = Teleporter:WaitForChild("IsInvisible").Value
    local Active = false
    local Debounce = Teleporter:WaitForChild("Debounce").Value
    -- // Variables & Objects //

    if IsInvisible == true then
        Position0.Transparency = 1
        Position1.Transparency = 1
    end

    Position0.Touched:Connect(function(Player)

		if Active then return end

		if Player.Parent:FindFirstChild("HumanoidRootPart") then

			Active = true

			Player.Parent.HumanoidRootPart.CFrame = Position1.CFrame

			local ForceField = Instance.new("ForceField")
			
			ForceField.Parent = Player.Parent
			
			task.wait(Debounce)
			
			if ForceField then ForceField:Destroy() end

		end

		Active = false
	end)
	
	Position1.Touched:Connect(function(Player)

		if Active then return end

		if Player.Parent:FindFirstChild("HumanoidRootPart") then

			Active = true

			Player.Parent.HumanoidRootPart.CFrame = Position0.CFrame

			local ForceField = Instance.new("ForceField")

			ForceField.Parent = Player.Parent

			task.wait(Debounce)

			if ForceField then ForceField:Destroy() end

		end

		Active = false
	end)

end

return TwoWayTeleporterScript
