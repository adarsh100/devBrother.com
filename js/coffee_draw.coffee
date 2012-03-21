# @pjs preload="spider.png";
coffee_draw = (p) ->
  CONFIG =
    width : $('#processing').width()
    height: $('#processing').height()

  class Map
    constructor:()->
      @web_lines = []

    put_web_lines : (x1, y1, x2, y2)->
      @web_lines.push([x1, y1, x2, y2])

    turn:()->
      _.each @web_lines, (li)=>
        p.line li[0], li[1], li[2], li[3]
    

  class Spider
    constructor: (x, y)->
      @animation_i = 0
      @location   = {}
      @location.x = x || CONFIG.width/2
      @location.y = y || CONFIG.height/2
      @img = p.loadImage("spider.png")
      p.image @img, @location.x - 12, @location.y - 12, 24,24
      @moves = []

    draw: ()->
      p.image @img, @location.x - 12, @location.y - 12, 24,24

    draw_lines : ()->
      leftx = 0
      rightx = CONFIG.width
      topy = 0
      downy = CONFIG.height
      midx = (leftx + rightx)/2
      midy = (topy + downy)/2
      
      step = 20
      num = (rightx-leftx)/step
      i = 0
      while i < num-1
        i = i+1
        cur  = (i*step)
        p.line(leftx + cur, topy, midx, midy)
        p.line(midx, midy, rightx-cur, downy )

      step = 20
      num = (downy-topy)/step
      i = 0
      while i < num-1
        i = i+1
        cur  = (i*step)
        p.line(leftx, topy + cur, midx, midy)
        p.line(midx, midy, rightx, downy-cur )

      p.line(0,0,midx, midy)
      p.line(midx, midy, CONFIG.width, CONFIG.height)

    draw_web:()->
      x1 = @location.x
      y1 = @location.y
      if @animation_i < 117
        angle = 0.5 * @animation_i
        x2 = x1 + (1 + 1 * angle) * Math.cos(angle)
        y2 = y1 + (1 + 1 * angle) * Math.sin(angle)
        map.put_web_lines x1, y1, x2, y2
        @location.x = x2
        @location.y = y2
        @animation_i++
      if @animation_i > 40
        p.frameRate 4



  map    = new Map()
  spider = new Spider()

  p.setup = () ->
    p.size CONFIG.width, CONFIG.height
    p.stroke 25

  p.draw = () ->
    p.background 255
    map.turn()
    spider.draw_lines()
    spider.draw()
    spider.draw_web()


$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)
