-- ATLAS
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Tarots",
	-- The name of the file, for the code to pull the atlas from
	path = "Tarots.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Consumable{
    key = 'tarot_methcook',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 0, y = 0},

    config = { max_highlighted = 2, mod_conv = 'm_scpsn_pure' },

    loc_txt = {
        name = "The Chef",
        label = "Cook",
        text = {
            "Turn 2 Selected Cards {X:chips,C:white}Pure.{}",
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}