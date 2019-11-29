ix.bar.Add(function()
		local status = ""
		local var = LocalPlayer():GetLocalVar("hunger", 0) / 100

		if var < 0.2 then
			status = "Wygłodzony"
		elseif var < 0.4 then
			status = "Głodny"
		elseif var < 0.6 then
			status = "Burczy w brzuchu"
		elseif var < 0.8 then
			status = ""
		end

		return var, status
	end, Color(200, 200, 40), nil, "hunger")

	ix.bar.Add(function()
		local status = ""
		local var = LocalPlayer():GetLocalVar("thirst", 0) / 100

		if var < 0.2 then
			status = "Odwodniony"
		elseif var < 0.4 then
			status = "Lekko Odwodniony"
		elseif var < 0.6 then
			status = "Spragniony"
		elseif var < 0.8 then
			status = "Napity"
		end

		return var, status
	end, Color(0, 119, 101), nil, "thirst")