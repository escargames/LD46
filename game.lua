
card_def = {
    { name = 'water',
      count = 3,
      cost = 1,
      desc = 'water plant for 3 turns',
      turns = 3,
      effect = function(g) g.water += 1 end
    },
    {
      name = 'sun',
      count = 3,
      cost = 1,
      desc = 'put the flower in a sunny place',
      turns = 1,
      effect = function(g) g.sun = true end,
    },
    {
      name = 'shade',
      count = 3,
      cost = 1,
      desc = 'put the flower in the shade',
      effect = function(g) g.sun = false end,
    },
}

function shuffle(t)
    for i = 1,#t do
        j = #t - rnd(#t-i)\1
        if i != j then
            t[i], t[j] = t[j], t[i]
        end
    end
end

function new_game()
    deck = {}
    for i = 1,#card_def do
        for j = 1,card_def[i].count do
            add(deck, card_def[i])
        end
    end
    shuffle(deck)
    return {
        hand = {},
        deck = deck,
        turn = 1,
        sun = false,
        water = 0,
        light = 0,
        size = 0,

        sel = -1,
    }
end

function _init()
    game = new_game()
end

function _update60()
    -- draw new cards if not enough
    while #game.hand < 4 do
        add(game.hand, game.deck[#game.deck])
        game.deck[#game.deck] = nil
    end
    -- browse cards in hand
    if #game.hand > 0 then
        if game.sel < 0 then
            game.sel = 1
        end
        if btnp(2) then game.sel = 1 + (game.sel - 2) % #game.hand end
        if btnp(3) then game.sel = 1 + (game.sel) % #game.hand end
    end
end

function _draw()
    cls(0)
    color(7)
    print('turn '..game.turn, 1,1)
    color(9)
    print('  water '..game.water, 10, 20)
    print('  light '..game.light, 10, 27)
    print('  size '..game.size, 10, 34)
    print('  sun '..tostr(game.sun), 10, 41)
    color(12)
    for i=1,#game.hand do
        local prefix = i == game.sel and '* ' or '  '
        print(prefix..game.hand[i].name..' ['..game.hand[i].cost..']', 3, 50 + 7 * i)
    end
    color(7)
    if game.sel > 0 then
        print('description:', 3, 100)
        print(game.hand[game.sel].desc, 3, 107)
    end
end

