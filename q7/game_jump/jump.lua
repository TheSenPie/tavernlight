jumpWindow = nil
jumpButton = nil

function init()
  jumpWindow = g_ui.displayUI('jump')

  jumpButton = jumpWindow:getChildById('jumpButton')
  jumpButton:setX(jumpWindow:getX() + jumpWindow:getWidth())

  connect(g_app, { onFps = updateFps })
  jumpButton.onClick = resetPos
end

function terminate()
  disconnect(g_app, { onFps = updateFps })
  jumpWindow:destroy()
end

function updateFps(fps)
  offset = jumpButton:getX()
  jumpButton:setX(offset - 40)
end

function resetPos()
  g_game.talk('/jump' .. jumpButton:getWidth())
  jumpButton:setX(jumpWindow:getX() + jumpWindow:getWidth() - jumpButton:getWidth() - 10)
  posY = math.random(0, jumpWindow:getHeight() - jumpButton:getHeight() - 20) 
  jumpButton:setY(10 + jumpWindow:getY() + posY) 
end