
local internal = setmetatable({}, {__mode="k"})
local workaround = function()
	if next(internal) == nil then -- no key
		internal = setmetatable({}, {__mode="k"})
		collectgarbage();collectgarbage()
		return true
	end
	return false
end

local function soft_getmetatable(t)
	return internal[t]
end

local function soft_setmetatable(t, mt)
	--workaround()
	internal[t] = mt
	return t
end
return {
	getmetatable = soft_getmetatable,
	setmetatable = soft_setmetatable,
	purge=function()
		if workaround() then
			print("internal table reset")
		end
		--internal=nil
		--internal=setmetatable({}, {__mode="k"})
	end,
}
