local Fluid = require "../roblox_packages/Fluid"
local useDissolved = require "./useDissolved"

local function forRange<T>(
	map: (index: number) -> T,
	startingIndex: Fluid.UsedAs<number>,
	endingIndex: Fluid.UsedAs<number>,
	step: Fluid.UsedAs<number>?
): Fluid.UsedAs<{ T }>
	return useDissolved(function(read: useDissolved.Read)
		local startingIndex = read<<number>>(startingIndex)
		local endingIndex = read<<number>>(endingIndex)
		local step = read<<number>>(step or 1)

		local result = table.create(endingIndex - startingIndex)
		for index = startingIndex, endingIndex, step do
			result[index] = map(index)
		end

		return result
	end)
end

return forRange
