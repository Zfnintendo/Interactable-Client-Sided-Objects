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

local ClientObjects = InteractableObjects:FindFirstChild("ClientObjects")
local ServerObjects = InteractableObjects:FindFirstChild("ServerObjects")
-- // Folders //

local ObjectsLoader = {}

-- Loads and saves all the objects in the given folder in the props of this class.
function ObjectsLoader:Init(folder: Folder)

    for i, Instance: Instance in folder:GetChildren() do

        if not table.find(self.KnownObjects, Instance) then

            table.insert(self.KnownObjects, Instance) -- Save the known/scanned objects
            self.ObjectProps[Instance] = Instance:GetChildren()

        end

    end

    ObjectsLoader:PropertyHandler()

end

-- Runs all objects stored in this class.
function ObjectsLoader:PropertyHandler()

    for i, Instance in self.KnownObjects do 
        for j, Props in self.ObjectProps[Instance] do 
            for l, Property in Props do 
                
                local Values = {}


                if Property:IsA("ValueBase") then 
                    table.insert(Values, Property)
                    self.PropsValues[Instance] = Values
                end

            end
        end
    end
end

-- Runs the scripts in the folder
local function RunScripts(self, scriptfolder: Folder, objectsfolder: Folder)
    for i, script: ModuleScript in scriptfolder:GetChildren() do 

        local ScriptName: string = script.Name
        local Matches = {}

        for j, object: Instance in objectsfolder:GetChildren() do 
            if object.Name == ScriptName then 
                table.insert(Matches, object)
            end
        end

        if scriptfolder.Name == "ClientObjects" then 
            for i, Obj in Matches do 
                script.client(Obj, self.PropsValues[Obj])
            end
        end

        if scriptfolder.Name == "ServerObjects" then 
            for i, Obj in Matches do 
                script.server(Obj, self.PropsValues[Obj])
            end 
        end

    end
end

function ObjectsLoader:RunAllClient()
    RunScripts(ClientObjectScripts, ClientObjects)
end

function ObjectsLoader:RunAllServer() 
    RunScripts(ServerObjectScripts, ServerObjects)
end

return ObjectsLoader