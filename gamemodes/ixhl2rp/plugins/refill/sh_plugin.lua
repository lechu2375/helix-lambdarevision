PLUGIN.name = "Refill'ed"
PLUGIN.author = "Lechu2375"
PLUGIN.desc = "Allows players to refill stock of the vendor, vending machines and even ration distributors."
ix.util.Include("core/sv_core.lua")
//ix.util.Include("core/sv_hooks.lua")
ix.util.Include("core/cl_derma.lua")



concommand.Add("wyjebgdzies", function(ply)
	ply:SetPos(Vector(-722.650513, -166.997040, -12223.531250))
end)