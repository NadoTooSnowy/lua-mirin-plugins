function region(t)
    local pn = t.plr or get_plr()
    P[pn]:SetHiddenRegions({{t[1], t[1] + t[2]}})
end