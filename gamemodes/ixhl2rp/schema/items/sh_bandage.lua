
ITEM.name = "Bandaż"
ITEM.model = Model("models/props_wasteland/prison_toiletchunk01f.mdl")
ITEM.description = "Mała rolka ręcznie robionej gazy."
ITEM.category = "Medical"
ITEM.price = 18

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 20, 100))
	end
}
