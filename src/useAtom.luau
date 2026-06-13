const Charm = require "../roblox_packages/Charm"
const Fluid = require "../roblox_packages/Fluid"

local function useAtom<T>(atom: Charm.Atom<T>): () -> T
	local source = Fluid.source(atom())
	Fluid.cleanup(Charm.effect(function() Charm.untracked(source, atom()) end))
	return source
end

return useAtom
