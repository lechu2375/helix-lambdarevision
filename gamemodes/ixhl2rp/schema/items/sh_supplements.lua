
ITEM.name = "Suplementy"
ITEM.model = Model("models/props_lab/jar01a.mdl")
ITEM.description = "Biały plastikowy słoik, zawierający dużą porcję codziennych składników odżywczych."

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RestoreStamina(100)
		client:SetHealth(math.Clamp(client:Health() + 20, 0, client:GetMaxHealth()))
		client:EmitSound("npc/antlion_grub/squashed.wav", 75, 150, 0.25)
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}
