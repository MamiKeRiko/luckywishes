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
        end
    }
}