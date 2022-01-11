local manager = _G.Manager

-- Settings
local SETTINGS = manager('Settings')

-- Tables
local stored = {}

-- Main Module
local cache = {}
cache.__index = cache

-- Private Functions
local function ParseName(name: string)
	name = name:lower()
	local split = name:split('')
	local first = split[1]:upper()

	table.remove(split, 1)

	return first .. tostring(table.concat(split))
end

-- Public Functions
function cache.New()
	return setmetatable({}, cache)
end

function cache:__call(puid: number)
	return self[tostring(puid)]
end

function cache:Add(puid: number, data: table)
	puid = tostring(puid)
	data = typeof(data) == 'table' and data or {}

	if (not self[puid]) then
		self[puid] = data
	end
end

function cache:Remove(puid: number)
	puid = tostring(puid)

	self[puid] = nil
end

return {
	Create = function(name: string)
		assert(typeof(name) == 'string' and #name > 0, '[Cache.Create]: Paramater <name: string> needs to have characters in it.')

		local self = stored
		local parsed = ParseName(name)

		if (not self[parsed]) then
			local object = cache.New()
			self[parsed] = object

			return object
		else
			if (SETTINGS.IsDebug) then
				warn(string.format('[Cache.Create]: %s already exists in the cache.', name))
			end
		end
	end,
	Fetch = function(name: string)
		if (stored[ParseName(name)]) then
			return stored[name]
		end
	end,
	Unload = function(puid: number)
		local self = stored

		for _, v in pairs(self) do
			task.spawn(v.Remove, v, puid)
		end
	end
}