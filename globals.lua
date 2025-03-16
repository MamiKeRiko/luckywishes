-- set custom globals
L6W = {
    C = {
        main =  HEX('6E3AA6'),
        secondary = HEX('a36be8')
    },

    funcs = {
        
        --- Given an `amount` of cards, an index `i` of the current's card position 
        --- in this group of cards, and a delay `t` between each card being flipped,
        --- flips `card`, performs `function` while `card` is flipped, and un-flips `card`.
        --- @param card table
        --- @param i number
        --- @param context table
        --- @param amount number
        --- @param t number
        --- @param func function
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
    
        --- Given a card's `id`, return its corresponding character. (2-9, T, J, Q, K, A)
        --- @param id number
        --- @return string|number|nil
        parse_id_to_rank = function (id)
             -- imagine if lua had switch statements wouldn't that be crazy useful haha
            if id < 10 then return id
            elseif id == 10 then return 'T'
            elseif id == 11 then return 'J'
            elseif id == 12 then return 'Q'
            elseif id == 13 then return 'K'
            elseif id == 14 then return 'A'
            else return nil
            end
        end,

        --- Given a card's `suit` name, return its initial. (H, S, C, D)
        ---@param suit string
        ---@return string
        parse_suit = function (suit)
            return suit:sub(1,1)
        end,

        --- Given a `hand_name`, return the key for its corresponding planet card.
        ---@param hand_name string
        ---@return string
        get_planet_from_hand = function (hand_name)
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == hand_name then
                    return v.key
                end
            end
        end,

        --- Returns the name of the current most played hand.
        --- @return string
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

        --- Credit to Aikoyori for this function. Given a `table_in` (value table or card object) and a config table,
        --- modifies the values in `table_in` depending on the `config` provided. `config` accepts these values:
        --- * `add`
        --- * `multiply`
        --- * `keywords`: list of specific values to change in `table_in`. If nil, change every value in `table_in`.
        --- * `reference`: initial values for the provided table. If nil, defaults to `table_in`.
        --- 
        --- This function scans all sub-table for numeric values, so it's recommended to pass the card's ability table
        --- rather than the entire card object.
        ---@param table_in table|Card
        ---@param config table
        mod_card_values = function(table_in, config)
             -- thanks aikoyori for this func
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

        --- Calls `mod_card_values` to multiply `card`'s values by `mult`, making sure to also modify the nominal value.
        ---@param card table|Card
        ---@param mult number
        xmult_playing_card = function(card, mult)
            local tablein = { -- hoo boy here we go
                nominal = card.base.nominal,
                ability = card.ability
            }

            L6W.funcs.mod_card_values(tablein, {multiply = mult})

            card.base.nominal = tablein.nominal
            card.base.ability = tablein.ability
        end,

        --- Handles end of round logic for wish cards, increasing the round value and applying effects and 
        --- ui messages where appropiate.
        ---@param card table|Card
        ---@return table
        increase_round_counter = function (card)
            card.ability.extra.rounds_current = card.ability.extra.rounds_current + 1
            if card.ability.extra.rounds_current < card.ability.extra.rounds_min then
                return {
                    message = card.ability.extra.rounds_current .. '/' .. card.ability.extra.rounds_min
                }
            elseif card.ability.extra.rounds_current < card.ability.extra.rounds_min + 2 then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
                return {
                    message = localize('k_active_ex')
                }
            else
                card:start_dissolve()
                return {
                    message = localize('k_l6_wither')
                }
            end
        end,
    }
}