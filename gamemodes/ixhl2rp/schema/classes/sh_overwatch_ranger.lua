CLASS.name = "Overwatch Ranger Soldier"
CLASS.faction = FACTION_OTA
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/bloocobalt/combine/combine_s.mdl")
        client:SetSkin(2)
	end
end

function CLASS:CanSwitchTo(client)
	local name = client:Name()
	return Schema:IsCombineRank(name, "RANGER")
end

CLASS_ORANGER = CLASS.index
