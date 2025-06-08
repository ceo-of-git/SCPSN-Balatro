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
	key = "SCPSN_Jokers_Uncommon",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers_Uncommon.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- PS+ Giftcard
SMODS.Joker {
	key = 'ps_giftcard',
	loc_txt = {
		name = '1 Year of Playstation Plus',
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

      "{C:chips}Sell to Redeem!{}"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 8 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',		-- Atlas ID (Set at the top of the file)
	pos = { x = 0, y = 0 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = { ["scpsn_addition"] = true },


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
      if context.selling_self then
            return {
                func = function()
                    -- This is for retrigger purposes, Jokers need to return something to retrigger
                    -- You can also do this outside the return and `return nil, true` instead
                    G.E_MANAGER:add_event(Event({
                        func = (function()

							local towerCardKeys = {}

							for _, card in pairs(SMODS.Jokers) do
								if card.pools and card.pools["tower_card"] then
									table.insert(towerCardKeys, card.key)
								end
							end

							-- Pick a random index
							local randIndex = math.random(#towerCardKeys)

							-- Return the key
							local towerKey = towerCardKeys[randIndex]

							SMODS.add_card {
                            set = 'Joker',
                            key = towerKey,
                            key_append = 'ps_giftcard' -- Optional, useful for checking the source of the creation in `in_pool`.
                        }

                          return true
                        end)
                    }))
                end
            }
        end
    end
}


-- Blueberry Lasers
SMODS.Joker {
	key = 'blueberry_lasers',
	loc_txt = {
		name = 'Blueberry Lasers',
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
			
			"Retrigger all {C:clubs}Clubs{} {C:attention}1 {}Time.",
			"{C:mult}+0.5 Mult{} per {C:clubs}Club{} Scored."
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { repetitions = 1, mult = 0.5, suit = 'Clubs' } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 0 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.repetitions,
				card.ability.extra.suit,
				card.ability.extra.mult
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
		if context.repetition and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            return {
				mult = card.ability.extra.mult,
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}


-- Bulletin Board
SMODS.Sound({key = "breaking_bad", path = "breaking_bad_cook.ogg",})
SMODS.Joker {
	key = 'bulletin_board',
	loc_txt = {
		name = 'Bulletin Board',
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

			"{C:green}#1# in #2# chance",
			"to turn scored cards {X:chips,C:white}Pure.{}",
			"{s:0.8,C:inactive}It's pure glass!{}"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { odds = 4 } },
	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',		-- Atlas ID (Set at the top of the file)
	pos = { x = 2, y = 0 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds} }
	end,

    calculate = function(self, card, context)
		if context.before and context.main_eval then
			if pseudorandom('ps_walterwhite') < G.GAME.probabilities.normal / card.ability.extra.odds then
				for _, scored_card in ipairs(context.scoring_hand) do
					scored_card:set_ability('m_scpsn_pure', nil, true)
					scored_card:juice_up(0.3, 0.5)
				end

				message = "Batch Baked"
				play_sound('scpsn_breaking_bad')
			end
        end
    end
}


-- Spongebob (Tower)
SMODS.Joker {
	key = 'spongebob_bridge',
	loc_txt = {
		name = 'Sad Spongebob',
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
			
			"Sell this joker to",
			"Spawn in {C:attention}3 Perishable{} {X:dark_edition,C:white}Negative{} copies of",
			"the {C:chips}Truss Bridge{}",
			"{s:0.6,C:inactive}please don't do this...{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 1 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 8,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)

	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, 3 do
                        SMODS.add_card {
                            set = 'Joker',
							key = 'j_scpsn_violence_bridge',
							edition = 'e_negative',
							sticker = 'perishable',
                            key_append = 'vremade_spinglebobble' -- Optional, useful for checking the source of the creation in `in_pool`.
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
		end
    end
}

-- The Refusal (Luigi)
SMODS.Joker {
	key = 'outright_refusal',
	loc_txt = {
		name = 'The Refusal',
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
			
			"Debuffed cards are {C:mult}destroyed{}",
			"after scoring.",
			'{s:0.9,C:inactive}"No, I dont think I will."{}'

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 1 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
		if context.after and context.main_eval and not context.blueprint then

            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.debuff then
					if scored_card and not scored_card.ability.eternal and not scored_card.getting_sliced then
						scored_card.getting_sliced = true
						G.GAME.joker_buffer = G.GAME.joker_buffer - 1
						G.E_MANAGER:add_event(Event({
							func = function()
								card:juice_up(0.8, 0.8)
								scored_card:start_dissolve({ HEX("1cfc03") }, nil, 1.6)
								return true
							end
						}))
					end
				end
            end
        end
    end
}

-- Jokerknight Balatro
SMODS.Joker {
	key = 'demoknight_balatro',
	loc_txt = {
		name = 'Jokerknight Balatro',
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
			
			"Last scoring card",
			"Gives {X:mult,C:white}X2{} Mult"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 2, y = 1 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
            return {
				xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Deltarune is.... OUT!
SMODS.Joker {
	key = 'deltarune_jonkler',
	loc_txt = {
		name = 'DELTARUNE IS... OUT!!!',
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
			
			"Gains {C:mult}+1{} Mult every week since",
			"Deltarune came out of its demo",
			"{C:inactive}(Currently:{} {C:mult}+#1#{}{C:inactive})"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 0 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 2 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 12,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true},

	-- Not 100% Sure what this does at all.

    loc_vars = function(self, info_queue, card)
        local week_tally = 0
		local current_time = os.time()
		local deltarune_time = os.time{year = 2025, month = 6, day = 4}

		local week_tally = (current_time - deltarune_time) / 60 / 60 / 24 / 7
		week_tally = math.floor(week_tally)

		card.ability.extra.mult = week_tally
        return { vars = { card.ability.extra.mult, week_tally} }
    end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.joker_main then
			return { mult = card.ability.extra.mult }
		end
    end
}

-- Zamn!!! Shes ACE
SMODS.Joker {
	key = 'zamn_joker',
	loc_txt = {
		name = 'ZAMN!!!',
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
			
			"Gives {X:mult,C:white}X#1#{} mult if scored cards add up to 12",
			"{C:inactive}(Aces = 1, Face cards = 10, Stone = 2){}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 4 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 2 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 8,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		if context.joker_main then
			local leEpicCounter = 0

            for _, playing_card in ipairs(context.scoring_hand) do

				if SMODS.has_enhancement(playing_card, 'm_stone') == true then
					leEpicCounter = leEpicCounter + 2 -- Stone Cards
				end

				if playing_card:get_id() == 14 and not SMODS.has_enhancement(playing_card, 'm_stone' ) then 
					leEpicCounter = leEpicCounter + 1 -- Aces
				end

				if playing_card:get_id() == 13 and not SMODS.has_enhancement(playing_card, 'm_stone' ) then 
					leEpicCounter = leEpicCounter + 10 -- King
				end

				if playing_card:get_id() == 12 and not SMODS.has_enhancement(playing_card, 'm_stone' ) then 
					leEpicCounter = leEpicCounter + 10 -- Queen
				end

				if playing_card:get_id() == 11 and not SMODS.has_enhancement(playing_card, 'm_stone' ) then 
					leEpicCounter = leEpicCounter + 10  -- Jack
				end
				
				if playing_card:get_id() ~= not 11 then
					if playing_card:get_id() ~= 12 then
						if playing_card:get_id() ~= 13 then
							if playing_card:get_id() ~= 14 then
								if not SMODS.has_enhancement(playing_card, 'm_stone' ) then
									leEpicCounter = leEpicCounter + playing_card:get_id() -- Everything Else
								end
							end
						end
					end
				end
			end

			if leEpicCounter == 12 then

				return {
					xmult = card.ability.extra.xmult,
					message = 'ZAMN!!!!!!!!!',
					colour = G.C.MULT,
				}
			end
		end
	end
}

----------------------------------------------------------
----------- MOD CODE END -----------------------=---------