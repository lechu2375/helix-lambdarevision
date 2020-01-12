print("sh")
function PLUGIN:PlayerUse(ply,ent)
    local class = ent:GetClass()
    if class == "ix_vendor" then
        local items = ent.items
        local toResupply = 0
        for k,v in pairs(items) do --ENT:SetStock(uniqueID, value)
            if v[VENDOR_MAXSTOCK] and v[VENDOR_MAXSTOCK]>0 then
                print("===")
                print(k)                
                PrintTable(v)
                print("Stock:"..v[VENDOR_STOCK])
                print("\n MaxStock:"..v[VENDOR_MAXSTOCK])
                toResupply = toResupply + (v[VENDOR_MAXSTOCK] - v[VENDOR_STOCK])
            end
        end
        PrintMessage(HUD_PRINTTALK,toResupply)
    elseif class == "ix_vendingmachine" then --ENT:ResetStock(id)
        local items = ent.Items
        local toResupply = #ent.Items*ent.MaxStock
        for k,v in pairs(items) do
            print(k.."curr stock:"..ent:GetStock(k))
            toResupply = toResupply-ent:GetStock(k)
        end
        print("toresupply:"..toResupply)
    end

end