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
	key = "SCPSN_Jokers_Lunar",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers_Lunar.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- 2. RARITY
-- First before we make lunar jokers we have to actually
-- make the Lunar Rarity... Duh. Obviously
SMODS.Rarity{
    key = 'lunar',
    loc_txt = {
        name = "Lunar",
    },

    badge_colour = HEX("ba8fdb"),
    default_weight = 3.00,
}

-- To set the custom rarity
-- rarity = "(mod prefix)_(rarity key)" (scpsn_lunar)

-- 3. JOKERS

-- Shaped Joker
SMODS.Joker {
	key = 'lunar_shaped_joker',
	loc_txt = {
		name = 'Shaped Joker',
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
			
			"{X:mult,C:white}X#1#{} Mult, {X:chips,C:white}X#2#{} Chips",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { XChips = 0.5, XMult = 3.0 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Lunar',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },

	rarity = 'scpsn_lunar',					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 10,					-- Cost of card in shop.
	pools = {["scpsn_addition_lunar"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
                card.ability.extra.XMult,
				card.ability.extra.XChips,
			}
		}
	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.XMult,
                xchips = card.ability.extra.XChips
            }
        end
    end
}

-- Bulwark Joker
SMODS.Joker {
	key = 'lunar_bulwark_joker',
	loc_txt = {
		name = 'Bulwark Joker',
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
			
			"{X:chips,C:white}X#1#{} Chips, {X:mult,C:white}X#2#{} Mult",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { XChips = 3.0, XMult = 0.5 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Lunar',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },

	rarity = 'scpsn_lunar',					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 10,					-- Cost of card in shop.
	pools = {["scpsn_addition_lunar"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
                card.ability.extra.XMult,
				card.ability.extra.XChips,
			}
		}
	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.XMult,
                xchips = card.ability.extra.XChips
            }
        end
    end
}

-- Heretical Joker
SMODS.Joker {
	key = 'lunar_heretical_joker',
	loc_txt = {
		name = 'Heretical Joker',
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
			
			"{C:green}+#1#{} Hand Size, {C:mult}#2#x{} Base Blind Size.",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = {hand_size = 5, blind_multiplier = 4.0} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Lunar',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },

	rarity = 'scpsn_lunar',					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 10,					-- Cost of card in shop.
	pools = {["scpsn_addition_lunar"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.hand_size,
                card.ability.extra.blind_multiplier,
			}
		}
	end,

    -- Extra Hand size
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips =  G.GAME.blind.chips * (card.ability.extra.blind_multiplier)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}

----------------------------------------------------------
----------- MOD CODE END -----------------------=---------