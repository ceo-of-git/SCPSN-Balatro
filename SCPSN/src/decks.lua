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
    key = 'run_the_slots',
    loc_txt = {
        name = "Run the Slots!!!",
        text = {
            "I LOVE GAMBLING!!!",
            "{C:mult}-1{} Shop Slots",
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
        change_shop_size(-1)
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