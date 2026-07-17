-- ATLAS
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Enhancements",
	-- The name of the file, for the code to pull the atlas from
	path = "Enhancements.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- Pure
SMODS.Enhancement{
    key = 'pure',
    atlas = 'SCPSN_Enhancements',
    pos = { x = 0, y = 0},
    shatters = true,

    loc_txt = {
        name = "99.1% Purity",
        label = "Pure",
        text = {
            "When Held in Hand:",
            "{C:chips}+10{} Chips",
            "{X:chips,C:white}X1.2{} Chips"
        }
    },

    config = {
        h_chips = 10,
        h_x_chips = 1.2,
    }
}

-- Unpure
SMODS.Enhancement{
    key = 'unpure',
    atlas = 'SCPSN_Enhancements',
    pos = { x = 1, y = 0},
    shatters = true,

    loc_txt = {
        name = "96.2% Purity",
        label = "Pure",
        text = {
            "When Held in Hand:",
            "{C:chips}+45{} Chips",
        }
    },

    config = {
        h_chips = 45,
    }
}

-- Sophisticated
SMODS.Enhancement{
    key = 'sophisticated',
    atlas = 'SCPSN_Enhancements',
    pos = { x = 0, y = 1},
    shatters = false,
    always_scores = true,

    config = { extra = { dupe_amount = 2, dupe_chance = 4 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.dupe_amount,
                card.ability.extra.dupe_chance
			}
		}
	end,

    init = function(self)
        self.config.extra = {
            dupe_amount = 2,
            dupe_chance = 4
        }
    end,

    loc_txt = {
        name = "{f:scpsn_cursive_font}Sophisticated{}",
        label = "{f:scpsn_cursive_font}Sophisticated{}",
        text = {
            "Has a {C:green}1 in #2#{} chance to",
            "remove the {f:scpsn_cursive_font}Sophisticated{} status when scored",
            "and create {C:attention}#1#{} copies of the card into your hand.",
            "{C:attention}Failed rolls increase the copies made by 1{}"
        }
    },

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'scpsn_sophisticated_status', 1, card.ability.extra.dupe_chance) then
                -- Copy it DNA Style
                local copy_count = card.ability.extra.dupe_amount

                for i = 1, copy_count do
                    local copy_card = copy_card(card)
                    copy_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy_card)
                    G.hand:emplace(copy_card)
                    copy_card:set_ability('c_base', nil, true)
                    copy_card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copy_card:start_materialize()
                            return true
                        end
                    }))
                end

                -- Remove ability
                card:set_ability('c_base', nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        return true
                    end
                }))
            else
                card.ability.extra.dupe_amount = card.ability.extra.dupe_amount + 1
            end
        end
    end,
}
