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
	key = "SCPSN_Jokers_Rare",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers_Rare.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
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

	atlas = 'SCPSN_Jokers_Rare',
	pos = { x = 0, y = 0 },
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
	atlas = 'SCPSN_Jokers_Rare',
	pos = { x = 1, y = 0 },
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

-- Bibically Accurate Joker
SMODS.Joker {
	key = 'bible_jonkler',
	loc_txt = {
		name = 'Biblically Accurate Joker',
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
			
			"Gain {C:money}+2$ per {C:money}Gold{} card ",
			"in deck at the end of round",
			"{C:inactive}(Currently:{} {C:money}+#1#${}{C:inactive}){}",
			'{C:inactive,s:0.8}"I LOVE FAT STACKS OF CASH"{}'

		}
	},

	-- Establish variables here in a list like fashion. Use this always even if the joker doesn't change any variable.
	-- Example (Vanilla Joker): "config = { extra = { mult = 4 } }"
	-- Example (Vanilla Runner): "config = { extra = { chips = 0, chip_gain = 15 } },"
	config = { extra = { dollars = 1, dollars_gain = 2 } },

	
	-- Misc Options:
	atlas = 'SCPSN_Jokers_Rare',
	pos = { x = 2, y = 0 },
	rarity = 3,					-- 1 common, 2 uncommon, 3 rare, 4 legendary.
	blueprint_compat = false,	-- Whether it can be copied by blueprint or other jokers.
	perishable_compat = true,	-- Whether it can have the perishable sticker on it.

	unlocked = true,			-- Whether this joker is unlocked by default or not.
	cost = 12,					-- Cost of card in shop.
	pools = {["tower_card"] = true, ["scpsn_addition"] = true},

    loc_vars = function(self, info_queue, card)
        local gold_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, 'm_gold') then gold_tally = gold_tally + card.ability.extra.dollars_gain end
			end
			card.ability.extra.dollars = gold_tally
		end
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars + gold_tally } }
    end,

	-- The Jokers Function.
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_gold') then
				return {
					mult = card.ability.extra.mult
				}
			end
        end
    end,

	calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}

-- Reroll Trinket
SMODS.Joker {
    key = "reroll",
		loc_txt = {
		name = 'Reroll Trinket',
		text = {
			"{C:attention}Enhances{} {C:green}#2# in #3#{} scored cards",
			"{C:mult}Unenhances{} cards it doesn't land on"
			-- "{X:mult,C:white} X4 {} Mult",

			-- "{C:green}#2# in #3#{} chance this",
			-- "card explodes and",
			-- "ends run at end",
			-- "of round"
		
		}
	},
	atlas = 'SCPSN_Jokers_Rare',

    pos = { x = 0, y = 1 },
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
	pools = {["scpsn_addition"] = true}, -- Add the Card to this mods pool :)
    config = { extra = { mult = 4, odds = 3}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
			for _, scored_card in ipairs(context.scoring_hand) do
				if pseudorandom('reroll') < G.GAME.probabilities.normal / card.ability.extra.odds then
					local edition = poll_edition('testing', nil, true, true,
                    { 'e_polychrome', 'e_holo', 'e_foil' })
				scored_card:set_edition(edition, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						scored_card:juice_up()
						return true
					end
				}))

				else
					scored_card:set_edition(nil, true)
				end
			end
        end
    end
}

-- Cryptid Six Fingers Copy!!!!!!!
SMODS.Joker {
    key = "sixfingers_but_cool",
	loc_txt = {
		name = 'Extremely Illegal Poker Hand',
		text = {
			"Allows you to select {C:attention}6{}",
			"cards per hand / discard",
		}
	},

    blueprint_compat = false,
    rarity = 3,
    cost = 10,
	atlas = 'SCPSN_Jokers_Rare',
    pos = { x = 1, y = 1 },
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_discard_limit(1)
		SMODS.change_play_limit(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_discard_limit(-1)
		SMODS.change_play_limit(-1)
    end
}

----------------------------------------------------------
----------- MOD CODE END -----------------------=---------