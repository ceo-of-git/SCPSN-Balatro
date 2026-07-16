-- 1. ATLAS (Atlas')
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Decks",
	-- The name of the file, for the code to pull the atlas from
	path = "Decks.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Back{
    key = "the_elon_musk",
    loc_txt = {
        name = "The Elon Musk",
        text = {
            "{C:money}All cards are Golden{}",
            "Rental Jokers are Enabled & Pricier",
            "-16$ per hand left at end of blind",
            "Rerolls start at 20$"
        }
    },

    atlas = "SCPSN_Decks",
    pos = { x = 2, y = 0 },

    apply = function(self, back)
        G.GAME.starting_params.reroll_cost = 20;
        G.GAME.starting_params.rental_rate = 9;
        G.GAME.modifiers.enable_rentals_in_shop = true
        G.GAME.modifiers.money_per_hand = -16;

        G.E_MANAGER:add_event(Event({
            func = function()
                for _, playing_card in ipairs(G.playing_cards) do
                    playing_card:set_ability("m_gold")
                end
                return true
            end
        }))

        
    end,

    check_for_unlock = function(self, args)
        return true;
    end
}

SMODS.Back{
    key = 'run_the_slots',
    loc_txt = {
        name = "Run the Slots!!!",
        text = {
            "I LOVE GAMBLING!!!",
            "Rentals appear in shops",
            "Start with {C:money}20${}"
        }
    },

    atlas = "SCPSN_Decks",
    pos = { x = 0, y = 0 },

    config = { extra = { shopSlotSubtraction = 1} },
    loc_vars = function (self, info_queue, back)
        return { vars = self.config.extra.shopSlotSubtraction }
    end,

    apply = function(self, back)
        G.GAME.starting_params.dollars = 20
        G.GAME.modifiers.enable_rentals_in_shop = true;
    end,
}

SMODS.Back{
    key = 'joker_poker_balala',
    loc_txt = {
        name = "Joker Poker -- Balala",
        text = {
            "{C:attention}8 Joker Slots{}",
            "Start with {C:money}-10${}",
        }
    },

    atlas = "SCPSN_Decks",
    pos = { x = 1, y = 0 },

    config = { extra = { shopSlotSubtraction = 1} },
    loc_vars = function (self, info_queue, back)
        return { vars = self.config.extra.shopSlotSubtraction }
    end,

    apply = function(self, back)
        G.GAME.starting_params.dollars = -10
        G.GAME.starting_params.joker_slots = 8
    end,
}

