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

-- Walter White (99.1% Purity)
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
            "Turn 2 Selected Cards {X:chips,C:white}99.1%{} Pure.",
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

SMODS.Consumable{
    key = 'tarot_methcompanion',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 1, y = 0},

    loc_txt = {
        name = "The Companion",
        label = "Companion",
        text = {
            "Turn 2 Selected Cards",
            "{X:planet,C:white}96.2%{} Pure."
        }
    },

    config = { max_highlighted = 2, mod_conv = 'm_scpsn_unpure' },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

SMODS.Consumable {
    key = 'scspn_judgement',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 2, y = 0},

    loc_txt = {
        name = "JUDGEMENT!",
        label = "JUDGEMENT!",
        text = {
            "Create {C:attention}2{} random {C:attention}rental{}",
            "{C:green}uncommon{} Jokers.",
            "{C:inactive,s:0.8}(Ignores Joker Slots){}"
        }
    },

    -- Yoinked form Yahoo mod.
    use = function(self, card, area, copier)
        -- G.jokers.cards[i].config.center.pools.scpsn_addition
        SMODS.add_card {
            set = 'Joker',
            rarity = 'Uncommon',
            stickers = { "rental" },
            key_append = 'ps_judgement' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
        }

        SMODS.add_card {
            set = 'Joker',
            rarity = 'Uncommon',
            stickers = { "rental" },
            key_append = 'ps_judgement' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
        }
        G.GAME.joker_buffer = 0
    end,

    can_use = function(self, card)
        return true -- ALWAYS...
    end
}