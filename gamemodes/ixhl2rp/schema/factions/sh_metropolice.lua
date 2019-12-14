
FACTION.name = "Metropolice Force"
FACTION.description = "Jednostka metropolice działająca jako ochrona cywilna."
FACTION.color = Color(50, 100, 150)
FACTION.pay = 10
FACTION.models = {"models/dpfilms/metropolice/urban_police.mdl"}
FACTION.weapons = {"ix_stunstick"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("pistol", 1)
	inventory:Add("pistolammo", 2)
end

function FACTION:GetDefaultName(client)
	return "CCA-RCT." .. Schema:ZeroNumber(math.random(1, 99999), 5), true
end

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end


--models/dpfilms/metropolice/playermodels/pm_urban_police.mdl
function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()

	if (!Schema:IsCombineRank(oldValue, "RCT") and Schema:IsCombineRank(value, "RCT")) then
		character:JoinClass(CLASS_MPR)
	elseif (!Schema:IsCombineRank(oldValue, "SCN") and Schema:IsCombineRank(value, "SCN")
	or !Schema:IsCombineRank(oldValue, "SHIELD") and Schema:IsCombineRank(value, "SHIELD")) then
		character:JoinClass(CLASS_MPS)

		Schema:CreateScanner(client, Schema:IsCombineRank(client:Name(), "SHIELD") and "npc_clawscanner" or nil)
	end
end

FACTION_MPF = FACTION.index
