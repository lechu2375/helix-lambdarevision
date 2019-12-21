FACTION.name = "Union Medical"
FACTION.description = "Uformowane spośród przedwojennych lekarzy, studentów i studentek medycyny i pielęgniarstwa, a także wszystkich wystarczająco sprytnych, by obandażować kogoś rannego przez maszynę podczas cyklu pracy.\n Nadrzędnym celem UM jest kontrola stanu zdrowia mieszkańców, a także pilnowanie warunków sanitarnych w Mieście 17."
FACTION.color = Color(255, 121, 121)
FACTION.pay = 5
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end




FACTION_UM = FACTION.index