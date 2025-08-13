-- Literally just made this file so that i could have custom quips for partner compat.
-- Maybe in V3.0 I'll make everything localized but I doubt ill ever get translators for this garbage

return {
    -- Partner API Compat
    misc = {
        quips={
            pnr_scpsn_special_ops_1={
                "Start the next cycle!"
            },
            pnr_scpsn_special_ops_2={
                "Break the cycle!"
            },

            pnr_scpsn_illegal_pokerhand_1={
                "Don't tell anyone."
            },
            pnr_scpsn_illegal_pokerhand_2={
                "Shhhh, hush. We will",
                "get away with this"
            },
        },
    },

    descriptions = {
        -- Info Queues
        Other = {
            scpsn_tower_card={
                ['name'] = 'Tower Card',
                ['text'] = {
                    [1] = 'has special {C:attention}synergies{} with',
                    [2] = 'some other scpsn jokers'
                }
            },
            scpsn_redeem={
                ['name'] = 'Redeem',
                ['text'] = {
                    [1] = 'Spawn a random',
                    [2] = '{C:attention}tower{} joker'
                }
            }
        },

        -- Modify Base Game Joker(s)
        Joker = {
            j_dna={
                name="Realistic Joker Genetics"
            },

            j_seance={
                text={
                    "I dont like this joker,",
                    "don't use it",
                },
            },
        },
    },
}