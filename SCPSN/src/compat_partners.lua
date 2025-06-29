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
Partner_API.Partner{
    key = "rerolling_contest_host",
    name = "rerolling_contest_host",
    individual_quips = true, -- Whether to have unique starting quips (located in localization cause u gotta do that??)
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
            change_shop_size(2)
        end
	end

}