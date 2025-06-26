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

-- Jesse Pinkman (96.2% Purity)
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

-- JUDGEMENT!
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

-- Steam Trading Card
SMODS.Consumable {
    key = 'scpsn_steam_trading_card',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 0, y = 1},

    loc_txt = {
        name = "Steam Trading Card",
        label = "Steam Trading Card",
        text = {
            "Gives {C:money}+1${} per card in deck",
            "subtracted by 40 {C:inactive,s:0.8}(ex: 52 - 40 = 12$){}",
            "{C:inactive,s:0.8}(Max: #1#$){}"
        }
    },

    config = { extra = { max = 80 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max } }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(math.max(0, math.min((#G.deck.cards - 40), card.ability.extra.max)), true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

-- The Kunai (Apply Deathmark)
SMODS.Consumable{
    key = 'tarot_kunai',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = {x = 1, y = 1},

    config = { max_highlighted = 3, mod_conv = 'm_scpsn_marked' },

    loc_txt = {
        name = "The Kunai",
        label = "Kunai",
        text = {
            "First select {C:attention}3{} cards {C:inactive}/{}",
            "Then apply Deathmark to them {C:inactive}/{}",
            "{C:attention}Marked{} cards cant {C:mult}debuff{}"
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}