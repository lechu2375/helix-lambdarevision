FACTION.name = "Civil Workers Union"
FACTION.description = "Robole."
FACTION.color = Color(255, 127, 80)
FACTION.pay = 5
FACTION.isDefault = false
FACTION.isGloballyRecognized = false

FACTION.models = { 
    "models/wichacks/artnovest.mdl",
    "models/wichacks/erdimnovest.mdl",
    "models/wichacks/ericnovest.mdl",
    "models/wichacks/joenovest.mdl",
    "models/wichacks/mikenovest.mdl",
    "models/wichacks/sandronovest.mdl",
    "models/wichacks/tednovest.mdl",
    "models/wichacks/vannovest.mdl",
    "models/models/army/female_01.mdl",
    "models/models/army/female_02.mdl",
    "models/models/army/female_03.mdl",
    "models/models/army/female_04.mdl",
    "models/models/army/female_06.mdl",
    "models/models/army/female_07.mdl"
}
function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end
FACTION_CW = FACTION.index