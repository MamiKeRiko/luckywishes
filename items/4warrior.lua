SMODS.Consumable {
    key = 'warrior',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 0, y = 1},
    pools = {
        ['wish'] = true
    },
    config = {extra = { rounds_current = 0, rounds_min = 10, xmult_add = 0.1 }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul
        return{ vars = {
            card.ability.extra.rounds_min, 
            card.ability.extra.rounds_current,
            card.ability.extra.rounds_min + 2,
            card.ability.extra.xmult_add,
            colours = {L6W.C.secondary}
        }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.other_card then
            return L6W.funcs.increase_round_counter(card)
        elseif context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmult_add
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {(context.other_card.ability.perma_x_mult + 1)}}
            }
        end
    end,
    can_use = function (self, card)
        return card.ability.extra.rounds_current >= card.ability.extra.rounds_min
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function ()
                SMODS.add_card({set = 'Spectral', area = G.consumeables, key = 'c_soul', edition = 'e_negative'})
                return true
            end
        }))
    end,
    draw = function (self, card, layer)
        card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end
}