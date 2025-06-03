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
	key = "SCPSN_Jokers",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}


-- 2. WHYSOSERIOUS (Jokers)
SMODS.Joker {
	key = 'joker2',
	loc_txt = {
		name = 'Joker 2',
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

			"{C:mult}+#1# {} Mult"
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { mult = 8 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers',		-- Atlas ID (Set at the top of the file)
	pos = { x = 0, y = 0 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 2,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,

	-- The Jokers Function.
    calculate = function(self, card, context)

		-- Contexts are basically when the Joker chooses to do a thing.
		-- To find contexts, look at Here: https://raw.githubusercontent.com/nh6574/VanillaRemade/refs/heads/main/src/jokers.lua
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}



-- Truck that Can't Slow Down!
SMODS.Sound({key = "insurance_fraud", path = "insurance_fraud.ogg",})
SMODS.Joker {

	key = 'trummmmmmmmmmmck',
	loc_txt = {
		name = 'Truck That Cant Slow Down!',
		text = {
			"{C:red}Destroys{} every Joker",
			"to the right when blind selected",
			"and gives {C:money}+10${} per",
			"Destroyed Joker at end of round."
		}
	},

	config = {
		extra = {
			dollars = 10
		}
	},

	atlas = 'SCPSN_Jokers',
	pos = { x = 1, y = 0 },
	rarity = 3,
	blueprint_compat = true,
	perishable_compat = false,
	unlocked = true,
	cost = 8,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_pos = i
					break
				end
			end

			local destroyedJokerCount = 0
			for j = my_pos + 1, #G.jokers.cards do
				local sliced_card = G.jokers.cards[j]
				if sliced_card and not sliced_card.ability.eternal and not sliced_card.getting_sliced then
					destroyedJokerCount = destroyedJokerCount + 1
					sliced_card.getting_sliced = true
					G.GAME.joker_buffer = G.GAME.joker_buffer - 1
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(0.8, 0.8)
							sliced_card:start_dissolve({ HEX("fc0303") }, nil, 1.6)
							return true
						end
					}))
				end
			end

			if destroyedJokerCount > 0 then
				card.ability.extra.dollars = 10 * destroyedJokerCount
				play_sound('scpsn_insurance_fraud')
				return {
					colour = G.C.MONEY,
					no_juice = true
				}
			end
		end
	end,

	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end
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
	atlas = 'SCPSN_Jokers',		-- Atlas ID (Set at the top of the file)
	pos = { x = 2, y = 0 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

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
			
			"Retrigger all {C:chips}Clubs{} {C:attention}1 {}Time.",
			"{C:mult}+0.5 Mult{} per {C:chips}Club{} Scored."
		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { repetitions = 1, mult = 0.5, suit = 'Clubs' } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers',
	pos = { x = 0, y = 1 },
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
	atlas = 'SCPSN_Jokers',		-- Atlas ID (Set at the top of the file)
	pos = { x = 1, y = 1 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

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
	atlas = 'SCPSN_Jokers',		-- Atlas ID (Set at the top of the file)
	pos = { x = 2, y = 1 },		-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.

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
	atlas = 'SCPSN_Jokers',
	pos = { x = 0, y = 2 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 5,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
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

-- The Bossfight (Tower)
SMODS.Joker {
	key = 'markiplier_bossfight',
	loc_txt = {
		name = 'The Bossfight',
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
			"{C:mult}Turns every blind into a Showdown Boss",
			"Ante increases after every blind."

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { Xmult = 6.0 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers',
	pos = { x = 1, y = 2 },
	rarity = 3,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 6,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.Xmult,
			}
		}
	end,

    calculate = function(self, card, context)
		local markBlind = G.P_BLINDS.bl_final_acorn

        if context.setting_blind and not context.blueprint then
            return {
                func = function()
                    -- This is for retrigger purposes, Jokers need to return something to retrigger
                    -- You can also do this outside the return and `return nil, true` instead

					local randomShowdownBlind = pseudorandom('ps_markiplier', 1, 5)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
										if randomShowdownBlind == 1 then markBlind = G.P_BLINDS.bl_final_acorn end
										if randomShowdownBlind == 2 then markBlind = G.P_BLINDS.bl_final_bell end
										if randomShowdownBlind == 3 then markBlind = G.P_BLINDS.bl_final_heart end
										if randomShowdownBlind == 4 then markBlind = G.P_BLINDS.bl_final_vessel end
										if randomShowdownBlind == 5 then markBlind = G.P_BLINDS.bl_final_leaf end

										G.GAME.blind:set_blind(markBlind, nil, nil)
										play_sound('timpani')
										return true

                                end
                            }))
                            return true
                        end
                    }))
                end
            }
        end

		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult,
				alreadyDone = false
			}
		end
		
    end,
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
	atlas = 'SCPSN_Jokers',
	pos = { x = 2, y = 2 },
	soul_pos = { x = 2, y = 3 },

	rarity = 4,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 25,					-- Cost of card in shop.
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


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
				scored_card:juice_up(0.3, 0.5)
				self:juice_up(0.3, 0.5)
			end

			play_sound('scpsn_false_son', nil, 0.5)
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
	atlas = 'SCPSN_Jokers',
	pos = { x = 0, y = 3 },
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
	atlas = 'SCPSN_Jokers',
	pos = { x = 1, y = 3 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 4,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true}, -- Add the Card to this mods pool :)


	-- Not 100% Sure what this does at all.
	loc_vars = function(self, info_queue, card)
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
			"{C:chips}+1{} Chip per {C:chips}Club Card{} Scored.",

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { chips = 10, suit = 'Clubs', chip_mod = 1} },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers',
	pos = { x = 0, y = 4 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

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
	atlas = 'SCPSN_Jokers',
	pos = { x = 1, y = 4 },
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
	atlas = 'SCPSN_Jokers',
	pos = { x = 2, y = 4 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

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
	atlas = 'SCPSN_Jokers',
	pos = { x = 0, y = 5 },
	rarity = 1,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = true,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

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

-- Hesitant Joker
SMODS.Joker {
	key = 'demoknight_balatro',
	loc_txt = {
		name = 'Demoknight Balatro',
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
	atlas = 'SCPSN_Jokers',
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

----------------------------------------------------------
----------- MOD CODE END ----------------------------------