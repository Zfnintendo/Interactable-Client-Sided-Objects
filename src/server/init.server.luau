-- // Services //
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- // Services //

-- // Folders //
local SharedFolder = ReplicatedStorage.Shared
local ReplicatedLibrary = SharedFolder.SharedLibrary
-- // Folders //

-- // Modules //
local ObjectsLoader = require(ReplicatedLibrary.ObjectsLoader)
-- // Modules //

ObjectsLoader:RunAllServer()