local Fluid = require "../roblox_packages/Fluid"
local useDissolved = require "./useDissolved"

local function useToggled<T>(
	condition: Fluid.UsedAs<unknown>,
	truthy: Fluid.UsedAs<T>,
	falsy: Fluid.UsedAs<T>
): Fluid.UsedAs<T>
	return useDissolved(function(read) return if read(condition) then read(truthy) else read(falsy) end)
end

return useToggled
