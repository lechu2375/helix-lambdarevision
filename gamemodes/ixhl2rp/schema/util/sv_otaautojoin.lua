function Schema:PlayerLoadedCharacter(client, character, currentChar)
    timer.Simple(.1, function()
        if character:GetFaction()==FACTION_OTA then 
            local name = client:Name()
            if Schema:IsCombineRank(name, "KING") then
                character:JoinClass(CLASS_OKING)
            elseif Schema:IsCombineRank(name, "MACE") then
                character:JoinClass(CLASS_OMACE)
            elseif Schema:IsCombineRank(name, "RANGER") then 
                character:JoinClass(CLASS_ORANGER)
            elseif Schema:IsCombineRank(name, "BLADE") then
                character:JoinClass(CLASS_OBLADE)
            end
        end
    end)
end