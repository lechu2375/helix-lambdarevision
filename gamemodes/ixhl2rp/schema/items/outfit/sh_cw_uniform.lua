
ITEM.name = "Uniform członka CW"
ITEM.description = "Uniform noszony przez członków CW"
ITEM.category = "Clothing"

ITEM.zjebanenazwy = {
    ["01"] = "wichacks/joenovest.mdl",
    ["02"] = "wichacks/tednovest.mdl",
    ["03"] = "wichacks/vannovest.mdl",
    ["04"] = "wichacks/ericnovest.mdl",
    ["05"] = "wichacks/artnovest.mdl",
    ["06"] = "models/wichacks/sandronovest.mdl",
    ["07"] = "models/wichacks/erdimnovest.mdl",
    ["08"] = "models/wichacks/vancenovest.mdl",
    ["09"] = "models/wichacks/mikenovest.mdl",
}

ITEM.replacements = {
	{"humans/group01/f", "models/army/f"},
	{"humans/group01/male_01", "wichacks/artnovest"},
    {"humans/group0%d/Male_01",ITEM.zjebanenazwy[1]},
    {"humans/group0%d/Male_02",ITEM.zjebanenazwy[2]},
}



--esa zioemk says "Models/models/army/female_01.mdl."
--esa zioemk says "Models/Humans/Group01/Female_01.mdl."

--models/wichacks/artnovest.mdl
--models/Humans/Group01/Male_01.mdl
models/Humans/Group01/Male_01.mdl