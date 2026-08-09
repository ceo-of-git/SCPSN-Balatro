-- ATLAS
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Spectrals",
	-- The name of the file, for the code to pull the atlas from
	path = "Spectrals.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- Cleansing
SMODS.Consumable {
    key = 'Cleansing',
    set = 'Spectral',

    atlas = 'SCPSN_Spectrals',
	pos = { x = 0, y = 0 },

    loc_txt = {
        name = "Cleansing",
        label = "Spectral",
        text = {
            "Set suffered Curse count to {C:green}0{}",
            "{C:dark_edition,s:0.8}Repeated usage means diminishing results.{}",
            "{C:dark_edition,s:0.7}#2# Curses have been suffered this run.{}",
        }
    },
    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                G.GAME.curse_uses = 0
                return true
            end
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
        return true
    end,
    
    draw = function(self, card, layer) -- Does Shader Stuff
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}