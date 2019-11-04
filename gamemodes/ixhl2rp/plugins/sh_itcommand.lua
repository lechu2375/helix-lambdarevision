PLUGIN.name = "Edycja czatu"
PLUGIN.desc = "Kolor dla /it, dodaje odpowiednik tej komendy na /do także"

do
	timer.Simple(.1, function()
		ix.chat.Register("it", {
			OnChatAdd = function(self, speaker, text)
						
				chat.AddText(Color(142, 68, 173), "(("..speaker:GetName().."))".."** "..text)
			end,
			CanHear = ix.config.Get("chatRange", 280) * 2,
			prefix = {"/It","/Do"},
			description = "@cmdIt",
			indicator = "chatPerforming",
			deadCanChat = true
		})
	end)
end