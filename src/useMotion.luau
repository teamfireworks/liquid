local RunService = game:GetService "RunService"

local Fluid = require "../roblox_packages/Fluid"
local Ripple = require "../roblox_packages/Ripple"

local function useMotion<T>(initialValue: T, options: Ripple.MotionOptions?): (() -> T, Ripple.Motion<T>)
	local motion = Ripple.createMotion(initialValue, options)
	local motionValue = Fluid.source(initialValue)

	Fluid.cleanup(RunService.PreRender:Connect(function(dt)
		local value = motion:step(dt)
		motionValue(value)
	end))

	return motionValue, motion
end

return useMotion
