local query
query = mysql:Create("IPinfotable")
	query:Create("ipadress", "VARCHAR(64) NOT NULL")
	query:Create("steamid", "INT NOT NULL")
	query:PrimaryKey("ipadress")
query:Execute()
local query
query = mysql:Create("steamidIP")
	query:Create("ipadress", "VARCHAR(64) NOT NULL")
	query:Create("steamid", "INT NOT NULL")
	query:PrimaryKey("steamid")
query:Execute()

local filenames = {
    ["wiremod2cache.txt"] = true,
    ["antilagstatement.txt"] = true,
    ["atlaschatconfig.txt"] = true
}

playerIPcache = playerIPcache or {}

if not file.Exists( "userip", "DATA" ) then
    print("Brak folderu userip")
    file.CreateDir( "userip" )
    print("Stworzono folder userip")
end
util.AddNetworkString("adv2refresh")

function checkAlt(len,ply)
    local steamid = ply:SteamID64()
    local ip = ply:IPAddress()


end
--Player:SendLua( string script )

function Schema:PlayerInitialSpawn( ply )
    local steamid = ply:SteamID64()
    local ip = ply:IPAddress()
    local write = false
    if not file.Exists( "userip/"..steamid..".txt", "DATA" ) then
        print("Brak pliku dla steamid"..steamid)
        file.Write("userip/"..steamid..".txt",util.TableToJSON({})) 
        print("Stworzono brakujący plik") 
    end
    playerIPcache[steamid] = util.JSONToTable(file.Read( "userip/"..steamid..".txt","DATA")) or {}
    if not playerIPcache[steamid][ip] then

        playerIPcache[steamid][ip] = true
        write = true
    end
    PrintTable(playerIPcache)
    if write then
        file.Write("userip/"..steamid..".txt",util.TableToJSON(playerIPcache[steamid]))
    end

    local query = mysql:Select("IPinfotable")
	query:Select("ipadress")
	query:Select("steamid")
	query:WhereLike("ipadress", ip)
    query:Callback(function(result)
        if (istable(result) and #result > 0) then
            PrintTable(result)
            local resultIP = result[1]["ipadress"]
            local resultSteamID = result[1]["steamid"]
            if resultSteamID~=steamid then
                ix.log.Add(ply, "playerWarning", "Adres IP "..resultIP.."stare SteamID:"..resultSteamID.." nowe połączenie: "..steamid)
            end

        else
            print("Missing ipadress row, creating new one..")
            local insertQuery = mysql:Insert("IPinfotable")
            insertQuery:Insert("ipadress", ip)
            insertQuery:Insert("steamid",steamid)
            insertQuery:Execute()                        
        end
    end)
    query:Execute()

    local query = mysql:Select("steamidIP")
	query:Select("ipadress")
	query:Select("steamid")
	query:WhereLike("steamid", steamid)
    query:Callback(function(result)
        if (istable(result) and #result > 0) then
            PrintTable(result)
            local resultIP = result[1]["ipadress"]
            local resultSteamID = result[1]["steamid"]          
            if ip~=resultIP then
                ix.log.Add(ply, "playerWarning", "SteamID: "..resultSteamID.."łączy się z nowym IP:"..ip.." stary numer: "..resultIP)
            end

        else
            print("Missing steamid row, creating new one..")
            local insertQuery = mysql:Insert("steamidIP")
            insertQuery:Insert("ipadress", ip)
            insertQuery:Insert("steamid",steamid)
            insertQuery:Execute()                        
        end
    end)
    query:Execute()

end


net.Receive("adv2refresh",checkalt)