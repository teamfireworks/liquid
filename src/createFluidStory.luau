local Fluid = require "../roblox_packages/Fluid"

type function Controls(controls: type)
	assert(controls.tag == "table", "expected controls to be a table")
	for key, values in controls:properties() do
		if values.read then controls:setreadproperty(key, types.newfunction({}, { head = { values.read } })) end

		if values.write then controls:setwriteproperty(key, types.newfunction({}, { head = { values.write } })) end
	end
	return controls
end

local function createControlStates(converted: any, controls: any, creator: any)
	local states = {}

	for key, control in pairs(converted) do
		local controlValue = controls[key]

		if control.EntryType == "ControlGroup" then
			states[key] = createControlStates(control.Controls, controlValue, creator)
			continue
		end

		states[key] = creator(controlValue)
	end

	return states
end

local function updateControlStates(states: any, converted: any, controls: any, updater: any)
	for key, control in pairs(converted) do
		local controlValue = controls[key]

		if control.EntryType == "ControlGroup" then
			updateControlStates(states[key], control.Controls, controlValue, updater)
			continue
		end
		updater(states[key], controlValue)
	end
end

local function createFluidStory<C>(storyProps: {
	controls: C,
	render: ({ controls: Controls<C> }) -> Instance,
})
	return {
		controls = storyProps.controls,
		render = function(props)
			return Fluid.root(function()
				const states = createControlStates(
					props.converted,
					props.controls,
					function(value) return Fluid.source(value) end
				)

				props.subscribe(function(values)
					updateControlStates(states, props.converted, values, function(state, value) state(value) end)
				end)

				local rendered = storyProps.render { controls = states :: Controls<C> }
				rendered.Parent = props.target
			end)
		end,
	}
end

return createFluidStory
