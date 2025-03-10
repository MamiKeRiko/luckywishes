-- set custom globals
L6W = {
    C = {
        main =  HEX('6E3AA6'),
        secondary = HEX('a36be8')
    },

    funcs = {
        
        -- this func is a mess and lowkey i should refactor it but too lazy
        flip_unflip = function (card, i, context, amount, t, func)
            G.E_MANAGER:add_event(Event({ -- first flip
                trigger = "after",
                delay = (i - 1) * t, -- this is meant to be a delay for when you flip/unflip a whole hand for instance, so each flipped card does it sequentially. t is the delay between card flips
                blockable = false,
                func = function() 
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3, 0.3)
                    return true
                end 
            }))
    
            G.E_MANAGER:add_event(Event({ -- perform func passed by the call
                func = function()
                    func()
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({ -- second flip
                trigger = "after",
                delay = ((i - 1) * t) + (amount * t), -- after all the cards are done flipping, start flipping again from the start
                blockable = false,
                func = function()
                    if not context.individual and not context.cardarea == G.play and not context.other_card == card then return false end
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        trigger = 'after',
                        delay = 0.35,
                        func = function() 
                            card:flip()
                            play_sound('tarot2')
                            card:juice_up(0.3, 0.3)
                            return true 
                        end 
                    }))
                    return true
                end
            }))
        end,
    
        -- both of these might break with certain mods sadly but ehhh
        parse_id_to_rank = function (id) -- imagine if lua had switch statements wouldn't that be crazy useful haha
            if id < 10 then return id
            elseif id == 10 then return 'T'
            elseif id == 11 then return 'J'
            elseif id == 12 then return 'Q'
            elseif id == 13 then return 'K'
            elseif id == 14 then return 'A'
            end
        end,

        parse_suit = function (suit) -- should be just the first letter of the suit name right
            return suit:sub(1,1)
        end,

        get_planet_from_hand = function (hand_name)
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == hand_name then
                    return v.key
                end
            end
        end,

        get_most_played_hand = function ()
            local hand, played, order = 'High Card', -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > played or (v.played == played and order > v.order) then
                    played = v.played
                    hand = k
                end
            end
            return hand
        end,

        mod_card_values = function(table_in, config) -- thanks aikoyori for this func
            if not config then config = {} end
            local add = config.add or 0
            local multiply = config.multiply or 1
            local keywords = config.keywords or {}
            local reference = config.reference or table_in
            local function modify_values(table_in, ref)
                for k, v in pairs(table_in) do
                    if type(v) == "number" then
                        if keywords[k] or #keywords < 1 then
                            if ref[k] then
                                table_in[k] = (ref[k] + add) * multiply
                            end
                        end
                    elseif type(v) == "table" then
                        modify_values(v, ref[k])
                    end
                end
            end
            if table_in == nil then
                return
            end
            modify_values(table_in, reference)
        end,

        xmult_playing_card = function(card, mult)
            local tablein = { -- hoo boy here we go
                nominal = card.base.nominal,
                bonus = card.ability.bonus, 
                x_chips = card.ability.x_chips ~= 1 and card.ability.x_chips or nil,
                mult = card.ability.mult,
                x_mult = card.ability.x_mult ~= 1 and card.ability.x_mult or nil,
                p_dollars = card.ability.p_dollars,
                h_chips = card.ability.h_chips,
                h_x_chips = card.ability.h_x_chips ~= 1 and card.ability.h_x_chips or nil,
                h_mult = card.ability.h_mult,
                h_x_mult = card.ability.h_x_mult ~= 1 and card.ability.h_x_mult or nil,
                h_dollars = card.ability.h_dollars,

                perma_bonus = card.ability.perma_bonus,
                perma_mult = card.ability.perma_mult,
                perma_x_chips = card.ability.perma_x_chips ~= 1 and card.ability.perma_x_chips or nil,
                perma_x_mult = card.ability.perma_x_mult ~= 1 and card.ability.perma_x_mult or nil,
                perma_p_dollars = card.ability.perma_p_dollars,
                perma_h_chips = card.ability.perma_h_chips,
                perma_h_mult = card.ability.perma_h_mult,
                perma_h_x_chips = card.ability.perma_h_x_chips ~= 1 and card.ability.perma_h_x_chips or nil,
                perma_h_x_mult = card.ability.perma_h_x_mult ~= 1 and card.ability.perma_h_x_mult or nil,
                perma_h_dollars = card.ability.perma_h_dollars
            }

            L6W.funcs.mod_card_values(tablein, {multiply = mult})

            for k, v in pairs(tablein) do
                if k == 'nominal' then
                    card.base.nominal = v
                else
                    card.ability[k] = v
                end
            end
        end,

        increase_round_counter = function (card)
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
        end
    }
}