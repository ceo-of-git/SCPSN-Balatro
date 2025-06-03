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
            "{C:chips}+75 Chips{}",
        }
    },

    config = {
        h_chips = 75,
    }
}