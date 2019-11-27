CLASS.name = "Overwatch Soldier"
CLASS.faction = FACTION_OTA
CLASS.isDefault = true

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/ninja/combine_soldier_reimagine.mdl")
		client:SetSkin(0)
	end
end

CLASS_OWS = CLASS.index
