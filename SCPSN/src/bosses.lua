-- ATLAS
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Blinds",
    -- Animated stuff.
    atlas_table = 'ANIMATION_ATLAS',
    frames = 2,
	-- The name of the file, for the code to pull the atlas from
	path = "Blinds.png",
	-- Width of each sprite in 1x size
	px = 34,
	-- Height of each sprite in 1x size
	py = 34
}

-- Dead Heat Pulse
SMODS.Sound({
    key = "music_deadheatpulse_cold", 
    path = "music_deadheatpulse_cold.ogg",
    pitch = 1,
    sync = {
        ['music_deadheatpulse_cold'] = true,
        ['music_deadheatpulse_hot'] = true,
    },
    volume = 0.5,
    select_music_track = function()
        if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'The Snowflake' then
		    return true end
	end,
})

SMODS.Sound({
    key = "music_deadheatpulse_hot", 
    path = "music_deadheatpulse_hot.ogg",
    pitch = 1,
    sync = {
        ['music_deadheatpulse_cold'] = true,
        ['music_deadheatpulse_hot'] = true,
    },
    volume = 0.6,
    select_music_track = function()
        if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'AN EVIL HEAT' then
		    return true end
	end,
})

SMODS.Sound({key = "heat_pulse_break", path = "glass_break_lol.ogg",})

SMODS.Blind{
    name = "The Snowflake",
    key = "ultracold",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 2,
    pos = {x = 0, y = 0},
    unlocked = true,

    mult = 2,
    dollars = 4,
    boss = { min = 4, max = 39, false},
    boss_colour = HEX('a1fffd'),

    loc_txt = {
        name = "The Snowflake",
        label = "The Snowflake",
        text = {
            "It's a bit chilly in here",
            "Perhaps I will turn up the heat..."
        }
    },

    loc_vars = {
        snowflakeQuirk = false
    },

    recalc_debuff = function (self)
        snowflakeQuirk = false
    end,

    -- The Blinds Function when hands are played.
    calculate = function(self, card, context)

        

        if G.GAME.chips >= G.GAME.blind.chips and not self.loc_vars.snowflakeQuirk then
            -- Set flag immediately to prevent infinite loop
            snowflakeQuirk = true

            -- Optionally reset chips here, or inside the event
            G.GAME.chips = 0
            ease_hands_played(5, true)
            ease_discard(4, true)

            -- Schedule the blind swap
            G.E_MANAGER:add_event(Event({
                trigger = 'after', delay = 0.5, blocking = true,
                func = function()
                    -- G.P_BLINDS.bl_final_vessel
                    play_sound('scpsn_heat_pulse_break', nil, 0.5)
                    G.GAME.blind:change_colour(HEX('ff6200'))
                    G.GAME.blind:set_blind(G.P_BLINDS['bl_scpsn_ultrahot'], nil, nil)
                    return true
                end
            }))

            return nil
        end
    end


}

SMODS.Blind{
    name = "AN EVIL HEAT",
    key = "ultrahot",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 2,
    pos = {x = 0, y = 1},
    unlocked = true,

    mult = 6,
    dollars = 6,
    boss = { min = 39, max = 39, false},
    boss_colour = HEX('ff6200'),

    loc_txt = {
        name = "AN EVIL HEAT",
        label = "AN EVIL HEAT",
        text = {
            "<!> SUDDEN EXTREME TEMPERATURE SHIFT <!>",
            "LEFTMOST JOKER IS BURNT AFTER EACH HAND",

        }
    },

    -- The Blinds Function when hands are played.
    calculate = function(self, card, context)

        G.GAME.blind:change_colour(HEX('ff6200'))

		if context.after and pseudorandom('boss_heatpulse') < 2 / 1 then
				local sliced_card = G.jokers.cards[1]

				if sliced_card and not sliced_card.getting_sliced then
					sliced_card.getting_sliced = true
					G.GAME.joker_buffer = G.GAME.joker_buffer - 1
					G.E_MANAGER:add_event(Event({
						func = function()
							card:juice_up(0.8, 0.8)
							sliced_card:start_dissolve({ HEX("ff7621") }, nil, 1.6)
							return true
						end
					}))
				end
        end
    end
}

-- Temple OS
SMODS.Blind{
    name = "Temple OS",
    key = "temple_os",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 2,
    pos = {x = 0, y = 2},
    unlocked = true,

    mult = 1.80,
    dollars = 4,
    boss = { min = 3, max = 39, false},
    boss_colour = HEX('ffe814'),

    loc_txt = {
        name = "Temple OS",
        label = "Temple OS",
        text = {
            "THE HOLIEST BOSS BLIND.",
            "+20% Required Score every Hand played,",
            "+5% for each discarded card."
        }
    },

    set_blind = function(self)
        quirksEnabled = true
    end,

    disable = function(self)
        quirksEnabled = false
    end,

    loc_vars = {
        quirksEnabled = true
    },

    calculate = function(self, card, context)
        if context.after and quirksEnabled then
            G.GAME.blind.chips =  G.GAME.blind.chips * 1.20
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end

        if context.discard and quirksEnabled then
            G.GAME.blind.chips =  G.GAME.blind.chips * 1.05
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}

-- Hideo Kojiblind
SMODS.Blind{
    name = "Hideo Kojiblind",
    key = "hideo_kojiblind",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 2,
    pos = {x = 0, y = 3},
    unlocked = true,

    mult = 2,
    dollars = 4,
    boss = { min = 3, max = 39, false},
    boss_colour = HEX('1f1f36'),

    loc_txt = {
        name = "Hideo Kojiblind",
        label = "Hideo Kojiblind",
        text = {
            "Debuffs all SCPSN mod Jokers",
            "(Except Legendaries)"
        }
    },

    -- Code yoinked from the Jimothy boss (Yahimod)
    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.scpsn_addition then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

-- Nuclear Tech Blind
SMODS.Blind{
    name = "Nuclear Tech Blind",
    key = "hbms_ntm",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 2,
    pos = {x = 0, y = 4},
    unlocked = true,

    mult = 2.25,
    dollars = 4,
    boss = { min = 5, max = 39, false},
    boss_colour = HEX('32a85a'),

    loc_txt = {
        name = "Nuclear Tech Blind",
        label = "Nuclear Tech Blind",
        text = {
            "All Jokers destroyed if",
            "last hand is played",
        }
    },

    set_blind = function(self)
        quirksEnabled = true
    end,

    disable = function(self)
        quirksEnabled = false
    end,

    loc_vars = {
        quirksEnabled = true,
    },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and quirksEnabled and G.GAME.current_round.hands_left == 0 then
            -- DEstroy all jokjnkers
            -- Stolen code from ankh vanilla remade

            local deletable_jokers = {}
            for _, joker in pairs(G.jokers.cards) do
                if not joker.ability.eternal then deletable_jokers[#deletable_jokers + 1] = joker end
            end

            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for _, joker in pairs(deletable_jokers) do
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end
            }))
        end
    end
}

-- OBS STUDIO
SMODS.Atlas {
	-- Key for code to find it with
	key = "SCPSN_Blinds_obs",
    -- Animated stuff.
    atlas_table = 'ANIMATION_ATLAS',
    frames = 1,
	-- The name of the file, for the code to pull the atlas from
	path = "OBS_Blind.png",
	-- Width of each sprite in 1x size
	px = 200,
	-- Height of each sprite in 1x size
	py = 200
}
SMODS.Blind{
    name = "Obs Studio",
    key = "obs_blind",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds_obs',
    frames = 1,
    pos = {x = 0, y = 0},
    unlocked = true,

    mult = 15,
    dollars = 10,
    boss = { min = 6, max = 39, false},
    boss_colour = HEX('3d3d3d'),

    loc_txt = {
        name = "OBS Studio",
        label = "OBS Studio",
        text = {
            "Insanely huge blind",
            "Unlimited Hands",
        }
    },

    set_blind = function(self)
        quirksEnabled = true
    end,

    disable = function(self)
        quirksEnabled = false
    end,

    loc_vars = {
        quirksEnabled = true,
    },

    calculate = function(self, card, context)
        if context.after and quirksEnabled then
            ease_hands_played(1, true)
        end
    end
}

-- Gilbert Facility
SMODS.Blind{
    name = "Gilbert Facility",
    key = "gilbert_facility",

    atlas_table = 'ANIMATION_ATLAS',
    atlas = 'SCPSN_Blinds',
    frames = 1,
    pos = {x = 0, y = 5},
    unlocked = true,

    mult = 100,
    dollars = 10,
    boss = { min = 6, max = 39, false},
    boss_colour = HEX('6e5939'),

    loc_txt = {
        name = "Gilbert Facility",
        label = "Gilbert Facility",
        text = {
            "Find the Cure",
            "(Play Straight Flush)",
            "To Instantly Win."
        }
    },

    set_blind = function(self)
        ease_discard(3, true)
        quirksEnabled = true
    end,

    disable = function(self)
        quirksEnabled = false
    end,

    loc_vars = {
        quirksEnabled = true,
    },

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Straight Flush']) then
            G.GAME.blind.chips =  G.GAME.blind.chips * 0
        end
    end
}




