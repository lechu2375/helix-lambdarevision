CLASS.name = "Overwatch Mace Soldier"
CLASS.faction = FACTION_OTA
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/bloocobalt/combine/combine_s.mdl")
        client:SetSkin(1)
	end
end
function CLASS:CanSwitchTo(client)
	local name = client:Name()
	return Schema:IsCombineRank(name, "MACE")
end
CLASS_OMACE = CLASS.index
