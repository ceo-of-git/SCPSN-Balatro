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
	key = "SCPSN_Jokers_Legendary",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers_Legendary.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- False Son
SMODS.Sound({key = "false_son", path = "false_son_proc.ogg",})
SMODS.Joker {
	key = 'false_son',
	loc_txt = {
		name = 'False Son',
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
			
			"All Scored cards turn {X:dark_edition,C:white}Negative{}",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { Xmult = 6.0 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Legendary',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },

	rarity = 4,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 25,					-- Cost of card in shop.
	pools = {["scpsn_addition_legendary"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.Xmult,
			}
		}
	end,

    calculate = function(self, card, context)
		if context.before and context.main_eval then
			for _, scored_card in ipairs(context.scoring_hand) do
				scored_card:set_edition('e_negative', true)
			end

			play_sound('scpsn_false_son', nil, 0.5)
		end
    end
}



----------------------------------------------------------
----------- MOD CODE END -----------------------=---------