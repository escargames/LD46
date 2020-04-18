
-- print small version of map
cls(0)
for y=0,63 do
  for x=0,63 do
    local n=mget(x,y)
    if n>0 then
      sspr(n%16*8,n\16*8,8,8,x*2,y*2,2,2)
    end
  end
end

-- pick two random points
sx,sy = crnd(1,63)\1, crnd(1,63)\1
ex,ey = crnd(1,63)\1, crnd(1,63)\1

pset(sx*2,sy*2,8)
pset(ex*2,ey*2,8)

function encode(x,y)
    n = x + y/256
    return n
end

function size(t)
    local s=0
    for k,v in pairs(t) do
        s+=1
    end
    return s
end

visited = {}
todo={}
todo[encode(sx,sy)]=1
next = {}
finish = encode(ex,ey)
light = finish

while visited[finish]==nil do
    for k,v in pairs(todo) do
        local m={}
        m.x = flr(k)
        m.y = k%1*256
        function addtonext(x,y)
            if m.x < 0 or m.x > 64 or m.y < 0 or m.y > 64 then
                return
            end   

            local val = 0
            if mget(x,y)==1 then -- mountain
                return
            elseif mget(x,y)==5 then -- water
                return
            elseif mget(x,y)==7 then -- grass
                val=v+8
            else
                val=v+1
            end

            if not visited[encode(x,y)] then
                next[encode(x,y)]=val
            else
                if visited[encode(x,y)] > val then
                    next[encode(x,y)]=val
                end
            end
        end
        
        addtonext(m.x+1,m.y)
        addtonext(m.x-1,m.y)
        addtonext(m.x,m.y+1)
        addtonext(m.x,m.y-1)
        visited[k] = v
    end
    todo = next
    next = {}
end

dist = visited[finish]

while dist>1 do 
    local a={}
    local m={}
    m.x = flr(light)
    m.y = light%1*256
    function addtolight(x0,y0)
        if visited[encode(x0,y0)]!=nil then
            if visited[encode(x0,y0)] < dist then
                dist=visited[encode(x0,y0)]
                a={x=x0, y=y0}
            end 
        end
    end
    addtolight(m.x+1,m.y)
    addtolight(m.x-1,m.y)
    addtolight(m.x,m.y+1)
    addtolight(m.x,m.y-1)

    pset(a.x*2,a.y*2,7)
    light = encode(a.x,a.y)
end
pset(sx*2,sy*2,12)
pset(ex*2,ey*2,12)

