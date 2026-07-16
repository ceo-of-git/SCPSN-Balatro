local default_font = nil

-- Custom font for the Stroker
SMODS.Font {
    key = "stroker_font",
    path = "utter-nonsense.ttf",
    render_scale = 20,
    TEXT_HEIGHT_SCALE = 0.90,
    TEXT_OFFSET = {x=0,y=0},
    FONTSCALE = 1.00,
    squish = 1,
    DESCSCALE = 1
}

-- Changes the font the game has,
-- comes with 500 different UI bugs.
-- each more severe than the last
function swap_font(font_key)
    local font = SMODS.Fonts[font_key] or G.FONTS[font_key]

    if not default_font then
        default_font = G.LANG.font
    end

    if not font then
        print("Missing SMODS font:", font_key)
        return
    end

    if font_key == "default" then
        G.LANG.font = default_font
    end

    G.LANG.font = font
end

-- Sets the font back to normal
function reset_font()
    if default_font then
        G.LANG.font = default_font
    end
end