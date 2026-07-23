-- curses are cards that give STRONG benefits but
-- have equally strong punishments along with harsh
-- diminishing results if used too much.

-- Defining what Curses are
SMODS.ConsumableType {
    key = "scpsn_curses",
    primary_colour = HEX('390836'),
    secondary_colour = HEX('390836'),
    collection_rows = { 6, 6 },
    shop_rate = 0.666,
    -- shader = "laminated",
    loc_txt = {
        name = "Curses",
        collection = "Curses",
    }
}

-- Curse Atlas
SMODS.Atlas {
	key = "SCPSN_curses",
	path = "Curses.png",
	px = 71,
	py = 95
}

-- Curse of the Classy (Common, Money for Sophisticated Text)
SMODS.Consumable {
    key = 'curse_of_the_classy',
    set = 'scpsn_curses',

    atlas = 'SCPSN_curses',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },

    pools = {["scpsn_curses_common"] = true},

    loc_txt = {
        name = "Curse of The Classy",
        text = {
            "Gain {C:money}#1#${} immediately",
            "ALL Text becomes {f:scpsn_cursive_font}sophisticated{}.",
            "{C:dark_edition,s:0.8}Repeated usage means diminishing results.{}",
            "{C:dark_edition,s:0.7}#2# Curses have been suffered this run.{}",
        }
    },

    config = { extra = { dollars = 25 } },
    loc_vars = function(self, info_queue, card)
        local total_curse_uses = G.GAME.curse_uses or 0
        local dollar_var = card.ability.extra.dollars - (total_curse_uses * 5)

        return { vars = { dollar_var, total_curse_uses } }
    end,
    

    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        local total_curse_uses = G.GAME.curse_uses or 0
        local dollar_var = card.ability.extra.dollars - (total_curse_uses * 5)

        ease_dollars(dollar_var)
        swap_font("scpsn_cursive_font")

        G.GAME.curse_uses = total_curse_uses + 1
    end,
}

-- Curse of the Wicked (Uncommon, converts deck editions with deletions)
SMODS.Consumable {
    key = 'curse_of_the_wicked',
    set = 'scpsn_curses',

    atlas = 'SCPSN_curses',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },

    pools = {["scpsn_curses_uncommon"] = true},

    loc_txt = {
        name = "Curse of The Wicked",
        text = {
            "Convert the enhancements of {C:attention}#1#{} cards",
            "in your deck to one randomly chosen enhancement.",
            "Randomly delete {C:mult}#2#{} other cards",
            "{C:dark_edition,s:0.8}Repeated usage means diminishing results.{}",
            "{C:dark_edition,s:0.7}#3# Curses have been suffered this run.{}",
        }
    },

    config = { extra = { converted_cards = 10, cards_to_delete = 8, } },
    loc_vars = function(self, info_queue, card)
        local total_curse_uses = G.GAME.curse_uses or 0
        local card_convert_var = math.max(card.ability.extra.converted_cards - total_curse_uses, 1)
        local cards_to_delete = math.max(card.ability.extra.cards_to_delete + total_curse_uses, 0)

        return { vars = { card_convert_var, cards_to_delete, total_curse_uses } }
    end,
    

    cost = 6,
    unlocked = true,
    discovered = true,
    hidden = false,
    
    can_use = function(self, card)
        -- If you have enough cards, you're good to go!
        local total_curse_uses = G.GAME.curse_uses or 0
        local card_convert_var = math.max(card.ability.extra.converted_cards - total_curse_uses, 1)
        return G.playing_cards and #G.playing_cards > card.ability.extra.cards_to_delete + total_curse_uses and #G.playing_cards > card_convert_var
    end,

    use = function(self, card, area, copier)
        local total_curse_uses = G.GAME.curse_uses or 0
        local card_convert_var = math.max(card.ability.extra.converted_cards - total_curse_uses, 1)
        local cards_to_delete = math.min(card.ability.extra.cards_to_delete + total_curse_uses, #G.playing_cards)

        local shuffled = {}
        for _, c in ipairs(G.playing_cards) do
            shuffled[#shuffled + 1] = c
        end
        pseudoshuffle(shuffled, pseudoseed("curse_wicked"))

        local selected_enhancement = SMODS.poll_enhancement({guaranteed = true})

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()

                -- Convert Cards
                for i = 1, math.min(card_convert_var, #shuffled) do
                    local c = shuffled[i]
                    if c then
                        c:set_ability(G.P_CENTERS[selected_enhancement], false)
                    end
                end

                -- Delete Cards
                for i = 1, math.min(cards_to_delete, #shuffled - card_convert_var) do
                    local removed_card = table.remove(shuffled)
                    if removed_card then
                        removed_card:start_dissolve()
                    end
                end

                G.GAME.curse_uses = total_curse_uses + 1

                return true
            end
        }))
    end,
}

-- Curse of the Spammer (Common, Creates 2 Negative copies of a joker, deletes all others, counts as 3 curses)
SMODS.Consumable {
    key = 'curse_of_the_spammer',
    set = 'scpsn_curses',

    atlas = 'SCPSN_curses',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },

    pools = {["scpsn_curses_rare"] = true},

    loc_txt = {
        name = "Curse of The Bot Spammer",
        text = {
            "Create {C:attention}#1#{} {C:dark_edition}Negative{} copies",
            "of a random joker, {C:mult}Deletes all non-negative Jokers{}",
            "{C:mult}Counts as 2 Curses{}",
            "{C:dark_edition,s:0.8}Repeated usage means diminishing results.{}",
            "{C:dark_edition,s:0.7}#2# Curses have been suffered this run.{}",
        }
    },

    config = { extra = { negative_copies = 4 } },
    loc_vars = function(self, info_queue, card)
        local total_curse_uses = G.GAME.curse_uses or 0
        local negative_copies = math.max(card.ability.extra.negative_copies - total_curse_uses, 1)

        return { vars = { negative_copies, total_curse_uses } }
    end,
    

    cost = 6,
    unlocked = true,
    discovered = true,
    hidden = false,
    
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,

    use = function(self, card, area, copier)
        local total_curse_uses = G.GAME.curse_uses or 0
        local negative_copies = math.max(card.ability.extra.negative_copies - total_curse_uses, 1)
        local selected_joker = G.jokers.cards[math.random(1, #G.jokers.cards)]

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                -- Make Negative Copies
                for i = 1, negative_copies do
                    SMODS.add_card {
                        set = 'Joker',
                        key = selected_joker.config.center_key,
                        edition = 'e_negative',
                        key_append = 'curses_spammer' -- Optional, useful for checking the source of the creation in `in_pool`.
                    }
                end

                -- Wipe Non-Negatives
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        card:start_dissolve()
                    end
                end

                return true
            end
        }))

        G.GAME.curse_uses = total_curse_uses + 2
    end,
}