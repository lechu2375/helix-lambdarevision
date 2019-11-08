
ITEM.name = "Puszka specjalnej wody."
ITEM.model = Model("models/props_cunk/popcan01a.mdl")
ITEM.skin = 2
ITEM.description = "Różowa aluminiowa puszka wody, która wydaje się nieco lepsza niż zwykla."
ITEM.category = "Consumables"

ITEM.functions.Drink = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RestoreStamina(75)
		client:SetHealth(math.Clamp(client:Health() + 10, 0, client:GetMaxHealth()))
		client:EmitSound("npc/barnacle/barnacle_gulp2.wav", 75, 90, 0.35)
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}
