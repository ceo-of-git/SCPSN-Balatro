-- Compatibility with the Partner API
-- https://github.com/Icecanno/Partner-API/

-- 1. ATLAS (Atlas')
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Partners_Compat",
	-- The name of the file, for the code to pull the atlas from
	path = "Partners_Compat.png",
	-- Width of each sprite in 1x size
	px = 46,
	-- Height of each sprite in 1x size
	py = 58
}

print("TEST")

-- Special Ops Partner
-- Retrigger last card played twice if played hand is a Pair
Partner_API.Partner{
    key = "special_ops",
    name = "special_ops",
    individual_quips = true, -- Whether to have unique starting quips (located in localization cause u gotta do that??)
    unlocked = true,
    discovered = true,
    atlas = "SCPSN_Partners_Compat",
    pos = {x = 0, y = 0},

    config = { extra = { repetitions = 2, type = 'Pair'}, },

    link_config = {j_scpsn_trepang_joker = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 1 end
        return { vars = {card.ability.extra.repetitions, card.ability.extra.repetitions + benefits, localize(card.ability.extra.type, 'poker_hands')} }
    end,

    loc_txt = {
        name = 'Special Ops',
        text = {
            "Retrigger last played",
            "card {C:attention}#2#{} times.",
            "if hand is a {C:attention}Pair{}"
        }
    },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.type]) then
			if context.other_card == context.scoring_hand[#context.scoring_hand] then
                local link_level = self:get_link_level()
                local benefits = 0
                if link_level == 1 then benefits = 1 end

				return {
                	repetitions = card.ability.extra.repetitions + benefits,
                    message = "Again!"
            	}
			end
        end
    end
}

-- Illegal Poker Hand Partner
-- Be able to discard 2 extra cards 
Partner_API.Partner{
    -- Im sure there are 0 bugs with this guy
    key = "illegal_pokerhand",
    name = "illegal_pokerhand",
    individual_quips = true, -- Whether to have unique starting quips (located in localization cause u gotta do that??)
    unlocked = true,
    discovered = true,
    atlas = "SCPSN_Partners_Compat",
    pos = {x = 1, y = 0},

    config = { extra = { extradiscards = 2}, },

    link_config = {j_scpsn_sixfingers_but_cool = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 0 end
        return { vars = {card.ability.extra.extradiscards, card.ability.extra.extradiscards + benefits} }
    end,

    loc_txt = {
        name = 'Paid off Dealer',
        text = {
            "Allows you to discard",
            "{C:attention}#1#{} extra cards",
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.round == 1 then
            SMODS.change_discard_limit(2)
        end
	end
}

-- Rerolling Competition Partner
-- +2 Jokers in Shop
Partner_API.Partner{
    key = "rerolling_contest_host",
    name = "rerolling_contest_host",
    no_quips = true,
    unlocked = true,
    discovered = true,
    atlas = "SCPSN_Partners_Compat",
    pos = {x = 2, y = 0},

    config = { extra = { extrashopcards = 2}, },

    link_config = {j_scpsn_rerolling_competition = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 0 end
        return { vars = {card.ability.extra.extrashopcards, card.ability.extra.extrashopcards + benefits} }
    end,

    loc_txt = {
        name = 'Contest Host',
        text = {
            "{C:attention}+#1#{} Jokers in shop",
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.round == 1 then
            change_shop_size(card.ability.extra.extrashopcards)
        end
	end

}

-- Cook Partner
-- 1/2 chance to convert 1 held card into either 99.1% or 96.2% pure enhancement
Partner_API.Partner{
    key = "cook",
    name = "cook",
    individual_quips = true, -- Whether to have unique starting quips (located in localization cause u gotta do that??)
    unlocked = true,
    discovered = true,
    atlas = "SCPSN_Partners_Compat",
    pos = {x = 3, y = 0},

    config = { extra = {odds = 2, cardstoconvert = 1}, },

    link_config = {j_scpsn_bulletin_board = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 0 end
        return { vars = {card.ability.extra.odds, card.ability.extra.cardstoconvert, card.ability.extra.cardstoconvert + benefits} }
    end,

    loc_txt = {
        name = 'The Cook',
        text = {
            "{C:green}1 in #1#{} Chance to convert {C:attention}#3#{} card in hand",
            "into a {X:chips,C:white}99.1%{} or {X:planet,C:white}96.2%{} at the end of every turn."
        }
    },

    calculate = function(self, card, context)
        if context.after then
            if pseudorandom('cook_partner') < G.GAME.probabilities.normal / card.ability.extra.odds then
                for i = 1, card.ability.extra.cardstoconvert do
                    if G.hand.cards[i] then
                        if pseudorandom("cook_partner_type") < G.GAME.probabilities.normal / 2 then
                            G.hand.cards[i]:set_ability("m_scpsn_pure")
                        else
                            G.hand.cards[i]:set_ability("m_scpsn_unpure")
                        end
                    end
                end 
            end
        end
    end

}

-- 57 Leaf Clover Partner
-- All probabilities are multiplied by 2, always have an expensive Mystery Box in the shop.
Partner_API.Partner{
    key = "57_leaf_clover",
    name = "57_leaf_clover",
    no_quips = true,
    unlocked = true,
    discovered = true,
    atlas = "SCPSN_Partners_Compat",
    pos = {x = 4, y = 0},

    config = { extra = {}, },

    link_config = {j_scpsn_mystery_box = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 0
        if link_level == 1 then benefits = 0 end
        return { vars = {} }
    end,

    loc_txt = {
        name = '57 Leaf Clover',
        text = {
            "{C:green}Doubles every chance{}",
            "Adds a 30$ {C:dark_edition}Mystery Box{} to every shop",
            "{C:inactive}(Only after re-rolling atleast once!){}"
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.round == 1 then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v * 2
            end
        end

        if context.reroll_shop then
            local mystery_box = SMODS.create_card{
                set = "Joker",
                area = G.shop_jokers,
                key = "j_scpsn_mystery_box"
            }

            G.shop_jokers:emplace(mystery_box)
            create_shop_card_ui(mystery_box, "Joker", G.shop_jokers)

            print("MYSTERY BOX DONE!")
        end
    end

}