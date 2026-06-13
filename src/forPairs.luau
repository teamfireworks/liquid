const useDissolved = require "./useDissolved"
const Fluid = require "../roblox_packages/Fluid"

local function forPairs<KI, VI, KO, VO>(pairs: Fluid.UsedAs<{ [KI]: VI }>, map: (KI, VI) -> (KO, VO)): Fluid.UsedAs<{ [KO]: VO }>
	return useDissolved(function(read: useDissolved.Read)
		local keys = read(pairs) :: { [KI]: VI }
		local result = {}
		for key, value in keys do
			local newKey, newValue = map(key, value)
			result[newKey] = newValue
		end
		return result
	end)
end

return forPairs
