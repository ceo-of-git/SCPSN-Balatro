-- Big Shoutouts to the Yahimod & Cryptid (where i may or may not have 'repurposed' code from)
-- those the GOATS.

assert(SMODS.load_file("src/jokers_common.lua"))()
assert(SMODS.load_file("src/jokers_uncommon.lua"))()
assert(SMODS.load_file("src/jokers_rare.lua"))()
assert(SMODS.load_file("src/jokers_legendary.lua"))()
assert(SMODS.load_file("src/bosses.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
assert(SMODS.load_file("src/booster_packs.lua"))()
assert(SMODS.load_file("src/decks.lua"))()
--assert(SMODS.load_file("src/seals.lua"))()
--assert(SMODS.load_file("src/vouchers.lua"))()
--assert(SMODS.load_file("src/editions.lua"))()
--assert(SMODS.load_file("src/spectrals.lua"))()

if next(SMODS.find_mod('partner')) then -- Optional Partners Dependency
    print("[SCPSN] Partner Compatability LOADING")
    assert(SMODS.load_file("src/partner_compat.lua"))()
end

-- SCPSN Joker Pool(s)
-- Code taken from Yahimod
SMODS.ObjectType({
	key = "scpsn_addition",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "tower_card",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

--Load Localization file(s maybe)
assert(SMODS.load_file("localization/en-us.lua"))()




-- Credits Page
SMODS.current_mod.extra_tabs = function()
    local scale = 0.5
    return {
        label = "Credits",
        tab_definition_function = function()
        return {
            n = G.UIT.ROOT,
            config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
            },
            nodes = {
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "By ceo_of_balatro & TheMaster",
                    shadow = false,
                    scale = scale*2,
                    colour = G.C.PURPLE
                    }
                }
                }
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Code kindly stolen from:",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                },
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Cryptid Mod & the Yahimod",
                    shadow = false,
                    scale = scale,
                    colour = G.C.GREEN
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Additional Music:",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "A Heart of Cold - Heaven Pierce Her / Dead Heat Pulse - Heaven Pierce Her",
                    shadow = false,
                    scale = scale*0.75,
                    colour = G.C.RED
                    }
                }
                } 
            }
            }
        }
        end
    }
end



----------------------------------------------
------------MOD CODE END----------------------

