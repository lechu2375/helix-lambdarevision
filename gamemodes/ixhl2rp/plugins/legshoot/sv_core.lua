local legs = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true
}
function PLUGIN:ScalePlayerDamage(ply,hitgroup,dmginfo )
    local char = ply:GetCharacter()
    if char then
        if char:GetFaction()==FACTION_OTA then return end
        if legs[hitgroup] then
            print("nogi")
            local chance = math.random(1,100)
            if (chance<=40) then
                ply:SetRagdolled(true, 10)     
            --else
               -- char:AddBoost("legShoot","stm",-50)   
              --  char:AddBoost("legShoot","stamina",-60)     
            end
        end
    end
end

