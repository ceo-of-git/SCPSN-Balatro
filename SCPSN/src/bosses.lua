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

    mult = 10,
    dollars = 4,
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


