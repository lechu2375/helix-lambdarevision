local legs = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true
}
function PLUGIN:ScalePlayerDamage(ply,hitgroup,dmginfo )
    local char = ply:GetCharacter()
    if IsValid(char) then
        if legs[hitgroup] then
            local chance = math.random(1,100)
            if (chance<=60 and !IsValid(client.ixRagdoll)) then
                ply:SetRagdolled(true, 10)       
            else
                char:AddBoost("legShoot","stm",-20)       
            end
        end
    end

end
