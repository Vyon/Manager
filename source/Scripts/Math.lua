local manager_math = {}

function manager_math.IsWhole(p1: number, p2: number)
	if (p1 / p2 == math.floor(p1 / p2)) then
		return true
	end
end

function manager_math.FractionToDecimal(numberator: number, denominator: number)
	return numberator / denominator
end

function manager_math.ParseDouble(num: number, decimals: number)
	decimals = typeof(decimals) == 'number' and decimals > 0 and decimals or 1
	num = typeof(num) == 'number' and num

	local str = string.format('%.' .. decimals .. 'f', num)

	return tonumber(str)
end

return manager_math
