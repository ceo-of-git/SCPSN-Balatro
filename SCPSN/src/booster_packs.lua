-- Booster Atlas
SMODS.Atlas{
    key = 'scpsn_boosters',
    path = 'booster_packs.png',
    px = 71,
    py = 96,
}


-- Small SCPSN Pack
SMODS.Booster{
    key = 'scpsn_boostpack',
    group_key = "k_scpsn_booster_group",
    atlas = 'scpsn_boosters', 
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'That hard SCPSN Pack',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} SCPSN jokers!", },
        group_name = {"You best be picking something"},
    },
    
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 5,
    kind = "SCPSN_Pack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("631a15"))
        return SMODS.create_card({
            set = "scpsn_addition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

-- Giga SCPSN Pack
SMODS.Booster{
    key = 'scpsn_boostpack_giga',
    group_key = "k_scpsn_booster_group",
    atlas = 'scpsn_boosters', 
    pos = { x = 1, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'GIGA SCPSN PACK!',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} SCPSN jokers!", },
        group_name = {"You best be picking something"},
    },
    
    draw_hand = false,
    config = {
        extra = 9,
        choose = 2, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 12,
    kind = "SCPSN_Pack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("631a15"))
        return SMODS.create_card({
            set = "scpsn_addition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}