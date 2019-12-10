PLUGIN.name = "Survival System"
PLUGIN.author = "ZeMysticalTaco"
PLUGIN.description = "A survival system consisting of hunger and thirst."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")
ix.config.Add("hunger_decay_speed", 300, "Co ile ma głodek spadać.", nil, {
	data = {min = 10, max = 1000},
	category = "needs"
})
ix.config.Add("hunger_decay_amount", 1, "Ile ma głodku spadać.", nil, {
	data = {min = 1, max = 100},
	category = "needs"
})
ix.config.Add("thirst_decay_speed", 300, "Co ile ma pićko spadać.", nil, {
	data = {min = 10, max = 1000},
	category = "needs"
})
ix.config.Add("thirst_decay_amount", 1, "Ile ma pićka spadać.", nil, {
	data = {min = 1, max = 100},
	category = "needs"
})
local playerMeta = FindMetaTable("Player")

function playerMeta:GetHunger()
	local char = self:GetCharacter()

	if (char) then
		return char:GetData("hunger", 100)
	end
end

function playerMeta:GetThirst()
	local char = self:GetCharacter()

	if (char) then
		return char:GetData("thirst", 100)
	end
end

function PLUGIN:AdjustStaminaOffset(client, offset)
	if client:GetHunger() < 15 or client:GetThirst() < 20 then
		return -1
	end
end

--TODO: Populate Hunger and Thirst Items.
--TODO: Drown out colors and restrict stamina restoration for hungry / thirsty players.
local hunger_items = {
	["melon"] = {
		["name"] = "Melon",
		["model"] = "models/props_junk/watermelon01.mdl",
		["desc"] = "Zielony owoc, posiadający twardą skorupę.",
		["illegal"] = true,
		["hunger"] = 40,
		["thirst"] = 40,
		["width"] = 2,
		["height"] = 2
	},
	["bleach"] = {
		["name"] = "Wybielacz",
		["model"] = "models/props_junk/garbage_plasticbottle001a.mdl",
		["desc"] = "Butelka wybielacza, popularnego produktu gospodarstwa domowego, to wciąż niepalna jednostka produkcyjna. Picie go nie jest dobrym pomysłem.",
		["hunger"] = -50,
		["thirst"] = -50
	},

	["vegetable_oil"] = {
		["name"] = "Olej roślinny",
		["model"] = "models/props_junk/garbage_plasticbottle002a.mdl",
		["desc"] = "Butelka oleju roślinnego, popularnego produktu do gotowania. Picie go na surowo nie jest dobrym pomysłem.",
		["hunger"] = -25,
		["thirst"] = -25
	},

	["minimal_supplements"] = {
		["name"] = "Minimal Survival Supplement",
		["model"] = "models/gibs/props_canteen/vm_sneckol.mdl",
		["desc"] = "Mały asortyment witamin i artykułów spożywczych, a także niewielka paczka wstępnie zapakowanej wody, zaprojektowana, aby nakarmić i utrzymać cię na nogach.",
		["hunger"] = 0,
		["thirst"] = 15
	},
	["tea"] = {
		["name"] = "Opakowanie Kawy",
		["model"] = "models/bioshockinfinite/xoffee_mug_closed.mdl",
		["desc"] = "Mała, metalowa puszeczka z kawą w środku.",
		["hunger"] = 0,
		["thirst"] = 15
	},
	["coffee"] = {
		["name"] = "Butelka Herbaty",
		["model"] = "models/bioshockinfinite/ebsinthebottle.mdl",
		["desc"] = "Średnich rozmiarów butelka z czarną herbatą w środku.",
		["hunger"] = 10,
		["thirst"] = 10
	},
	["carton_of_milk"] = {
		["name"] = "Karton Mleka",
		["model"] = "models/props_junk/garbage_milkcarton002a.mdl",
		["desc"] = "Karton wypełniony mlekiem.",
		["hunger"] = 0,
		["thirst"] = 15
	},
	["can_of_beans"] = {
		["name"] = "Puszka fasoli",
		["model"] = "models/props_junk/garbage_metalcan001a.mdl",
		["desc"] = "Puszka wypełniona dorodnymi fasolkami.",
		["hunger"] = 20,
		["thirst"] = 0
	},
	--[[["standard_supplements"] = {
		["name"] = "Standard Supplement Package",
		["model"] = "models/props_lab/jar01a.mdl",
		["desc"] = "A standard can of supplements, designed to keep you nutritionally active.",
		["hunger"] = 20,
		["thirst"] = 20
	},--]]

	["water"] = {
		["name"] = "Woda Mineralna",
		["model"] = "models/props_junk/PopCan01a.mdl",
		["desc"] = "Puszka wody mineralnej.",
		["hunger"] = 0,
		["thirst"] = 5
	},

	["normal_beer"] = {
		["name"] = "Butelka Piwa",
		["model"] = "models/bioshockinfinite/hext_bottle_lager.mdl",
		["desc"] = "Butelka piwa, produkowana przez Unię, na etykiecie widnieje 7,3% zawartości alkoholu.",
		["hunger"] = -5,
		["thirst"] = 10,
		["empty"] = "empty_bottle",
	},

	["big_beer"] = {
		["name"] = "40oz Butelka Piwa",
		["model"] = "models/props_junk/garbage_glassbottle001a.mdl",
		["desc"] = "Duża Butelka piwa, wyprodukowana przez Unię, zawierająca 7,3% zawartości alkoholu.",
		["hunger"] = -15,
		["thirst"] = 30
	},

	["big_water"] = {
		["name"] = "2L Wody",
		["model"] = "models/props_junk/garbage_plasticbottle003a.mdl",
		["desc"] = "2 Litrowa butelka wody.",
		["hunger"] = 2,
		["thirst"] = 45
	},
	["oat_cookies"] = {
		["name"] = "Ciasteczka Owsiane",
		["model"] = "models/pg_plops/pg_food/pg_tortellinac.mdl",
		["desc"] = "Pudełko ciasteczek owsianych Yayoga.",
		["hunger"] = 5,
		["thirst"] = -3
	},

	["hydration_pack"] = {
		["name"] = "Minimal Hydration Pack",
		["model"] = "models/foodnhouseholdaaaaa/combirationa.mdl",
		["desc"] = "Mały pakiet, zwierający 12 uncji wody.",
		["hunger"] = 0,
		["thirst"] = 35
	},
	["standard_hydration_pack"] = {
		["name"] = "Standardowy pakiet nawodnienia",
		["model"] = "models/foodnhouseholdaaaaa/combirationb.mdl",
		["desc"] = "Pakiet zawierający 32 uncję wody.",
		["hunger"] = 0,
		["thirst"] = 65
	},
	["standard_supplement"] = {
		["name"] = "Suplementy",
		["model"] = "models/foodnhouseholdaaaaa/combirationb.mdl",
		["desc"] = "Saszetka z wodnistą masą w środku. Obok jedzenia dołączona jest plastikowa łyżeczka.",
		["hunger"] = 25,
		["thirst"] = 0
	},
	["loyalist_supplement"] = {
		["name"] = "Suplementy Lojalistów",
		["model"] = "models/foodnhouseholdaaaaa/combirationc.mdl",
		["desc"] = "Saszetka z wodnistą masą w środku. Można dostrzec w niej kawałki mięsa. Obok jedzenia dołączona jest plastikowa łyżeczka.",
		["hunger"] = 25,
		["thirst"] = 0
	},
	["cold_cooked_meat"] = {
		["name"] = "Konserwowa Ryba",
		["desc"] = "Garść przegotowanego, zimnego mięsa.",
		["hunger"] = 10,
		["model"] = "models/bioshockinfinite/cardine_can_open.mdl"
	},
	["orange"] = {
		["name"] = "Pomarańcz",
		["desc"] = "Zwykła, lekko twarda pomarańcza.",
		["hunger"] = 12,
		["model"] = "models/bioshockinfinite/hext_orange.mdl"
	}
	["apple"] = {
		["name"] = "Jabłko",
		["desc"] = "Jabłko, skórka mieni się pod światłem.",
		["hunger"] = 5,
		["model"] = "models/bioshockinfinite/hext_apple.mdl"
	},
	["banan"] = {
		["name"] = "Banan",
		["desc"] = "Żołty owoc.",
		["hunger"] = 5,
		["model"] = "models/bioshockinfinite/hext_banana.mdl"
	},	
	["chockolade"] = {
		["name"] = "Tabliczka Czekolady",
		["desc"] = "Tabliczka czekolady załadowana w papierek opatrzony logiem UU.",
		["hunger"] = 10,
		["model"] = "models/bioshockinfinite/hext_candy_chocolate.mdl"
	},
	["peanuts"] = {
		["name"] = "Worek Orzechów",
		["desc"] = "Worek pełen słonych orzeszków.",
		["hunger"] = 10,
		["model"] = "models/bioshockinfinite/rag_of_peanuts.mdl"
	},
	["pear"] = {
		["name"] = "Gruszka",
		["desc"] = "Mała złocista gruszka z naklejką UU-Branded.",
		["hunger"] = 5,
		["model"] = "models/bioshockinfinite/hext_pear.mdl"
	},
	["corn"] = {
		["name"] = "Kolba Kukurydzy",
		["desc"] = "Złocista kolba kukurydzy.",
		["hunger"] = 10,
		["model"] = "models/bioshockinfinite/porn_on_cob.mdl"
	},
	["pickles"] = {
		["name"] = "Słoik Ogórków",
		["desc"] = "Słoik pełen kiszonych ogórków.",
		["hunger"] = 15,
		["thirst"] = 5,
		["model"] = "models/bioshockinfinite/dickle_jar.mdl"
	},
	["bread"] = {
		["name"] = "Bochenek Chleba",
		["desc"] = "Złocisty bochenek chleba z logiem UU.",
		["hunger"] = 20,
		["thirst"] = -5,
		["model"] = "models/bioshockinfinite/dread_loaf.mdl"
	},
	["popcorn"] = {
		["name"] = "Karton Popcornu",
		["desc"] = "Szare opakowanie ze słonym popcornem w środku.",
		["hunger"] = 10,
		["thirst"] = -5,
		["model"] = "models/bioshockinfinite/topcorn_bag.mdl"
	},
	["cheese"] = {
		["name"] = "Okrąg Sera",
		["desc"] = "Okrąg żółtego sera z naklejką UU-Branded.",
		["hunger"] = 35,
		["thirst"] = 0,
		["model"] = "models/bioshockinfinite/pound_cheese.mdl"
	},
	["ananas"] = {
		["name"] = "Ananas",
		["desc"] = "Duży owoc.",
		["hunger"] = 15,
		["thirst"] = 5,
		["model"] = "models/bioshockinfinite/hext_pineapple.mdl"
	},	
	["potato"] = {
		["name"] = "Ziemniak",
		["desc"] = "Surowy ziemniak.",
		["hunger"] = 5,
		["thirst"] = 0,
		["model"] = "models/bioshockinfinite/hext_potato.mdl"
	}	
	
}

for k, v in pairs(hunger_items) do
	local ITEM = ix.item.Register(k, nil, false, nil, true)
	ITEM.name = v.name
	ITEM.description = v.desc
	ITEM.model = v.model
	ITEM.width = v.width or 1
	ITEM.height = v.height or 1
	ITEM.category = "Survival"
	ITEM.hunger = v.hunger or 0
	ITEM.thirst = v.thirst or 0
	ITEM.empty = v.empty or false
	function ITEM:GetDescription()
		return self.description
	end
	ITEM.functions.Consume = {
		name = "Consume",
		OnCanRun = function(item)
			if item.thirst != 0 then
				if item.player:GetCharacter():GetData("thirst", 100) >= 100 then
					return false
				end
			end
			if item.hunger != 0 then
				if item.player:GetCharacter():GetData("hunger", 100) >= 100 then
					return false
				end
			end
		end,
		OnRun = function(item)
			local hunger = item.player:GetCharacter():GetData("hunger", 100)
			local thirst = item.player:GetCharacter():GetData("thirst", 100)
			item.player:SetHunger(hunger + item.hunger)
			item.player:SetThirst(thirst + item.thirst)
			item.player:EmitSound("physics/flesh/flesh_impact_hard6.wav")
			if item.empty then
				local inv = item.player:GetCharacter():GetInventory()
				inv:Add(item.empty)
			end
		end
	}
end
