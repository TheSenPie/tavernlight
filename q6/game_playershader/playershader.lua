HOTKEY = 'Ctrl+Shift+P'
PLAYER_SHADERS = {
  { name = 'Default', frag = 'shaders/fragment/default.frag' , vert = 'shaders/core/vertex/default.vert' },
  { name = 'Outline', frag = 'shaders/fragment/outline.frag' }
}

shadersPanel = nil

function attachShaders()
  local player = g_game.getLocalPlayer()
  player:setShader(g_shaders.getShader('Default'))
end

function init()
  connect(g_game, { onGameStart = attachShaders })

  if not g_graphics.canUseShaders() then return end

  g_ui.importStyle('playershader.otui')

  g_keyboard.bindKeyDown(HOTKEY, toggle)

  shadersPanel = g_ui.createWidget('ShadersPanel', modules.game_interface.getMapPanel())
  shadersPanel:hide()

  local shadersComboBox = shadersPanel:getChildById('shadersComboBox')
  shadersComboBox.onOptionChange = function(combobox, option)
    local player = g_game.getLocalPlayer()
    player:setShader(g_shaders.getShader(option))
  end

  for _,opts in pairs(PLAYER_SHADERS) do

    local fragmentShaderPath = resolvepath(opts.frag)
    local vertexShaderPath = resolvepath(opts.frag ~= nil and opts.vert or "shaders/core/vertex/default.vert")

    if fragmentShaderPath ~= nil then
      local shader = g_shaders.createFragmentShader(opts.name, opts.frag)

      g_shaders.registerShader(opts.name, shader)
    end


    shadersComboBox:addOption(opts.name)
  end

  local player = g_game.getLocalPlayer()
  player:setShader(g_shaders.getShader('Default'))
end

function terminate()

  disconnect(g_game, { onGameStart = attachShaders })

  g_keyboard.unbindKeyDown(HOTKEY)
  shadersPanel:destroy()
  shadersPanel = nil
end

function toggle()
  shadersPanel:setVisible(not shadersPanel:isVisible())
end