SMODS.Sound {
    key = 'machine1',
    path = 'machine1.ogg'
}

SMODS.Sound {
    key = 'machine2',
    path = 'machine2.ogg'
}

SMODS.Sound {
    key = 'machine3',
    path = 'machine3.ogg'
}

-- booster music
SMODS.Sound {
    key = 'musicwishes',
    path = 'music_wishes.ogg',
    pitch = 0.7,
    volume = 1,
    select_music_track = function (self)
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.config.center.group_key == 'k_l6w_wishespack' then
            return 1000
        end
    end
}