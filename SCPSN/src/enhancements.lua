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

-- Marked
SMODS.Enhancement{
    key = 'marked',
    atlas = 'SCPSN_Enhancements',
    pos = { x = 2, y = 0},
    shatters = false,

    loc_txt = {
        name = "Marked",
        label = "Marked",
        text = {
            "Not much on its own {C:inactive}/{}",
            "Synergizes with Jokers {C:inactive}/{}",
            "Cannot be {C:mult}Debuffed{}"
        }
    },

    calculate = function(self, card, context)
        SMODS.debuff_card(card, 'prevent_debuff', 'scpsn_death_mark') -- Hopefully works?
    end
}
