-- // Services //
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
-- // Services //

-- // Config // 
local Config = require(ReplicatedStorage.Shared.Config.Configuration)
-- // Config //

-- // Folders //
local SharedFolder = ReplicatedStorage.Shared
local ClientObjectScripts = SharedFolder.ClientObjects
local ServerObjectScripts = SharedFolder.ServerObjects
local ReplicatedLibrary = SharedFolder.SharedLibrary

local InteractableObjects = Workspace:FindFirstChild(Config.MainFolderName)
local ClientObjects = InteractableObjects:FindFirstChild("ClientObjects")
local ServerObjects = InteractableObjects:FindFirstChild("ServerObjects")
-- // Folders //

-- // Modules //
-- // Modules //
