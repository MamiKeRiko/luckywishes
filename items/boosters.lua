SMODS.Atlas{
    key = "L6Booster",
    path = "Boosters.png",
    px = 71,
    py = 95
}

SMODS.Booster{
    key = 'wishes_s',
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    L6W.C.main
                }
            }
        }
    end,
    group_key = 'k_l6w_wishespack',
    cost = 4,
    weight = 0.2,
    atlas = "L6Booster",
    pos = {x = 0, y = 0},
    create_card = function(self, card, i)
        return SMODS.create_card({set = 'wish', skip_materialize = true})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, L6W.C.main)
		ease_background_colour({ new_colour = L6W.C.main, special_colour = L6W.C.secondary, contrast = 5 })
    end,
    select_card = 'consumeables'
}

SMODS.Booster{
    key = 'wishes_s2',
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    L6W.C.main
                }
            }
        }
    end,
    group_key = 'k_l6w_wishespack',
    cost = 4,
    weight = 0.2,
    atlas = "L6Booster",
    pos = {x = 0, y = 0},
    create_card = function(self, card, i)
        return SMODS.create_card({set = 'wish', skip_materialize = true})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, L6W.C.main)
		ease_background_colour({ new_colour = L6W.C.main, special_colour = L6W.C.secondary, contrast = 5 })
    end,
    select_card = 'consumeables'
}

SMODS.Booster{
    key = 'wishes_m',
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    L6W.C.main
                }
            }
        }
    end,
    group_key = 'k_l6w_wishespack',
    cost = 6,
    weight = 0.15,
    atlas = "L6Booster",
    pos = {x = 0, y = 0},
    create_card = function(self, card, i)
        return SMODS.create_card({set = 'wish', skip_materialize = true})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, L6W.C.main)
		ease_background_colour({ new_colour = L6W.C.main, special_colour = L6W.C.secondary, contrast = 5 })
    end,
    select_card = 'consumeables'
}

SMODS.Booster{
    key = 'wishes_l',
    config = { extra = 4, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    L6W.C.main
                }
            }
        }
    end,
    group_key = 'k_l6w_wishespack',
    cost = 8,
    weight = 0.08,
    atlas = "L6Booster",
    pos = {x = 0, y = 0},
    create_card = function(self, card, i)
        return SMODS.create_card({set = 'wish', skip_materialize = true})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, L6W.C.main)
		ease_background_colour({ new_colour = L6W.C.main, special_colour = L6W.C.secondary, contrast = 5 })
    end,
    select_card = 'consumeables'
}