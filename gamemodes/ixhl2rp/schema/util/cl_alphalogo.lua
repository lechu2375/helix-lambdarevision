
function Schema:LoadFonts()
    local text = ("Lambda Revision - Alpha "..Schema.version)
    surface.SetFont("ixCombineViewData")
    local x,y = surface.GetTextSize(text)

    function Schema:HUDPaint()
        draw.SimpleText( text, "ixCombineViewData", ScrW()-x,0, color_white)
        draw.SimpleText( "Wszystko może ulec zmianie", "ixCombineViewData", ScrW()-x,y, color_white)
    end
end

