-- // Services //
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- // Services //

-- // Config //
local Config = require(ReplicatedStorage.Shared.Config.Configuration)
-- // Config //

-- // Folders //
local FolderName: string = Config.MainFolderName
local InteractableObjects = Workspace:FindFirstChild(FolderName)
if not (InteractableObjects and InteractableObjects:IsA("Folder")) then error("Could not find folder named " .. FolderName) end

local SharedFolder = ReplicatedStorage.Shared
local ClientObjectScripts = SharedFolder.ClientObjects
local ServerObjectScripts = SharedFolder.ServerObjects

local ClientObjects = InteractableObjects:WaitForChild("ClientObjects")
local ServerObjects = InteractableObjects:WaitForChild("ServerObjects")
-- // Folders //

local ObjectsLoader = {
    StartedObjects = {},
}

-- Runs the scripts in the folder
local function RunScripts(self, scriptfolder: Folder, objectsfolder: Folder, newObject: Instance?)

    for i, script: ModuleScript in scriptfolder:GetChildren() do 

        local ScriptName: string = script.Name
        local Matches = {}

        local objects = if newObject then { newObject } else objectsfolder:GetDescendants()

        for j, object: Instance in objects do
            if object.Name == ScriptName then 
                table.insert(Matches, object)
            end
        end

        local module = require(script)

        if scriptfolder.Name == "ClientObjects" then 
            for i, Obj in Matches do 
                if not self.StartedObjects[Obj] then
                    self.StartedObjects[Obj] = true
                    task.spawn(module.Client, Obj)
                end
            end
        end

        if scriptfolder.Name == "ServerObjects" then 
            for i, Obj in Matches do 
                if not self.StartedObjects[Obj] then
                    self.StartedObjects[Obj] = true
                    task.spawn(module.Server, Obj)
                end
            end 
        end

    end
end

function ObjectsLoader:RunAllClient()
    if self.ClientConnection then return end

    self.ClientConnection = ClientObjects.DescendantAdded:Connect(function(object)
        RunScripts(self, ClientObjectScripts, ClientObjects, object)
    end)

    RunScripts(self, ClientObjectScripts, ClientObjects)
end

function ObjectsLoader:RunAllServer()
    if self.ServerConnection then return end

    self.ServerConnection = ServerObjects.DescendantAdded:Connect(function(object)
        RunScripts(self, ServerObjectScripts, ServerObjects, object)
    end)

    RunScripts(self, ServerObjectScripts, ServerObjects)
end

return ObjectsLoader