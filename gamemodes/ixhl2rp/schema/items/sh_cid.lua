
ITEM.name = "Identyfikator Obywatela"
ITEM.model = Model("models/gibs/metal_gib4.mdl")
ITEM.description = "Karta identyfikacyjna obywatela o ID #%s, należąca do %s."

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("name", "nobody"))
end
