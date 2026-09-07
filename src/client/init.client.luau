-- // Services //
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
-- // Services //

-- // Config // 
local Config = require(ReplicatedStorage.Shared.Config.Configuration)
-- // Config //

-- // Folders //
local SharedFolder = ReplicatedStorage.Shared
local ReplicatedLibrary = SharedFolder.SharedLibrary
-- // Folders //

-- // Modules //
local ObjectsLoader = require(ReplicatedLibrary.ObjectsLoader)
-- // Modules //

ObjectsLoader:RunAllClient()