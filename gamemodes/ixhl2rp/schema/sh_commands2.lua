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