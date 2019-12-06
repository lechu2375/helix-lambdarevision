do
ix.chat.Register("try", {
 	format = "((Próba))%s %s",
 	GetColor = function() return Color(140, 122, 230)end,
 	CanHear = ix.config.Get("chatRange", 280) * 2,
 	prefix = {},
	description = "@cmdMe",
 	indicator = "Próbuje",
	deadCanChat = true
})

ix.command.Add("sprobuj", {
	description = "Spróbuj wykonać daną czynność",
	arguments = ix.type.text,
	OnRun = function(self, client, text)
        local str
        if not string.EndsWith(text,".") then
            text = text.."."
        end
        local git = tobool(math.random(0, 1))
        if git then 
            str= " odniósł sukces próbując "..text
        else
            str = " zawiódł próbując "..text
        end
		ix.chat.Send(client, "try", str)
        

	end
})
end

do
	local COMMAND = {}
	COMMAND.arguments = {
		ix.type.character,
		ix.type.number,
		ix.type.text
	}

	function COMMAND:OnRun(client, target,number,text)
		local insertQuery = mysql:Insert("hl2_lp")
			insertQuery:Insert("character_id", target:GetID())
			insertQuery:Insert("lp_amount", number)
			insertQuery:Insert("lp_description", text)
			insertQuery:Execute()
	end

	ix.command.Add("addLP", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.character


	function COMMAND:OnRun(client, target)
		local toGet = target:GetID()
		sendLP(client,toGet)
	end

	ix.command.Add("getLP", COMMAND)
end


