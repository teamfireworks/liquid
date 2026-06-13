local RunService = game:GetService "RunService"

local Fluid = require "../roblox_packages/Fluid"

local function useLifetime(): () -> number
	local lifetime = Fluid.source(0)
	Fluid.cleanup(RunService.PreRender:Connect(function(dt) lifetime(lifetime() + dt) end))
	return lifetime
end

return useLifetime
