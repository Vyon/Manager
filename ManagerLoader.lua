local manager

pcall(function()
	manager = loadstring(game:GetService('HttpService'):GetAsync('https://vyoncorp.org/scripts/Manager'))()

	if (not manager) then
		warn('Manager failed to load.')
	end
end)

manager:SetDirectories({}) -- Within the {}, input folder paths

manager:Load()