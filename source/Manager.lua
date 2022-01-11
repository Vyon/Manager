-- Services
local http_service = game:GetService('HttpService')

-- Variables
local host = 'https://vyoncorp.org/scripts/Utility/'

local scripts = {
	'Cache',
	'Math',
	'String',
	'Table'
}

local manager = {}
manager.__index = manager

function manager:__call(key)
	return self.Modules[key]
end

function manager:IsLoadStringEnabled()
	return pcall(loadstring, 'local a = {};')
end

function manager:SetDirectories(modules: Array<Folder>)
	assert(typeof(modules) == 'table', 'Parameter was not an array.')

	for _, folder in ipairs(modules) do
		for i, v in ipairs(folder:GetChildren()) do
			assert(typeof(v) == 'Instance', tostring(v) .. ' is not a folder.')

			local index = #self.LoadDirectories + i

			self.LoadDirectories[index] = v
		end
	end

	return true
end

function manager:Load()
	for _, v in pairs(self.LoadDirectories) do
		if (v:IsA('ModuleScript')) then
			self.Modules[v.Name] = require(v)
		end
	end
end

return (function()
	local self = {}
	self.Modules = {
		['Settings'] = { IsDebug = _G.IsDebug }
	}

	self.LoadDirectories = {}

	setmetatable(self, manager)
	_G.Manager = self

	if (not self:IsLoadStringEnabled()) then
		warn('Loadstring is not currently enabled.')
		return
	end

	for _, v in ipairs(scripts) do
		local success = pcall(function()
			local response = http_service:GetAsync(host .. v)
			self.Modules[v] = loadstring(response)()
		end)

		if (not success) then
			warn('Failed to load', v)
		end
	end

	return self
end)()