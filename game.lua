
npcs = {}
cam = vec2(32,32)

function new_npc(col)
    ret = {
        col = col,
        pos = vec2(rnd(64), rnd(64)),
    }
    return ret
end

function update_camera()
    if btn(0) then
        cam.x = max(cam.x - 0.25, 8)
    elseif btn(1) then
        cam.x = min(cam.x + 0.25, 56)
    end

    if btn(2) then
        cam.y = max(cam.y - 0.25, 8)
    elseif btn(3) then
        cam.y = min(cam.y + 0.25, 56)
    end
end

function update_npcs()
    for npc in all(npcs) do
        if npc.dest then
            local d = npc.dest - npc.pos
            if length(d) < 0.1 then
                npc.dest = nil
            else
                npc.pos += 0.0625 * normalize(d)
            end
        else
            npc.dest = vec2(rnd(64), rnd(64))
        end
    end
end

function _init()
    for col=1,3 do
        for i=1,6 do
            add(npcs, new_npc(col))
        end
    end
end

function _update60()
    update_camera()
    update_npcs()
end

function _draw()
    cls(0)
    camera(cam.x * 8 - 64, cam.y * 8 - 64)
    map(0,0,0,0,64,64)
    for npc in all(npcs) do
        pal(8, ({8,11,12})[npc.col])
        spr(8, npc.pos.x * 8, npc.pos.y * 8)
    end
    pal()
end

