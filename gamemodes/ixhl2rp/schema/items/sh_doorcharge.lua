
ITEM.name = "Ładunek Wybuchowy"
ITEM.description = "Służy do otwierania zamkniętych drzwi."
ITEM.model = Model("models/warz/items/c4.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, -2, 7),
	ang = Angle(90, 90, 0),
	fov = 45
}



ITEM.functions.Place = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local charge = scripted_ents.Get("hl2_doorcharge"):SpawnFunction(client, util.TraceLine(data))

		if (IsValid(charge)) then
			client:EmitSound("physics/metal/weapon_impact_soft2.wav", 75, 80)
		else
			return false
		end
	end
}
