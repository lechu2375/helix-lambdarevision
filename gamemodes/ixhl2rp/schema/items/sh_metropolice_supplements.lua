
ITEM.name = "Metropolice Suplementy"
ITEM.model = Model("models/props_lab/jar01b.mdl")
ITEM.description = "Puszka konserwowa z dużą porcją codziennych składników odżywczych."
ITEM.factions = {FACTION_MPF, FACTION_OTA}

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RestoreStamina(100)
		client:SetHealth(math.Clamp(client:Health() + 30, 0, client:GetMaxHealth()))
		client:EmitSound("npc/antlion_grub/squashed.wav", 75, 150, 0.25)
	end,
	OnCanRun = function(itemTable)
		return itemTable.player:IsCombine()
	end
}
