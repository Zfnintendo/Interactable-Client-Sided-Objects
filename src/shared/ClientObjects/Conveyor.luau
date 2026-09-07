-- // Functions //
local ConveyorScript = {}

function ConveyorScript.Client(conveyor: BasePart)
    local speed = conveyor:WaitForChild("Speed")

    assert(speed:IsA("NumberValue"), "In Conveyor. Speed must be a NumberValue")

    conveyor.Anchored = true
    conveyor.AssemblyLinearVelocity = conveyor.CFrame.LookVector * speed.Value
end

return ConveyorScript
-- // Functions //