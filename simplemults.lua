-- syntax: notemult {beat, len, multiplier, plr = pn or nil}
	
	local allmults = {}
	
	-- very stolen from oatmealine
	local function throw(msg)
		local _, err = pcall(error, msg, 4)
		SCREENMAN:SystemMessage(err)
	end
	
	-- partially stolen from sudospective (error messages stolen from oatmealine)
    function notemult(t)
		-- get players
        local pn = t.plr or get_plr()
        if type(pn) == 'number' then pn = {pn} end
		
		-- error messages, you should probably never see these
		if type(t[1]) ~= 'number' then throw('invalid SimpleMults beat: expected number, got ' .. type(t[1])); return notemult end
		if type(t[2]) ~= 'number' then throw('invalid SimpleMults duration: expected number, got ' .. type(t[2])); return notemult end
		if type(t[3]) ~= 'number' then throw('invalid SimpleMults multiplier: expected number, got ' .. type(t[3])); return notemult end
		
		-- insert notemults into the big table to all get set at once
		table.insert(allmults, {t[1], t[3], pn})
		table.insert(allmults, {t[1] + t[2], 1, pn})
		
        return notemult
    end
	
	-- stolen from oatmealine and then retooled
	-- set every notemult at once at beat 0
	func{0, function()
		local res = {}
		
		-- create a table for each player
		for pn = 1, max_pn do
			res[pn] = {}
		end
		
		-- add stuff from the big notemults table into each player specific table
		for _, r in ipairs(allmults) do
			for _, pl in ipairs(r[3]) do
				table.insert(res[pl], {r[1], r[2]})
			 end
		end

		-- actually set the notemults lol
		for i, pl in ipairs(res) do
			P[i]:SetNoteTypeMults(res[i])
		end
	end}