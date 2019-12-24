
ITEM.name = "Zestaw Leczniczy"
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "Biała paczka pełna leków."
ITEM.category = "Medical"
ITEM.price = 65

ITEM.functions.Apply = {
	name = "Ulecz siebie",
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		if client:Health()>=100 then
			client:Notify("To nic ci nie da. Postanawiasz nie marnować przedmiotu i nic z nim nie robisz.")
			return false
		end
		client:SetHealth(math.min(client:Health() + 50, 100))
	end,

}

ITEM.functions.useForward = {
	name = "Ulecz kogoś",
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = item.player:GetEyeTraceNoCursor()
		local ent = data.Entity
		if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
			client:SetHealth(math.min(client:Health() + 50, 100))
			return true
		end
		return false
	end,
	OnCanRun = function(item)
		if !IsValid(item.entity) and IsValid(item.player) and item.player:GetCharacter() then
			local data = item.player:GetEyeTraceNoCursor()
			local ent = data.Entity
			local pos = data.endpos 
			if (ent:IsPlayer() and 100>ent:Health()  item.player:GetPos():Distance(data.endpos)<=50) then
				return true
			else
				return false
			end
		end
	end
}