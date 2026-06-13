const useDissolved = require "./useDissolved"
const Fluid = require "../roblox_packages/Fluid"

local function forValues<VI, VO>(values: Fluid.UsedAs<{ VI }>, map: (VI) -> VO): Fluid.UsedAs<{ VO }>
	return useDissolved(function(read: useDissolved.Read)
		local values = read(values) :: { VI }
		local result = table.create(#values)
		for index, value in values do
			result[index] = map(value)
		end
		return result
	end)
end

return forValues
