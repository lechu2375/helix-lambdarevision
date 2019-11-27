

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

    function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
        timer.Simple(.005, function()
            local description = tooltip:GetRow("description")
            if client:IsPrime() and description then
                description:SetTextColor(Color(254, 202, 87))-- set text to red
            end
        end)
    end

end

    
