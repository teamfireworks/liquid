local Fluid = require "../roblox_packages/Fluid"
local useCamera = require "./useCamera"

const BASE_REM = 16
const MIN_REM = 10
const BASE_RESOLUTION = Vector2.new(1280, 832)
const DOMINANT_AXIS = 0.5

const Rem = {}
Rem.__index = Rem

export type Rem = setmetatable<{ rem: () -> number }, typeof(Rem)>

function Rem.__call(self: Rem, value: Fluid.UsedAs<number>, mode: Fluid.UsedAs<"scale" | "offset">?)
	return if Fluid.read(mode) == "scale" then self:scale(value) else self:px(value)
end

function Rem.scale(self: Rem, value: Fluid.UsedAs<number>) return Fluid.read(value) * self.rem() / BASE_REM end

function Rem.intoScale(self: Rem, value: Fluid.UsedAs<number>)
	return function() return self:scale(value) end
end

function Rem.px(self: Rem, value: Fluid.UsedAs<number>) return Fluid.read(value) * self.rem() end

function Rem.intoPx(self: Rem, value: Fluid.UsedAs<number>)
	return function() return self:px(value) end
end

function Rem.udim(self: Rem, value: Fluid.UsedAs<number>, mode: Fluid.UsedAs<"scale" | "offset">?): UDim
	return if mode == "scale" then UDim.new(self:scale(value), 0) else UDim.new(0, self:px(value))
end

function Rem.intoUdim(self: Rem, value: Fluid.UsedAs<number>, mode: Fluid.UsedAs<"scale" | "offset">?)
	return function() return self:udim(value, mode) end
end

function Rem.udim2(
	self: Rem,
	x: Fluid.UsedAs<number>,
	y: Fluid.UsedAs<number>,
	mode: Fluid.UsedAs<"scale" | "offset">?
): UDim2
	return if mode == "scale"
		then UDim2.fromScale(self:scale(x), self:scale(y))
		else UDim2.fromOffset(self:px(x), self:px(y))
end

function Rem.intoUdim2(
	self: Rem,
	x: Fluid.UsedAs<number>,
	y: Fluid.UsedAs<number>,
	mode: Fluid.UsedAs<"scale" | "offset">?
)
	return function() return self:udim2(x, y, mode) end
end

local function useRem(): Rem
	local camera = useCamera()

	return setmetatable({
		rem = function()
			local viewport = camera().ViewportSize

			local width = math.log(viewport.X / BASE_RESOLUTION.X, 2)
			local height = math.log(viewport.Y / BASE_RESOLUTION.Y, 2)
			local centered = width + (height - width) * DOMINANT_AXIS

			return math.max(2 ^ centered, MIN_REM)
		end,
	}, Rem)
end

table.freeze(Rem)
return useRem
