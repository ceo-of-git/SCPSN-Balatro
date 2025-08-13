--- STEAMODDED HEADER
--- MOD_NAME: SCPSN
--- MOD_ID: scpsn
--- MOD_AUTHOR: ceo_of_balatro
--- MOD_DESCRIPTION: glanjazoonja
--- PREFIX: scpsn
----------------------------------------------------------
----------- MOD CODE -------------------------------------

-- 1. ATLAS (Atlas')
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Jokers_Common",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers_Common.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

print(SMODS.mods)

-- Mad Gambler
SMODS.Joker {
	key = 'mad_gambler',
	loc_txt = {
		name = 'The Mad Gambler',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]

			"{C:green}#1# in #2#{} chance to gain",
			"{C:money}$8{} When Joker is Scored",
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { odds = 4, dollars = 8} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',		-- Atlas ID (Set at the top of the file)
	pos = { x = 0, y = 0 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 3,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.dollars} }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
        if context.joker_main and pseudorandom('ps_gambling') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return {
                dollars  = card.ability.extra.dollars
            }
        end
    end
}


-- Go on a Fun Walk (Tower)
SMODS.Joker {
	key = 'fun_walk',
	loc_txt = {
		name = 'Go on a Fun Walk!',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:mult}+10{} Mult",
			"{X:mult,C:white}X#2#{} Mult",
			"Gains {X:mult,C:white}x0.01{} Mult per hand"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 10, Xmult = 1.00, Xmult_gain = 0.01 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 0 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'scpsn_tower_card'}
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.Xmult,
				card.ability.extra.Xmult_gain,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.joker_main then

			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain

			return {
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.Xmult
            }
		end
    end
}


-- Bridge (Tower)
SMODS.Joker {
	key = 'violence_bridge',
	loc_txt = {
		name = 'Truss Bridge',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:mult}+#1#{} Mult",
			"Given per card scored",
			"{C:green}#2# in #3# chance to turn{} {X:dark_edition,C:white}Negative{}",
			"{C:green}at the end of a round{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 1, odds = 15} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 0 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'scpsn_tower_card'}
		return {
			vars = {
				card.ability.extra.mult,
				G.GAME.probabilities.normal or 1,
				card.ability.extra.odds
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.blind_defeated then
			local randomChance = pseudorandom('ps_bridge')
			if randomChance < G.GAME.probabilities.normal / card.ability.extra.odds then
				card:set_edition('e_negative')
			end
		end

		if context.individual and context.cardarea == G.play then
            return {
				mult = card.ability.extra.mult,
            }
        end
    end
}

-- 161 Of Clubs
SMODS.Joker {
	key = 'shit_load_of_clubs',
	loc_txt = {
		name = '161 of Clubs',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:chips}+#1#{} Chips",
			"{C:chips}+1{} Chip per {C:clubs}Club Card{} Scored.",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { chips = 10, suit = 'Clubs', chip_mod = 1} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 1 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.chip_mod
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod

            return {
                message = 'Upgrade!',
                colour = G.C.CHIPS,
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Scared Joker
SMODS.Joker {
	key = 'scared_joker',
	loc_txt = {
		name = 'Scared Joker',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:mult}+#1#{} Mult",
			"Gains {C:mult}+#2#{} Mult per hand played.",
			"Resets whenever a card is sold.",
			'{s:0.6,C:inactive}( buddys scared of being sold :( ){}'

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 5, mult_mod = 2, mult_starting = 5} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 1 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.mult_mod,
				card.ability.extra.mult_starting,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Handles Scaring
		if context.selling_card then
            card.ability.extra.mult = card.ability.extra.mult_starting

            return {
                message = 'AHHHHHHHH!',
                colour = G.C.MULT,
            }
        end

		-- Gives Mult
        if context.joker_main then

			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                mult = card.ability.extra.mult,
				message = 'Upgrade!',
                colour = G.C.MULT,
            }
        end

		-- Upgrades
		if context.joker_main then
	

		end
    end
}

-- Hesitant Joker
SMODS.Joker {
	key = 'hesitant_joker',
	loc_txt = {
		name = 'Hesitant Joker',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:mult}+12{} Mult",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 12} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 1 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.mult_mod,
				card.ability.extra.mult_starting,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Upgrades
		if context.joker_main then
			return {
				delay(15),
				mult = card.ability.extra.mult
			}
		end
    end
}

-- The Cartel
function calculate_purity_levels()
	-- I think this is unused but im too scared to remove the code for this.
    local count = 0
    for _, card in ipairs(G.playing_cards) do
		if SMODS.has_enhancement(card, 'm_scpsn_pure') then
			count = count + 1.25
		end

		if SMODS.has_enhancement(card, 'm_scpsn_unpure') then
			count = count + 1.1
		end
	end
    return count
end
SMODS.Joker {
	key = 'cartel_card',
	loc_txt = {
		name = 'The Cartel',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"Gain +{X:mult,C:white}X0.25{} Mult per {X:chips,C:white}99.1%{} pure card &",
			"Gain +{X:mult,C:white}X0.10{} Mult per {X:planet,C:white}96.2%{} pure card",
			"in the entire deck",
			"{C:inactive}Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 1, gain_pure = 1.25, gain_unpure = 1.10} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 2 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	-- Not 100% Sure what this does at all.
    loc_vars = function(self, info_queue, card)
        local pure_tally = 1
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, 'm_scpsn_pure') then pure_tally = pure_tally + 0.25 end
				if SMODS.has_enhancement(playing_card, 'm_scpsn_unpure') then pure_tally = pure_tally + 0.10 end
			end
			card.ability.extra.xmult = pure_tally
		end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult + pure_tally } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
    end,

	-- Can only appear if a 99.1% or 96.2% pure card is in the deck.
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_scpsn_pure') or SMODS.has_enhancement(playing_card, 'm_scpsn_unpure') then
                return true
            end
        end
        return false
    end,
}

-- Stone Golem
SMODS.Joker {
	key = 'stone_golem',
	loc_txt = {
		name = 'Stone Golem',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"Played {C:inactive}Stone{} Cards",
			"Give {C:mult}+#1#{} Mult when scored"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 6 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 2 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_stone') then
				return {
					mult = card.ability.extra.mult
				}
			end
        end
    end,
}

-- Jooner
SMODS.Joker {
	key = 'jooner',
	loc_txt = {
		name = 'Jooner',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:attention}Prevents Death{} if scored",
			"chips are above 90% the required amount."

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 6 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 2 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
			}
		}
	end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if G.GAME.chips / G.GAME.blind.chips >= 0.90 then -- See note about Talisman compatibility at the bottom
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = localize('Saved!'),
                    saved = 'Saved by Jooner!',
                    colour = G.C.RED
                }
            end
        end
    end,
}

-- Jokers Basics'
SMODS.Joker {
	key = 'baldi_joker',
	loc_txt = {
		name = 'Jokers Basics',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{X:mult,C:white}X#1#{} Mult when a 3 is Scored",
			"{C:mult}+#2#{} Mult when a 9 is Scored",
			"{C:inactive,s:0.8}\"That's nice dear\"{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 1.3, mult = 9 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 3 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.mult,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 3 then
				return {
					xmult = card.ability.extra.xmult
				}
			end
			if context.other_card:get_id() == 9 then
				return {
					mult = card.ability.extra.mult
				}
			end
        end
    end,
}

-- :Evil Joker:
SMODS.Joker {
	key = 'evil_joker',
	loc_txt = {
		name = ':evil_joker:',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]

			"{C:mult}#1#{} Mult, {X:mult,C:white}X#2# {} Mult"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = -4, xmult = 1.4 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',		-- Atlas ID (Set at the top of the file)
	pos = { x = 1, y = 3 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 2,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
				xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Ticking Time Bomb
-- Coded by TheMaster
SMODS.Joker {
	key = 'ticking_bomb',
	loc_txt = {
		name = 'Ticking Time Bomb',
		text = {
			"{C:mult}+#1#{} Mult",
			"{X:mult,C:white} X#2# {} Mult",

			"{C:green}#3# in #4#{} chance this",
			"bomb explodes and you lose",
			"at end of round",
		}
	},
	config = { extra = { mult = 35, Xmult = 3, odds = 6 } },
	rarity = 1,
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 3 },
	cost = 5,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
	-- Gros Michel is incompatible with the eternal sticker, so this makes sure it can't be eternal.
	eternal_compat = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end

		-- Checks to see if it's end of round, and if context.game_over is false.
		-- Also, not context.repetition ensures it doesn't get called during repetitions.
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			-- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
			if pseudorandom('ps_tickingbomb') < G.GAME.probabilities.normal / card.ability.extra.odds then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.STATE = G.STATES.GAME_OVER
						G.STATE_COMPLETE = false
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))

				return {
					message = 'Exploded!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end
}

-- The House
-- Coded by TheMaster
SMODS.Joker {
	key = 'thehouse',
	loc_txt = {
		name = 'The House Always Wins',
		text = {
			"Earn {C:money}$#1#{} at",
			"at end of round. {C:green}#2# in #3#{} chance to",
			"lose {C:money}$#4# {}",
			"{C:inactive,E:1,s:0.8}Perhaps you just need more mousebites{}"
		}
	},
	config = { extra = { money = 8, odds = 3, lol_ur_in_debt_now = 25, }, },
	rarity = 1,
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 4 },
	cost = 6,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.lol_ur_in_debt_now} }
	end,
	-- SMODS specific function, gives the returned value in dollars at the end of round, double checks that it's greater than 0 before returning.	
	calc_dollar_bonus = function(self, card)
		if pseudorandom('thehouse') < G.GAME.probabilities.normal / card.ability.extra.odds then
			local bonus = -card.ability.extra.lol_ur_in_debt_now
			if bonus then return bonus end
		else
			local bonus = card.ability.extra.money
			return bonus end
			
	-- Since there's nothing else to calculate, a calculate function is completely unnecessary.
	end

}

-- :steamhappy:
-- Coded by TheMaster
SMODS.Joker {
	key = 'steamhappy',
	loc_txt = {
		name = ':steamhappy:',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]

			"You Win!"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { Xmult = 100, odds = 25 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 4 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary.

	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 3,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
        if context.joker_main then
			if pseudorandom('ps_steamhappy') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					Xmult = card.ability.extra.Xmult
				}
			end
        end
    end
}

-- SERE KIT
SMODS.Joker {
	key = 'SERE_KIT',
	loc_txt = {
		name = 'SERE KIT',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]

			"When sold, gain {C:chips}+#1#{} Hands"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { extrahands = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',		-- Atlas ID (Set at the top of the file)
	pos = { x = 2, y = 4 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = false,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.extrahands } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

        if context.selling_self then
			ease_hands_played(card.ability.extra.extrahands, true)
		end
    end
}

-- The Blue Gentleman
SMODS.Joker {
	key = 'blue_gentleman',
	loc_txt = {
		name = 'Blue Gentleman',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{X:chips,C:white}X#1#{} Chips",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xchips = 1.5} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 5},
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xchips,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

-- Evil Brian
SMODS.Joker {
	key = 'evilbrian',
	loc_txt = {
		name = 'evil brian',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:chips}+#1#{} Chips",
			"{C:inactive}Gains{} {C:chips}+#2#{} {C:inactive}Chips whenever{}",
			"{C:inactive}cards are destroyed.{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { chips = 0, chips_mod = 35} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 5},
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.chips_mod,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

		if context.remove_playing_cards and not context.blueprint and not context.using_consumeable then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')

					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod

					return {
						message = 'Upgraded!',
					}

				end
			}))

			return nil
		end
    end
}

-- Loader Bot
SMODS.Joker {
	key = 'loader_bot',
	loc_txt = {
		name = 'Loader Bot',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"{C:green}#1# in #2#{} Chance to call in a",
			"{X:chips,C:white}Cook{} or {X:planet,C:white}Companion{} tarot card",
			"when {C:attention}Blind Selected{}, {C:inactive}(Must have Room){}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { odds = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 5},
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			if pseudorandom('ps_loaderbot') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

				if pseudorandom('ps_loaderbot_2') < 0.5 then
					G.E_MANAGER:add_event(Event({
						func = (function()
							G.E_MANAGER:add_event(Event({
								func = function()
									local theCook = SMODS.create_card{key= "c_scpsn_tarot_methcook"}
									G.consumeables:emplace(theCook)
									G.GAME.consumeable_buffer = 0
									return true
								end
							}))
							SMODS.calculate_effect({ message = "Deployed!", colour = G.C.BLUE },
								context.blueprint_card or card)
							return true
						end)
					}))
					return nil, true -- This is for Joker retrigger purposes
				else
					G.E_MANAGER:add_event(Event({
						func = (function()
							G.E_MANAGER:add_event(Event({
								func = function()
									local theCompanion = SMODS.create_card{key= "c_scpsn_tarot_methcompanion"}
									G.consumeables:emplace(theCompanion)
									G.GAME.consumeable_buffer = 0
									return true
								end
							}))
							SMODS.calculate_effect({ message = "Deployed!", colour = G.C.BLUE },
								context.blueprint_card or card)
							return true
						end)
					}))
					return nil, true -- This is for Joker retrigger purposes
				end
			end
        end
    end
}

-- So Guys, We Did it!
SMODS.Sound({key = "so_guys_we_procced_it", path = "so_guys_we_did_it_proc.ogg",})
SMODS.Joker {
	key = 'so_guys_we_did_it',
	loc_txt = {
		name = 'So guys we did it',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"After reaching a {C:attention}quarter of a million{}",
			"required score, activate {X:mult,C:white}X#1#{} Mult",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 12 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 6},
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { ( card.ability.extra.xmult ) } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.blind.chips >= 250000 then
				-- So guys we did it.
				play_sound('scpsn_so_guys_we_procced_it', nil, 0.5)
				return {
					delay(8 * G.SETTINGS.GAMESPEED),
					xmult = card.ability.extra.xmult
				}
			end
		end
    end
}

-- Targetted Joker (Deathmark exclusive!)
SMODS.Joker {
	key = 'wanted_joker',
	loc_txt = {
		name = 'Targetted Joker',
		text = {
			--[[
			- The #1# is a variable that's stored in config, and is put into 'loc_vars'.

			FORMATTING:
			{C:} -> Color ... Options: mult (red), chips (blue), money (yellow), inactive (dull gray), red (discards), attention (bright orange), dark_edition (negative), green (green)
			{X:} -> Background color, usually used for XMult
			{s:} -> Scale, multiplies the text size by the value, like 0.8
			{V:} -> Variable, allows for a variable to dynamically change the color, like in Castle joker.

			You can put in {} to RESET all formatting, similar to HTMLS "</color>".
			#1# = Variable #1 (in the Config section), #2# = Variable #2, etc.

			Example:
			{C:mult}+#1# {} Mult  ->  +4 Mult
			]]
			
			"Played {X:mult,C:white}Marked{} Cards",
			"give {C:money}#1#${} when Scored",
			"and are then {C:mult}destroyed{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { dolladolla = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 1, y = 6},
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 10,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { ( card.ability.extra.dolladolla ) } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_scpsn_marked') then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dolladolla
            return {
                dollars = card.ability.extra.dolladolla,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

		if context.after and context.main_eval and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_scpsn_marked') then
					if scored_card and not scored_card.ability.eternal and not scored_card.getting_sliced then
						scored_card.getting_sliced = true
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:juice_up(0.8, 0.8)
								scored_card:start_dissolve({ HEX("42301d") }, nil, 1.6)
								SMODS.destroy_cards(scored_card)
								return true
							end
						}))
					end
				end
            end

			return {
				message = "Boom, Headshot."
			}
        end
    end,

	-- Can only appear if a Deathmarked card is in the deck.
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_scpsn_marked') then
                return 
            end
        end
        return false
    end,
}

-- The Protagonist
SMODS.Joker {
	key = 'cruelty_squad_jonkler',
	loc_txt = {
		name = 'The Protagonist',
		text = {
			
			"Destroy scored {C:attention}Kings{}",
			"{C:mult}+#1#{} Mult and {C:money}+#2#${} Cash",
			"when a face card is scored",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 3, dollars = 0.5 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 2, y = 6 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.dollars,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Give mult for played Face Cards
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_face() then
				ease_dollars(card.ability.extra.dollars, false)

				return {
					mult = card.ability.extra.mult,
				}
			end
        end

		-- Destroy Scored King Cards
		if context.after and context.main_eval and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
				if scored_card:get_id() == 13 and not SMODS.has_enhancement(scored_card, 'm_stone' ) then 
					if scored_card and not scored_card.ability.eternal and not scored_card.getting_sliced then
						scored_card.getting_sliced = true
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:juice_up(0.8, 0.8)
								scored_card:start_dissolve({ HEX("42301d") }, nil, 1.6)
								SMODS.destroy_cards(scored_card)
								return true
							end
						}))

						return {
							message = "Job Complete."
						}
					end
				end
            end
        end
    end,
}

-- Encrusted Key
SMODS.Joker {
	key = 'encrusted_key',
	loc_txt = {
		name = 'Encrusted Key',
		text = {
			
			"Next shop is Guaranteed to have",
			"a {C:planet}spectral pack{}",
			"{C:mult}Self Destructs after next shop{}",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { }, },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Common',
	pos = { x = 0, y = 7 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = false,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 2,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Summon Spectral pack at start of shop
		if context.starting_shop then
			SMODS.add_booster_to_shop("p_spectral_mega_1")
        end

		-- Destroy Self at shops end
		if context.ending_shop then
			local sliced_card = card
			local destroyedJokerCount = 0
			if sliced_card and not sliced_card.ability.eternal and not sliced_card.getting_sliced then
				destroyedJokerCount = destroyedJokerCount + 1
				sliced_card.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("904fc2") }, nil, 3)
						return true
					end
				}))
			end
		end
    end,
}

----------------------------------------------------------
----------- MOD CODE END -----------------------=---------