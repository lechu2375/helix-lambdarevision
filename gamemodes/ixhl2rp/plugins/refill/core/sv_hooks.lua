
function PLUGIN:PlayerUse(ply,ent)
    if (ply.nextChecker or CurTime())>CurTime() then return end
    ply.nextChecker=CurTime()+.4
    local class = ent:GetClass()
    if class == "ix_vendor" then
        local items = ent.items
        local toRestock =  {}
        for k,v in  pairs(items) do
            
            if istable(v) and !table.IsEmpty(v)  and  v[VENDOR_STOCK]<v[VENDOR_MAXSTOCK] then
                toRestock[k] = v[VENDOR_MAXSTOCK]-v[VENDOR_STOCK]
            end
        end
        //print("Do uzupełnienia itemy:")
        //PrintTable(toRestock)
        net.Start("requestStock")
            net.WriteTable(toRestock)
            print("sent")
        net.Send(ply)

        /*

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
        PrintMessage(HUD_PRINTTALK,toResupply)*/
    end
end

concommand.Add("chuj", function(ply)
    local ent = ply:GetEyeTraceNoCursor().Entity
    local items = ent.Items
    local toResupply = #ent.Items*ent.MaxStock
    local resupply = {}
            for k,_ in pairs(items) do
                resupply[k] = math.abs(ent:GetStock(k)-ent.MaxStock)
            end          
            PrintTable(resupply)
end)
concommand.Add("restock", function(ply)
    local capacity =  4
    local ent = ply:GetEyeTraceNoCursor().Entity
    local items = ent.Items
    local resupply = {}
            for k,_ in pairs(items) do
                resupply[k] = math.abs(ent:GetStock(k)-ent.MaxStock)
            end          
            PrintTable(resupply)
            for k,v in pairs(resupply) do 
                if v<=0 then print("nie ma co") continue end
                if capacity<=0 then break end
                for i = v,1,-1 do 
                    if capacity<=0 then break end
                    ent:SetStock(k,ent:GetStock(k)+1)
                    capacity=capacity-1
                    print("+1 restock, capacity: "..capacity)
                end
            end
            print("na koniec:"..capacity)
end)