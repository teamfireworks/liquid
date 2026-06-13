const Fluid = require "../roblox_packages/Fluid"
const types = require "./types"

local function useDissolved<T>(source: (read: types.Read) -> T): Fluid.UsedAs<T>
	local isDependencyRead = false

	local function mockRead(value: unknown)
		if typeof(value) == "function" then
			isDependencyRead = true
			error "used dependency"
		end
		return value
	end

	local initialSuccess, dissolvedOrError = pcall(source, mockRead :: never)

	return if initialSuccess
		then dissolvedOrError
		elseif isDependencyRead then function() return source(Fluid.read :: never) end
		else error(`Dissolving source threw an error: {dissolvedOrError}`)
end

return useDissolved
