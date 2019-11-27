CLASS.name = "Overwatch Blade Soldier"
CLASS.faction = FACTION_OTA
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/bloocobalt/combine/combine_e.mdl")
		client:SetSkin(0)
	end
end

function CLASS:CanSwitchTo(client)
	local name = client:Name()
	return Schema:IsCombineRank(name, "BLADE")
end

CLASS_OBLADE = CLASS.index
