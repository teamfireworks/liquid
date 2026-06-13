local Fluid = require "../roblox_packages/Fluid"
local useDissolved = require "./useDissolved"

const function useShow<T, Args...>(condition: Fluid.UsedAs<unknown>, callback: (Args...) -> T, ...: Args...): Fluid.UsedAs<T?>
	const props = table.pack(... :: any)
	return useDissolved(
		function(read) return if read(condition) then callback(table.unpack(props, 1, props.n)) else nil end
	)
end

return useShow
