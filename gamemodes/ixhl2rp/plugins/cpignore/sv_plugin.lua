local allyFactions = {
    [FACTION_MPF] = true,
    [FACTION_OTA] = true,
    [FACTION_ADMIN] = true
}

local freindlyTable = freindlyTable or {} --table for freindly players
local masterTable = masterTable or {} --table for npc's
local function updateFreindlyTable() 
    for _,v in pairs(player.GetAll()) do
        if IsValid(v) then --if player is valide we are checking his team
            if allyFactions[v:Team()] then  --team is inside whitelist table?
                freindlyTable[v] = true --then add him to freindlies
            else
                freindlyTable[v] = false --if not then set to false
            end
        end
    end
end

local function updateFreindlyNPC()
    for k,_ in pairs(masterTable) do 
        if IsValid(k) then
            k:setAllies()
        else
            masterTable[k] = nil --if npc is not valid then remove it from table
        end
    end
end

function PLUGIN:CharacterLoaded(char)
    local ply = char:GetPlayer()
    if not allyFactions[ply:Team()] and freindlyTable[ply] then
        freindlyTable[ply] = false
        updateFreindlyNPC()
    elseif not freindlyTable[ply] and allyFactions[ply:Team()] then
        freindlyTable[ply] = true
        updateFreindlyNPC()
    end
end



local NPC = FindMetaTable("NPC")

function NPC:setAllies()
    for k,_ in pairs(freindlyTable) do
        if freindlyTable[k] then
            self:AddEntityRelationship(k,D_LI,99)
        elseif not freindlyTable[k] then
            self:AddEntityRelationship(k,D_HT,99)
        end
    end
end


local whitelist = {
    ["npc_metropolice"] = true
}


function PLUGIN:OnEntityCreated( ent )
	if whitelist[ent:GetClass()] then
		ent:setAllies()
        masterTable[ent] = true
	end
end

function PLUGIN:EntityRemoved(ent)
    if whitelist[ent:GetClass()] and masterTable[ent] then
        masterTable[ent] = nil
	end
end