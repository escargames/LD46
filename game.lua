
cards = {
    { name = 'water',
      cost = 1,
      desc = 'water plant for 3 turns',
      turns = 3,
      effect = function(g) g.water += 1 end
    },
    {
      name = 'sun',
      cost = 1,
      desc = 'put the flower in a sunny place',
      turns = 1,
      effect = function(g) g.sun = true end,
    },
    {
      name = 'shade',
      cost = 1,
      desc = 'put the flower in the shade',
      effect = function(g) g.sun = false end,
    },
}

function new_game()
    local deck = {}
    for i=1,4 do
        add(deck, cards[1+rnd(#cards)\1])
    end
    return {
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
    if #game.deck > 0 then
        if game.sel < 0 then
            game.sel = 1
        end
        if btnp(2) then game.sel = 1 + (game.sel - 2) % #game.deck end
        if btnp(3) then game.sel = 1 + (game.sel) % #game.deck end
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
    for i=1,#game.deck do
        local prefix = i == game.sel and '* ' or '  '
        print(prefix..game.deck[i].name..' ['..game.deck[i].cost..']', 3, 50 + 7 * i)
    end
    color(7)
    if game.sel > 0 then
        print('description:', 3, 100)
        print(game.deck[game.sel].desc, 3, 107)
    end
end

