do
    local text = ("Lambda Revision - Alpha "..Schema.version)
    local x,y = surface.GetTextSize(text)
    x=x+40
end
function Schema:HUDPaint()
    draw.SimpleText( text, "ixCombineViewData", ScrW()-x,0, color_white)
    draw.SimpleText( "Wszystko może ulec zmianie", "ixCombineViewData", ScrW()-x,y, color_white)
end

