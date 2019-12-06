
hook.Add("LoadFonts", "ixCombineViewData", function()
	surface.CreateFont("ixCombineViewData", {
		font = "Courier New",
		size = 16,
		antialias = true,
		weight = 400
	})
end)

local animationTime = 1
DEFINE_BASECLASS("DFrame")

local PANEL = {}

AccessorFunc(PANEL, "bCommitOnClose", "CommitOnClose", FORCE_BOOL)

function getLP(id)
	lpID = id
	net.Start("requestLP")
	net.WriteInt(id,10)
	net.SendToServer()
	print("Requesting lp for character:"..id)
end

function commitLP(charID,amount,desc)
	local infoTable = {
		["character_id"] = charID,
		["lp_amount"] = math.Round(amount),
		["lp_description"] = desc
	}	
	net.Start("commitLP")
		net.WriteTable(infoTable)
	net.SendToServer()
	getLP(lpID)
end


function PANEL:Init()
	self:SetCommitOnClose(true)
	self:SetBackgroundBlur(true)
	self:SetSize(ScrW() / 4 > 200 and ScrW() / 4 or ScrW() / 2, ScrH() / 2 > 300 and ScrH() / 2 or ScrH())
	self:Center()

	self.nameLabel = vgui.Create("DLabel", self)
	self.nameLabel:SetFont("BudgetLabel")
	self.nameLabel:SizeToContents()
	self.nameLabel:Dock(TOP)

	self.cidLabel = vgui.Create("DLabel", self)
	self.cidLabel:SetFont("BudgetLabel")
	self.cidLabel:SizeToContents()
	self.cidLabel:Dock(TOP)

	self.lastEditLabel = vgui.Create("DLabel", self)
	self.lastEditLabel:SetFont("BudgetLabel")
	self.lastEditLabel:SizeToContents()
	self.lastEditLabel:Dock(TOP)

	self.lpButton = vgui.Create("DButton", self)
	self.lpButton:SetFont("BudgetLabel")
	self.lpButton:SetText("LP")
	self.lpButton:SizeToContents()
	self.lpButton:Dock(TOP)
	function self.lpButton:DoClick()
		--if self:GetParent().lpWindow then 
		lpWindow = vgui.Create("DFrame", self:GetParent())
		
		lpWindow:MakePopup()
		lpWindow:SetSize(ScrW() / 4 > 200 and ScrW() / 4 or ScrW() / 2, ScrH() / 2 > 300 and ScrH() / 2 or ScrH())
		lpWindow:SetDraggable(true)
		addLP = vgui.Create("DButton", lpWindow)
		addLP:SetFont("BudgetLabel")
		addLP:SetText("Add LP")
		addLP:SizeToContents()
		addLP:SetHeight(48)
		addLP:Dock(TOP)	
		function addLP:DoClick()
			if IsValid(commitWindow) then 
				commitWindow:Close()
			end
			commitWindow = vgui.Create("DFrame",lpWindow)
			commitWindow:MakePopup()
			commitWindow:SetDraggable(true)
			commitWindow:SetSize(200,400)

			local container = vgui.Create("DScrollPanel",commitWindow)
			container:Dock(FILL)
			local lpSlider = vgui.Create("DNumSlider",container)
			lpSlider:SetText( "Ilość LP" )	// Set the text above the slider
			lpSlider:SetMin( -200 )				// Set the minimum number you can slide to
			lpSlider:SetMax( 200 )				// Set the maximum number you can slide to
			lpSlider:SetDecimals( 0 )
			lpSlider:Dock( TOP )
			lpSlider:DockMargin( 0, 4, 0, 0 )

			local lpDescEntry = vgui.Create("DTextEntry", container)
			lpDescEntry:SetMultiline(true)
			lpDescEntry:Dock(TOP)
			lpDescEntry:SetHeight(200)
			lpDescEntry:SetFont("ixCombineViewData")

			local addButton = vgui.Create("DButton", container)
			addButton:SetText("Dodaj")
			addButton:SizeToContents()
			addButton:Dock(TOP)

			function addButton:DoClick()
				if (LocalPlayer().commitDelay or CurTime())>CurTime() then 
					LocalPlayer():Notify("Odczekaj chwilę zanim to zrobisz!")
					return 
				end
				LocalPlayer().commitDelay = CurTime()+5
				if lpSlider:GetValue()==0 then
					LocalPlayer():Notify("Wartość nie powinna wynosić zero.")
				end

				local lpValue = math.Round(lpSlider:GetValue())
				local lpDesc = lpDescEntry:GetText() or "Brak danych"
				commitLP(lpID,lpValue,lpDesc)
				lpWindow:Close()
			end
		end
		container = vgui.Create("DScrollPanel",lpWindow)	
		container:Dock(FILL)
		local lpAmount = 0
		if lpCache then
			if not table.IsEmpty(lpCache) then 
				for k,v in pairs(lpCache) do 
					k = vgui.Create("DButton", container)
					lpAmount = lpAmount + v["lp_amount"]
					k:SetText("Numer postaci:"..v["character_id"].."\nIlość punktów:"..v["lp_amount"].."\nKomentarz:"..v["lp_description"])
					k:SetWrap(true)
					k:SetAutoStretchVertical(true)
					k:SizeToContents()
					k:Dock(TOP)
					k:DockMargin(0, 10, 0, 0)
				end
			end	
		end
		totalLP = vgui.Create("DButton", lpWindow)
		totalLP:SetFont("BudgetLabel")
		totalLP:SetText("Łączna ilość punktów:"..(lpAmount or 0))
		totalLP:SizeToContents()
		totalLP:SetHeight(24)
		totalLP:Dock(TOP)	
		
	end

	self.textEntry = vgui.Create("DTextEntry", self)
	self.textEntry:SetMultiline(true)
	self.textEntry:Dock(FILL)
	self.textEntry:SetFont("ixCombineViewData")
end



function PANEL:Populate(target, cid, data, bDontShow)
	data = data or {}
	cid = cid or string.format("00000 (%s)", L("unknown")):upper()

	self.alpha = 255
	self.target = target
	self.oldText = data.text or ""

	local character = target:GetCharacter()
	local name = character:GetName()

	self:SetTitle(name)
	self.nameLabel:SetText(string.format("%s: %s", L("name"), name):upper())
	self.cidLabel:SetText(string.format("%s: #%s", L("citizenid"), cid):upper())
	self.lastEditLabel:SetText(string.format("%s: %s", L("lastEdit"), data.editor or L("unknown")):upper())
	self.textEntry:SetText(data.text or "")

	if (!hook.Run("CanPlayerEditData", LocalPlayer(), target)) then
		self.textEntry:SetEnabled(false)
	end

	if (!bDontShow) then
		self.alpha = 0
		self:SetAlpha(0)
		self:MakePopup()

		self:CreateAnimation(animationTime, {
			index = 1,
			target = {alpha = 255},
			easing = "outQuint",

			Think = function(animation, panel)
				panel:SetAlpha(panel.alpha)
			end
		})
	end
	getLP( character:GetID())
end

function PANEL:CommitChanges()
	if (IsValid(self.target)) then
		local text = string.Trim(self.textEntry:GetValue():sub(1, 1000))

		-- only update if there's something different so we can preserve the last editor if nothing changed
		if (self.oldText != text) then
			netstream.Start("ViewDataUpdate", self.target, text)
			Schema:AddCombineDisplayMessage("@cViewDataUpdate")
		end
	else
		Schema:AddCombineDisplayMessage("@cViewDataExpired", Color(255, 0, 0, 255))
	end
end

function PANEL:Close()
	if (self.bClosing) then
		return
	end
	lpID = nil
	self.bClosing = true

	if (self:GetCommitOnClose()) then
		self:CommitChanges()
	end

	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)

	self:CreateAnimation(animationTime, {
		target = {alpha = 0},
		easing = "outQuint",

		Think = function(animation, panel)
			panel:SetAlpha(panel.alpha)
		end,

		OnComplete = function(animation, panel)
			BaseClass.Close(panel)
		end
	})
end


net.Receive("requestLP", function(len)
	local tabler = net.ReadTable()
	lpCache = tabler
	PrintTable(tabler)
	if table.IsEmpty(tabler) then 
		lpCache = nil
	end
	print("Loaded lpCache")
end)
vgui.Register("ixViewData", PANEL, "DFrame")
