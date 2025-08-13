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
					
					local card = create_card("tower_card", G.Jokers, nil, nil, nil, nil, nil, 'tower_card')
					card:add_to_deck()
					G.jokers:emplace(card)

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

			"{C:green}#1# in #2# chance{}",
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
							stickers = { "perishable" },
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
		-- Destroy Cards
		if context.after and context.main_eval and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.debuff then
					if scored_card and not scored_card.ability.eternal and not scored_card.getting_sliced then
						scored_card.getting_sliced = true
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:juice_up(0.8, 0.8)
								scored_card:start_dissolve({ HEX("1cfc03") }, nil, 1.6)
								SMODS.destroy_cards(scored_card)
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
	pools = {["scpsn_addition"] = true},

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

				if playing_card:is_face() and not SMODS.has_enhancement(playing_card, 'm_stone' ) then 
					leEpicCounter = leEpicCounter + 10 -- Any Face Card (Paradoliedrda un-synergy)
				end
				
				-- yandere dev
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

-- Trepang Joker
SMODS.Joker {
	key = 'trepang_joker',
	loc_txt = {
		name = 'Special Ops',
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
			
			"Retrigger first and last cards {C:attention}#1#{} times if",
			"Played Hand contains a {C:attention}Pair{}.",
			"{C:inactive,s:0.8}Dual Wield Serum{}",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { repetitions = 2, type = 'Pair' }, },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 2, y = 2 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 8,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
    

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions, localize(card.ability.extra.type, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.type]) then
			if context.other_card == context.scoring_hand[#context.scoring_hand] or context.other_card == context.scoring_hand[1] then
				return {
                	repetitions = card.ability.extra.repetitions
            	}
			end
        end
    end
}

-- Hoarders Trinket
-- Coded by TheMaster
SMODS.Joker {
    key = "fueltrinket",
		loc_txt = {
		name = "Hoarder's Trinket",
		text = {
			"{C:mult}+3 Mult{} per card",
			"above {C:attention}52{} in your full deck",
			"{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}"
		}
	},
	atlas = 'SCPSN_Jokers_Uncommon',
    rarity = 2,
	blueprint_compat = true,
    cost = 6,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
    pos = { x = 0, y = 3 },
    config = { extra = { mult = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, math.max(0, 3 * (G.playing_cards and (#G.playing_cards - G.GAME.starting_deck_size) or 0)), G.GAME.starting_deck_size} } -- had to manually set the mult to 3 because it just wasnt working. if i need to change this, change the 3
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
				mult = math.max(0, 3 * (#G.playing_cards - G.GAME.starting_deck_size)) -- had to manually set the mult to 3 because it just wasnt working. if i need to change this, change the 3
            }
        end
    end
}

-- Chudjoker
-- Coded by TheMaster
SMODS.Joker {
    key = "chudjoker",
	loc_txt = {
		name = 'Nothing Ever Happens',
		text = {
			"{C:attention}Halves{} all listed",
			"{C:green}probabilities{}",
		}
	},

    blueprint_compat = false,
    rarity = 2,
    cost = 5,
	atlas = 'SCPSN_Jokers_Uncommon',
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
    pos = { x = 1, y = 3 },
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 2
        end
		-- SMODS.change_discard_limit(5) -- move tihs to its own joker later
		-- SMODS.change_play_limit(5) -- move this to its own joker later


    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 2
        end
    end
}

-- Starman
-- TODO: i dont feel like it rn but re-do the art for this lol......
-- Coded by TheMaster
SMODS.Joker {
    key = "Starman",
		loc_txt = {
		name = 'Starman',
		text = {
			"{X:mult,C:white} X#1# {} Mult for each" ,
			"{C:attention}Diamond{} card in",
			"hand",
		}
	},
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
	atlas = 'SCPSN_Jokers_Uncommon',
    pos = { x = 2, y = 3 },
    config = { extra = { xmult = 1.1, suit = 'Diamonds' } }, -- just straight up doesnt wrk
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.suit } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit('Diamonds') then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = 1.1
                }
            end
        end
    end,
}

-- Really Fragile joker
-- Coded by TheMaster (Originally)
-- Re-coded by me :)
SMODS.Joker {
	key = 'fragilejoker',
	loc_txt = {
		name = 'REALLY Fragile Joker',
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

			"{X:mult,C:white}X#1#{} Mult",
			"{C:mult}Destroyed{} when anything",
			"is sold or used."
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { Xmult = 4 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',		-- Atlas ID (Set at the top of the file)
	pos = { x = 0, y = 4 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary.

	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

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

		-- Being Destroyed (Oops!)
		if context.selling_card or context.using_consumeable then
			card.getting_sliced = true
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up(0.8, 0.8)
					card:start_dissolve({ HEX("fc0303") }, nil, 1.6)
					return true
				end
			}))
		end

		-- Normal Use
        if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult
			}
        end
    end
}

-- Slenderman
SMODS.Sound({key = "slenderman_sound", path = "slenderman_proc.ogg",})
SMODS.Joker {
	key = 'slenderman',
	loc_txt = {
		name = 'Slenderman',
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
			"{X:chips,C:white}+#2#X{} Chips when boss blind defeated",
			"{C:inactive,s:0.8}Collect my boss blinds{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xchips = 1, xchips_mod = 1 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 4 },
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
				card.ability.extra.xchips,
				card.ability.extra.xchips_mod
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				if G.GAME.blind.boss then
				card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_mod

				play_sound('scpsn_slenderman_sound')
				return {
					message = 'Page Collected!',
					colour = G.C.CHIPS,
				}
			end
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}

-- Sparkle on!
SMODS.Sound({key = "jerma_sound", path = "sparkle_proc.ogg",})
SMODS.Joker {
	key = 'sparkle_on',
	loc_txt = {
		name = 'Sparkle On!',
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
			
			"{X:mult,C:white}X#1#{} Mult if its {C:attention}Wednesday{}",
			"{C:purple,s:0.8,E:1}Sparkle on Queen!{}",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 3 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 2, y = 4 },
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

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.joker_main then
			local week_day = os.date("*t").wday;

			if week_day == 4 then

				play_sound('scpsn_jerma_sound')
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
    end
}

-- Villager Morph
SMODS.Joker {
	key = 'villager_morph',
	loc_txt = {
		name = 'Villager Morph',
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
			
			"{C:mult}+#1# Mult{} {C:inactive,s:0.8}(+#2# per Other Villager Morph){}",
			"At start of {C:attention}Small or Big Blind,{}",
			"Become {X:dark_edition,C:white}Negative{}",
			"{s:0.8,C:inactive}(Only if This doesn't have any other edition on it){}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 5, mult_per_companion = 10, companions = 1 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 5 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 8,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.mult_per_companion,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		-- Destroy a random Joker :)))))))
        if context.setting_blind and not context.blueprint and not context.blind.boss then

			-- Check if you are negative yourself good sir.
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then my_pos = i; break end
			end

			if G.jokers.cards[my_pos].edition == nil then

				card:set_edition('e_negative')
				return { message = 'Morphed!' }
			end

			local companions = 0

			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].label == 'j_scpsn_villager_morph' then
					companions = companions + 1
				end
			end

			card.ability.extra.mult = 5 + (card.ability.extra.mult_per_companion * companions)
			
        end

        if context.joker_main then
			-- Calculate other Villagers

			local companions = 0

			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].label == 'j_scpsn_villager_morph' then
					companions = companions + 1
				end
			end

			card.ability.extra.mult = 5 + (card.ability.extra.mult_per_companion * companions)
			
            return {
                mult = card.ability.extra.mult
            }
        end

    end
}

-- That one Seed
SMODS.Joker {
	key = 'that_one_seed',
	loc_txt = {
		name = 'That one Seed',
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
			
			"Create {C:attention}#1#{} {C:spades}10s of Spades{}",
			"on start of Blind",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { spades = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 5 },
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
				card.ability.extra.spades,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua

		if context.first_hand_drawn then
			for i = 1, card.ability.extra.spades do
            local _card = SMODS.create_card{ set = "Base", suit = 'Spades', rank = '10', area = G.discard }

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand:emplace(_card)
                    _card:start_materialize()
					_card:change_suit('Spades')
					assert(SMODS.change_base(_card, 'Spades', '10'))
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    if context.blueprint_card then
                        context.blueprint_card:juice_up()
                    else
                        card:juice_up()
                    end
                    return true
                end
            }))
            SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
			end
		end
    end
}

-- Just enough Jokers
SMODS.Joker {
	key = 'jei_joker',
	loc_txt = {
		name = 'Just Enough Jokers',
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
			
			"{X:mult,C:white}#1#X{} Mult if you have",
			"exactly {C:green}#2#{} Jokers",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 3, jokeramount = 4} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 2, y = 5},
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
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
				card.ability.extra.xmult,
				card.ability.extra.jokeramount,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

        if context.joker_main then
			if #G.jokers.cards == card.ability.extra.jokeramount then
				return {
					xmult = card.ability.extra.xmult
				}
			end
        end
    end
}

-- Brazilian Drug Dealer
SMODS.Joker {
	key = 'brazilian_drug_dealer',
	loc_txt = {
		name = 'Brazilian Drug Dealer',
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
			
			"Played {X:chips,C:white}99.1%{} or {X:planet,C:white}96.2%{} Pure Cards",
			"Give {X:chips,C:white}#1#X{} Chips when scored"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xchips = 1.5 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 6 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
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
				card.ability.extra.xchips,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_scpsn_pure') then
				return {
					xchips = card.ability.extra.xchips
				}
			end

			if SMODS.has_enhancement(context.other_card, 'm_scpsn_unpure') then
				return {
					xchips = card.ability.extra.xchips
				}
			end
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

-- Are these the most crispy fries
SMODS.Joker {
	key = 'crispy_fry_guy',
	loc_txt = {
		name = 'Are these the most crispy cards?',
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
			
			"Played {X:chips,C:white}99.1%{} or {X:planet,C:white}96.2%{} Pure Cards",
			"Give {X:mult,C:white}#1#X{} Mult when scored"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 1.5 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 6 },
	soul_pos = { x = 2, y = 6},
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
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
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_scpsn_pure') then
				return {
					xmult = card.ability.extra.xmult
				}
			end

			if SMODS.has_enhancement(context.other_card, 'm_scpsn_unpure') then
				return {
					xmult = card.ability.extra.xmult
				}
			end
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

-- Sniper Balatro (Deathmark exclusive!)
SMODS.Joker {
	key = 'sniper_balatro',
	loc_txt = {
		name = 'Sniper Balatro',
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
			"Give {X:mult,C:white}#1#X{} Mult when scored",
			"and are then {C:mult}destroyed{}"

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { xmult = 2.0, } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 7 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 9,					-- Cost of card in shop.
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

		-- Apply XMult
        if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_scpsn_marked') then
				return {
					xmult = card.ability.extra.xmult
				}
			end
        end

		-- Destroy Cards
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
                return true
            end
        end
        return false
    end,
}

-- The Job Note
SMODS.Joker {
	key = 'job_note',
	loc_txt = {
		name = 'The Job Note',
		text = {
			
			"Go to {C:chips}Work{} and get {C:money}paid{}",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { paycheque = 0.2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 1, y = 7 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
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
				card.ability.extra.paycheque,
			}
		}
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			ease_dollars(card.ability.extra.paycheque, false)
        end
    end,

}

-- Great Joker of Evil
SMODS.Joker {
	key = 'great_joker_of_evil',
	loc_txt = {
		name = 'GREAT JESTER OF EVIL',
		text = {
			
			"Upgrade played hand",
			"{X:mult,C:white}X-1{} Mult",
			
		}
	},
	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 2, y = 7 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 12,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	config = { extra = { Xmult = -1, } },

	-- The Jokers Function.
    calculate = function(self, card, context)

		if context.before and context.main_eval then
            return {
                level_up = true,
            }
        end

		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		end
    end,

}

-- Luigis Simplified Poker
SMODS.Joker {
	key = 'simplified_poker',
	loc_txt = {
		name = "Luigi's Rules",
		text = {
			
			"All played cards are treated as",
			"if they are {C:attention}wild cards{}.",
			
		}
	},
	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Uncommon',
	pos = { x = 0, y = 8 },
	soul_pos = { x = 1, y = 8 },
	rarity = 2,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.
	eternal_compat = true,		-- Whether it can have the eternal sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 7,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild 
        return
    end,

    calculate = function(self, card, context)
		if context.check_enhancement and not context.blueprint then
            if context.other_card.config.center.key ~= "m_wild" then
                return { m_wild = true }
            end
		end
    end
}

----------------------------------------------------------
----------- MOD CODE END ---------------------------------