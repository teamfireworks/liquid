local Workspace = game:GetService "Workspace"

local Fluid = require "../roblox_packages/Fluid"

local function useCamera()
	local camera = Fluid.source(Workspace.CurrentCamera)
	Fluid.cleanup(Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		if Workspace.CurrentCamera then camera(Workspace.CurrentCamera) end
	end))
	return camera
end

return useCamera
