const useDissolved = require "./useDissolved"
const Fluid = require "../roblox_packages/Fluid"

local function forKeys<KI, KO, V>(values: Fluid.UsedAs<{ [KI]: V }>, map: (KI) -> KO): Fluid.UsedAs<{ [KO]: V }>
	return useDissolved(function(read: useDissolved.Read)
		local result = {}
		for key, value in read<<{ [KI]: V }>>(values) do
			result[map(key)] = value
		end
		return result
	end)
end

return forKeys
