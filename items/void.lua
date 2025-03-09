SMODS.Consumable {
    key = 'void',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 0, y = 0},
    pools = {
        ['wish'] = true
    },
    config = {extra = { rounds_current = 0, rounds_min = 2, last_discard = {} }},
    loc_vars = function(self, info_queue, card)
        return{ vars = {
            card.ability.extra.rounds_min, card.ability.extra.rounds_current, colours = {L6W.C.secondary}
        }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.other_card then
            card.ability.extra.rounds_current = card.ability.extra.rounds_current + 1
            if card.ability.extra.rounds_current >= card.ability.extra.rounds_min then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
                return {
                    message = localize('k_active_ex')
                }
            else
                return {
                    message = card.ability.extra.rounds_current .. '/' .. card.ability.extra.rounds_min
                }
            end
        elseif context.discard and G.GAME.current_round.discards_used == 0 then
            
            card.ability.extra.last_discard = {}

            for _, c in pairs(context.full_hand) do
                local cardinfo = {rank = c:get_id(), suit = c.base.suit}
                table.insert(card.ability.extra.last_discard, cardinfo)
            end

            return {
                remove = true
            }
        end
    end,
    can_use = function (self, card)
        return (card.ability.extra.rounds_current >= card.ability.extra.rounds_min) and #G.hand.cards > 0
    end,
    use = function (self, card, area, copier)
        if card.ability.extra.last_discard then
            for _, c in pairs(card.ability.extra.last_discard) do
                
                G.E_MANAGER:add_event(Event({
                    func = function ()

                        local enh = SMODS.poll_enhancement({type_key = 'voidenh', guaranteed = true})
                        local lookup_string = L6W.funcs.parse_suit(c.suit) .. '_' .. L6W.funcs.parse_id_to_rank(c.rank)

                        local newc = create_playing_card({
                            front = G.P_CARDS[lookup_string], 
                            center = G.P_CENTERS[enh]
                        },
                        G.hand, false, false, {L6W.C.secondary})
                        
                        newc:set_seal(SMODS.poll_seal({type_key = 'voidseal', guaranteed = true}))
                        newc:set_edition(poll_edition('voidedit', 1, true, true))

                        return true

                    end
                }))
            end
        end
    end
}