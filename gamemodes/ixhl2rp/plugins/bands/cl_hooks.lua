function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	if client then
		local panel = tooltip:AddRowAfter("name", "band")
		panel:SetBackgroundColor(Color(255, 127, 80))
		panel:SetText("Opaska CWU")
		panel:SizeToContents()
    end
end