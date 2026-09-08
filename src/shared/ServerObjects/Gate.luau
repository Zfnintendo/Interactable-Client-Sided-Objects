-- // Services //
local TweenService = game:GetService("TweenService")
-- // Services //

-- // Functions //
local GateScript = {}

function GateScript.Server(GateFolder: Folder)
    -- // Variables & Objects //
    local StartState: BoolValue = GateFolder:WaitForChild("StartState")

    local Parts: Folder = GateFolder:WaitForChild("Parts")
    
    local Button: Part = Parts:WaitForChild("Button")
    local ProximityPrompt: ProximityPrompt = Button:WaitForChild("ProximityPrompt")
    local Gate: Part = Parts:WaitForChild("Gate")
    local Position0: Part = Parts:WaitForChild("Position0")
    local Position1: Part = Parts:WaitForChild("Position1")

    local Colors: Folder = GateFolder:WaitForChild("Colors")
    local ClosedColor: Color3Value = Colors:WaitForChild("ClosedColor")
    local OpenColor: Color3Value = Colors:WaitForChild("OpenColor")
    local TransitionColor: Color3Value = Colors:WaitForChild("TransitionColor")
    -- // Variables & Objects //

    -- // TweenService Propertires //
    local TweenTime: number = GateFolder:WaitForChild("TweenTime").Value
    local EasingStyle: Enum = GateFolder:WaitForChild("EasingStyle"):GetAttribute("EasingStyle")
    local EasingDirection: Enum = GateFolder:WaitForChild("EasingDirection"):GetAttribute("EasingDirection")
    local TweeningInfo = TweenInfo.new(TweenTime, EasingStyle, EasingDirection)
    local FirstPosition = { Position = Position0.Position }
    local SecondPosition = { Position = Position1.Position }
    -- // TweenService Propertires //

    if StartState.Value == true then
        Gate.Position = Position0.Position
    else 
        Gate.Position = Position1.Position
    end

    Position0.Transparency = 1
    Position1.Transparency = 1

    ProximityPrompt.Triggered:Connect(function(Player)
        
        if StartState.Value == true then

            Gate.Position = Position0.Position

            Button.Color = TransitionColor.Value

            TweenService:Create(Gate, TweeningInfo, SecondPosition):Play()

            task.delay(TweenTime, function()

                Button.Color = ClosedColor.Value
                ProximityPrompt.ActionText = "[Open]"

                StartState.Value = false

            end)

        else

            Gate.Position = Position1.Position

            Button.Color = TransitionColor.Value

            TweenService:Create(Gate, TweeningInfo, FirstPosition):Play()

            task.delay(TweenTime, function()

                Button.Color = OpenColor.Value
                ProximityPrompt.ActionText = "[Open]"

                StartState.Value = true

            end)

        end
    
    end)

end

return GateScript
-- // Functions //