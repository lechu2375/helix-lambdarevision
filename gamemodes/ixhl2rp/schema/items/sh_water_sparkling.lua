
ITEM.name = "Puszka wody gazowanej"
ITEM.model = Model("models/props_lunk/popcan01a.mdl")
ITEM.skin = 1
ITEM.description = "Aluminiowa puszka gazowanej wody."
ITEM.category = "Consumables"

ITEM.functions.Drink = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local thirst = client:GetCharacter():GetData("thirst", 100)
		client:SetThirst(math.Clamp(thirst,thirst+20, 100 ))
		client:RestoreStamina(50)
		client:SetHealth(math.Clamp(client:Health() + 8, 0, client:GetMaxHealth()))
		client:EmitSound("npc/barnacle/barnacle_gulp2.wav", 75, 90, 0.35)
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}
