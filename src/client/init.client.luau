-- // Services //
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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