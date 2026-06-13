local RunService = game:GetService "RunService"

local Fluid = require "../roblox_packages/Fluid"

local function useInterval(seconds: Fluid.UsedAs<number>, callback: () -> (), immediate: boolean?)
	local timer = 0
	local connection = RunService.PreRender:Connect(function(dt)
		timer += dt
		local interval = Fluid.read(seconds)
		if timer >= Fluid.read(seconds) then
			timer -= interval
			callback()
		end
	end)

	local function cleanup() connection:Disconnect() end

	if immediate then Fluid.cleanup(task.spawn(callback)) end

	return cleanup
end

return useInterval
