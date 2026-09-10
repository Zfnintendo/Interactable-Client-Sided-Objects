-- // Functions //
local OneWayTeleporterScript = {}

function OneWayTeleporterScript.Client(Teleporter: Model)
    -- // Variables & Objects //
    local Start: Part = Teleporter:WaitForChild("Start")
    local End: Part = Teleporter:WaitForChild("End")
    local IsInvisible: boolean = Teleporter:WaitForChild("IsInvisible").Value
    local ForceFieldDuration: number = Teleporter:WaitForChild("ForceFieldDuration").Value
    local Active = false
    -- // Variables & Objects //
    if IsInvisible == true then
        Start.Transparency = 1
        End.Transparency = 1
    end
    
    Start.Touched:Connect(function(Player)

        if Active then return end

        if Player.Parent:FindFirstChild("HumanoidRootPart") then

            Active = true

            Player.Parent.HumanoidRootPart.CFrame = End.CFrame

            local ForceField = Instance.new("ForceField")
            
            ForceField.Parent = Player.Parent
            
            task.delay(ForceFieldDuration, function()
                if ForceField then ForceField:Destroy() end
            end)

        end

        Active = false
    end)

end

return OneWayTeleporterScript
-- // Functions //

