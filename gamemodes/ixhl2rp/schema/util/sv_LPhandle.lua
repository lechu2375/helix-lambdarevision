util.AddNetworkString("requestLP")
util.AddNetworkString("commitLP")
--util.AddNetworkString("deleteLP")

function sendLP(client,toGet)
    local query = mysql:Select("hl2_lp")
		query:Select("character_id")
		query:Select("lp_amount")
		query:Select("lp_description")
		query:WhereIn("character_id", toGet)
		query:Callback(function(result)
            net.Start("requestLP")
            net.WriteTable(result)
            net.Send(client)
	    end)
	query:Execute()
end

function commitLP(charID,amount,desc)
		local insertQuery = mysql:Insert("hl2_lp")
		insertQuery:Insert("character_id",charID)
		insertQuery:Insert("lp_amount", amount)
		insertQuery:Insert("lp_description", desc)
		insertQuery:Execute()	
end

net.Receive("requestLP", function(len,ply)
	if not ply:GetCharacter():IsCombine() then
		--kara dla cwela
	end
	local toGet = net.ReadInt(10)
	sendLP(ply,toGet)
end)
net.Receive("commitLP", function(len,ply)
	if (ply.commitDelay or CurTime())>CurTime() then return end
	if not ply:GetCharacter():IsCombine() then
		--kara dla cwela
	end
	ply.commitDelay = CurTime()+5
	local info = net.ReadTable()
	commitLP(info["character_id"],info["lp_amount"],info["lp_description"])
end)