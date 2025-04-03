SMODS.Consumable {
    key = 'priest',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 2, y = 0},
    pools = {
        ['wish'] = true
    },
    config = { extra = {rounds_current = 0, rounds_min = 5, levels = 10} },
    loc_vars = function(self, info_queue, card)
        return{ vars = {
            card.ability.extra.rounds_min, 
            card.ability.extra.rounds_current, 
            card.ability.extra.rounds_min + 2,
            card.ability.extra.levels,
            colours = {L6W.C.secondary}
        }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.other_card then
            return L6W.funcs.increase_round_counter(card)
        elseif context.after then
            local handname = context.scoring_name
            local planet = L6W.funcs.get_planet_from_hand(handname)

            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({set = 'Planet', area = G.consumeables, key = planet, edition = 'e_negative'})
                    return true
                end
            }))
        end
    end,
    can_use = function (self, card)
        return card.ability.extra.rounds_current >= card.ability.extra.rounds_min
    end,
    use = function (self, card, area, copier)
        local hand = L6W.funcs.get_most_played_hand()
        SMODS.calculate_effect({
            level_up = card.ability.extra.levels,
            level_up_hand = hand,
            message = localize('k_level_up_ex')
            },
        card)
    end,
    draw = function (self, card, layer)
        card:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
}