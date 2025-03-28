SMODS.Consumable {
    key = 'machine',
    set = 'wish',
    atlas = 'L6Wish',
    pos = {x = 1, y = 0},
    pools = {
        ['wish'] = true
    },
    config = { extra = { rounds_current = 0, rounds_min = 5, playing_min_mult = 0.9, playing_max_mult = 1.5, joker_mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return{ vars = {
            card.ability.extra.rounds_min, 
            card.ability.extra.rounds_current, 
            card.ability.extra.rounds_min + 2,
            card.ability.extra.playing_min_mult, 
            card.ability.extra.playing_max_mult, 
            card.ability.extra.joker_mult, 
            colours = {L6W.C.secondary}
        }}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.other_card then
            return L6W.funcs.increase_round_counter(card)
        elseif context.individual and context.cardarea == G.play then
            
            local c = context.other_card

            local multiplier = card.ability.extra.playing_min_mult + (pseudorandom('machine_p') * (card.ability.extra.playing_max_mult - card.ability.extra.playing_min_mult)) -- hacky method to get a number between 0.75 and 1.5
            multiplier = tonumber(string.format("%.2f", multiplier)) -- hacky method to round to 2 decimals
            L6W.funcs.xmult_playing_card(c, multiplier)

            local sound
            local sound_weight = pseudorandom('machine_sound')
            if sound_weight > 0.7 then
                sound = 'l6w_machine1'
            elseif sound_weight > 0.3 then
                sound = 'l6w_machine2'
            else
                sound = 'l6w_machine3'
            end

            return { message = 'X'..multiplier, card = c, sound = sound }
        end
    end,
    can_use = function (self, card)
        return card.ability.extra.rounds_current >= card.ability.extra.rounds_min
    end,
    use = function (self, card, area, copier)
        for _, j in pairs(G.jokers.cards) do
            L6W.funcs.mod_card_values(j.ability, {multiply = card.ability.extra.joker_mult})
            SMODS.calculate_effect({message = 'X'..card.ability.extra.joker_mult}, j)
        end
    end
}