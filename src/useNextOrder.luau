local function useNextOrder(index: number?)
	local index = index or 0
	return function()
		index += 1
		return index
	end
end

return useNextOrder
