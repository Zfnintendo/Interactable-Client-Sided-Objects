-- // Functions //
local JumpPadScript = {}

function JumpPadScript.Client(Pad: Part)
    -- // Variables & Objects //
    local JumpPower: NumberValue = Pad:WaitForChild("JumpPower")
    local PlayerTouching = nil
    -- // Variables & Objects //

    Pad.Touched:Connect(function(Hit)
    
        local Character = Hit.Parent
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if not Humanoid then return end

        if not PlayerTouching then

            PlayerTouching = {
                Humanoid = Humanoid,
                Parts = {},
                OriginalJumpPower = Humanoid.JumpPower
            }

            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = JumpPower.Value

        end

        PlayerTouching.Parts[Hit] = true

    end)

    Pad.TouchEnded:Connect(function(Hit)
    
        local Character = Hit.Parent
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if not Humanoid then return end
        
        if not PlayerTouching then return end

        PlayerTouching.Parts[Hit] =  nil

        if next(PlayerTouching.Parts) == nil then

            Humanoid.JumpPower = PlayerTouching.OriginalJumpPower

            PlayerTouching = nil

        end

    end)

end

return JumpPadScript
