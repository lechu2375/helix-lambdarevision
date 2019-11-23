

local primeGroups = {
    ["superadmin"] = true
}
local PLAYER = FindMetaTable("Player")

function PLAYER:IsPrime()
    if self:IsSuperAdmin() then return true end
    if primeGroups[self:GetNWString("usergroup")] then
        return true
    end
end
if CLIENT then

    function PLUGIN:GetScoreboardDescriptionColor(client)
        if client:IsPrime() then
            return Color(254, 202, 87)
        end
    end

    function PLUGIN:GetDescriptionColor(client)
        if client:IsPrime() then
            return Color(254, 202, 87)
        end
    end
    
end
