--[[ 
	© 2017 Niwaka
	Last Modified by: Niwaka.
--]]

util.AddNetworkString( 'debil8' );

--[[ ULX BAN ]]--
net.Receive( 'debil8', function( len, ply )
    RunConsoleCommand( 'ulx', 'banid', ply:SteamID(), 0, 'Modified game executable file.' ); // You can change the ban time in, the value "0" = forever, and you can change the reason ban.
end);

--[[ GMOD BAN ]]--
/* net.Receive( 'debil8', function( len, ply )
    ply:Ban( 0, 'Reason' ); // You can change the ban time in, the value "0" = forever, and you can change the reason ban.
end); */

