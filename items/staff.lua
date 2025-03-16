SMODS.Consumable {
    key = 'warrior',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 0, y = 0},
    pools = {
        ['wish'] = true
    },
    config = {extra = { rounds_current = 0, rounds_min = 2 }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul
        return{ vars = {
            card.ability.extra.rounds_min, 
            card.ability.extra.rounds_current,
            card.ability.extra.rounds_min + 2, 
            colours = {L6W.C.secondary}
        }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.other_card then
            return L6W.funcs.increase_round_counter(card)
        elseif context.after then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({set = 'Tarot', area = G.consumeables, edition = 'e_negative'})
                    return true
                end
            }))
        end
    end
}