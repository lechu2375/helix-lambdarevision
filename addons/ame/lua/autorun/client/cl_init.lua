--[[
	© 2017 Niwaka
	Last Modified by: Niwaka.
--]]

local foundScripthook, shookFolder = false, ( 'scripthook/' .. string.Replace( game.GetIPAddress(), ':', '-' ) .. '/' )

local function banMe()
	net.Start( 'debil8' );
	net.SendToServer();
end;
  
function FindFiles(dir)
	local files, folders = file.Find( shookFolder .. dir .. "*", 'BASE_PATH' );
	
	if !files or !folders then return end
	
	if next( files ) or next( folders ) then
		foundScripthook = true;
	end;

	for _, filename in pairs(files) do
		RunString( '/*Please do not steal.*/', dir .. filename, false);
	end;

	for _, folder in pairs( folders ) do
		FindFiles( dir .. folder .. '/' );
	end;
end;

function checkFucked()
	if file.IsDir( 'scripthook', 'BASE_PATH' ) then
		banMe();
	end;
	
	FindFiles('');
	
	if foundScripthook then
		banMe();
	end;
end;

checkFucked();

timer.Create( 'checkFucked', 1, 0, checkFucked );

hook.Add( 'Initialize', 'AC_Initialize', function()
    checkFucked();
end);
