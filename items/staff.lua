SMODS.Consumable {
    key = 'staff',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 4, y = 0},
    pools = {
        ['wish'] = true
    },
    config = {extra = { rounds_current = 0, rounds_min = 2, last_enhancement = 'none' }},
    loc_vars = function(self, info_queue, card)
        local enhName, enhColor
        if card.ability.extra.last_enhancement ~= 'none' then
            enhName, enhColor = L6W.funcs.get_enhancement_name_and_color(card.ability.extra.last_enhancement)
        else
            enhName = card.ability.extra.last_enhancement
            enhColor = G.C.PURPLE
        end

        return{ vars = {
            card.ability.extra.rounds_min, 
            card.ability.extra.rounds_current,
            card.ability.extra.rounds_min + 2, 
            enhName,
            colours = {L6W.C.secondary, enhColor}
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
        elseif context.l6_enhancement_applied then
            card.ability.extra.last_enhancement = context.l6_enhancement_applied.key
        end
    end,
    can_use = function (self, card)
        return (card.ability.extra.rounds_current >= card.ability.extra.rounds_min) and (#G.hand.cards > 0)
    end,
    use = function (self, card)
        if card.ability.extra.last_enhancement ~= 'none' then
            for i, c in ipairs(G.hand.cards) do
                L6W.funcs.flip_unflip(c, i, nil, #G.hand.cards, 0.15, function ()
                    c:set_ability(G.P_CENTERS[card.ability.extra.last_enhancement])
                end)
            end
        end
    end
}