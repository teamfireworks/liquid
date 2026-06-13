const Fluid = require "../roblox_packages/Fluid"

const function getUnsafe(instance: Instance, propertyName: string) return (instance :: any)[propertyName] end

const function outProperty(propertyName: string, source: (any) -> any)
	return Fluid.action(function(instance)
		source(getUnsafe(instance, propertyName))
		Fluid.cleanup(
			instance
				:GetPropertyChangedSignal(propertyName)
				:Connect(function() source(getUnsafe(instance, propertyName)) end)
		)
	end)
end

return outProperty
