local RunService = game:GetService "RunService"

local Fluid = require "../roblox_packages/Fluid"

local function useOsClock(): () -> number
	local clock = Fluid.source(os.clock())
	Fluid.cleanup(RunService.PreRender:Connect(function(dt) clock(os.clock()) end))
	return clock
end

return useOsClock
