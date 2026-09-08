-- // Service //
local Workspace = game:GetService("Workspace")
-- // Service //

-- // Functions //
local BouncePadScript = {}

function BouncePadScript.Client(Pad: Part)

    -- // Variables & Objects //
    local Sfx= Pad:WaitForChild("SoundEffects")
    local Active = false

    local Power: number = Pad:WaitForChild("Power").Value
    Power = math.sqrt(2 * Workspace.Gravity * Power) -- Some math that determines how high the thing is depending on the power idk (BASICALLY POWER = THE DISTANCE OF THE JUMP)
    -- // Variables & Objects //

    Pad.Touched:Connect(function(Hit)

        if Active == true then return end

        Active = true

        if Hit.Parent:FindFirstChild("HumanoidRootPart") then
        
            local HumanoidRootPart = Hit.Parent.HumanoidRootPart

            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X, Power, HumanoidRootPart.AssemblyLinearVelocity.Z)

            Sfx:Play()

        end

        Active = false

    end)

end

return BouncePadScript
