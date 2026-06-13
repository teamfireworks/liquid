local Fluid = require "../roblox_packages/Fluid"

local function useDelay<T>(delaySeconds: Fluid.UsedAs<number>, observed: Fluid.UsedAs<T>): () -> T
	local delayed = Fluid.source(Fluid.read(observed))
	Fluid.effect(function()
		local newObserved = Fluid.read(observed)
		Fluid.cleanup(
			task.delay(
				Fluid.read(delaySeconds),
				function(delayed: typeof(delayed), newObserved: typeof(newObserved)) delayed(newObserved) end,
				delayed,
				newObserved
			)
		)
	end)
	return delayed
end

return useDelay
