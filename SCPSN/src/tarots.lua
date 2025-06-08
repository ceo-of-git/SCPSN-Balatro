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
        play_sound('someone_cooked_here', nil, 0.5)
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
            "Turn 1 selected card",
            "{X:planet,C:white}96.2%{} Pure."
        }
    },

    config = { max_highlighted = 2, mod_conv = 'm_scpsn_unpure' },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

SMODS.Sound({key = "judgement_scpsn", path = "joker_landing.ogg",})
SMODS.Consumable {
    key = 'scspn_judgement',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 2, y = 0},

    loc_txt = {
        name = "JUDGEMENT!",
        label = "JUDGEMENT!",
        text = {
            "Spawn a random Joker from",
            "the {X:chips,C:white}SCPSN{} mod.",
            "{C:inactive,s:0.8}(Legendaries Excluded){}"
        }
    },

    -- Yoinked form Yahoo mod.
    use = function(self, card, area, copier)
        local card = create_card("scpsn_addition", G.Jokers, nil, nil, nil, nil, nil, 'scpsn')
        card:add_to_deck()
        G.jokers:emplace(card)
        play_sound('scpsn_judgement_scpsn', nil, 0.5)
    end,

    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}