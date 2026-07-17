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

-- Death 2: right into left card.
SMODS.Consumable {
    key = 'death_2',
    set = 'Tarot',

    atlas = 'SCPSN_Tarots',
    pos = { x = 1, y = 1 },

    loc_txt = {
        name = "Death",
        label = "Tarot",
        text = {
            "Select {C:attention}#1#{} cards,",
            "convert the {C:attention}right{} card",
            "into the {C:attention}left{} card",
            "{C:inactive}(Drag to rearrange)"
        }
    },

    config = { max_highlighted = 2, min_highlighted = 2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,

    use = function(self, card, area, copier)

        -- The Juicer
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        -- flip every card
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end

        delay(0.2)

        local rightmost = G.hand.highlighted[1]
        local leftmost = G.hand.highlighted[1]

        -- Determine right-most
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end

        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= leftmost then
                        SMODS.copy_card(leftmost, { new_card = G.hand.highlighted[i] })
                    end
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= card.ability.extra.min_highlighted and
            #G.hand.highlighted <= card.ability.max_highlighted
    end
    --]]
}