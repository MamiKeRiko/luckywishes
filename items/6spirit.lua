SMODS.Consumable {
    key = 'spirit',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 3, y = 0},
    pools = {
        ['wish'] = true
    },
    config = { extra = { rounds_current = 0, rounds_min = 10 } },
    loc_vars = function(self, info_queue, card)
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
        elseif context.setting_blind and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({set = 'wish', area = G.consumeables, edition = 'e_negative'})
                    return true
                end
            }))
        end
    end,
    can_use = function (self, card)
        return card.ability.extra.rounds_current >= card.ability.extra.rounds_min
    end,
    use = function (self, card, area, copier)
        if not REND.table_contains(G.GAME.used_vouchers, 'v_blank') then
            L6W.funcs.redeem_voucher('v_blank')
        end

        if not REND.table_contains(G.GAME.used_vouchers, 'v_antimatter') then
            L6W.funcs.redeem_voucher('v_antimatter')
        end
        
        G.E_MANAGER:add_event(Event({
            func = function ()
                SMODS.add_card({set = 'Spectral', area = G.consumeables, key = 'c_ectoplasm', edition = 'e_negative'})
                return true
            end
        }))

    end,
    draw = function (self, card, layer)
        card:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
}