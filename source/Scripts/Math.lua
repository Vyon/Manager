local manager_math = {}

function manager_math.IsWhole(p1: number, p2: number)
	if (p1 / p2 == math.floor(p1 / p2)) then
		return true
	end
end

function manager_math.FractionToDecimal(numberator: number, denominator: number)
	return numberator / denominator
end

function manager_math.ParseDouble(num: number)
	local str = string.format('%.3f', num)

	return tonumber(str)
end

return manager_math