
ITEM.name = "Racja Priorytetowa"
ITEM.model = Model("models/weapons/w_packatp.mdl")
ITEM.description = "Opakowanie termokurczliwe zawierające jedzenie i pieniądze."
ITEM.items = {"supplements", "big_water","standard_hydration_pack"}

ITEM.functions.Open = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, client)
			end
		end

		character:GiveMoney(ix.config.Get("rationTokens", 20))
		client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
	end
}
