--[[
        MIRROR
        Created by Sudospective
        The mirror plugin allows you to use ease and add methods
        that takes P1's mods and inverts them to P2's.

        USAGE
        Ease:
        mirror {beat, len, ease, percent, mod, mode = ease or nil}
        Add:
        mirror {beat, len, ease, percent, mod, mode = add}
        Set:
        mirror {beat, percent, mod, mode = set}

        Any mod, alias, and node is valid.

        TODO
        - Support for more than two players
        - Support for specific degree of mirror offset
        - Support for error handling
    --]]
    function mirror(t)
        local tcopy = copy(t)
        local mode = (
            type(tcopy[3]) == 'string' and set 
            or t.mode 
            or rawget(xero, 'mode') 
            or ease
        )
        t.plr = 1
        tcopy.plr = 2
        for i = mode == set and 2 or 4, #tcopy, 2 do
            tcopy[i] = -tcopy[i]
        end
        mode(t, 1, 'mirror')
        mode(tcopy, 1, 'mirror')
        return mirror
    end