Here's is the shader module code I wrote ( partially working ) which I placed in otclient/modules directory. Also, to be able to set the shaders I added a function in the source to be able to enable and switch back outline/default shader.

in tfs/localplayer.h
```
#ifndef LOCALPLAYER_H
#define LOCALPLAYER_H

#include "player.h"

// @bindclass
class LocalPlayer : public Player
{
    ...
public:
    ...

    void setShader(const PainterShaderProgramPtr& shader);
    void LocalPlayer::draw(const Point& dest, float scaleFactor, bool animate, LightView* lightView) override;
private:
    ...
    PainterShaderProgramPtr m_shader;
};

#endif
```
in tfs/localplayer.cpp
```
...
void LocalPlayer::setShader(const PainterShaderProgramPtr& shader)
{
    if (m_shader == shader)
        return;

	m_shader = shader;
}


void LocalPlayer::draw(const Point& dest, float scaleFactor, bool animate, LightView* lightView)
{

    if (m_shader) {
		g_painter->setShaderProgram(m_shader);
    }

    Creature::draw(dest, scaleFactor, animate, lightView);

    if (m_shader) {
        g_painter->resetShaderProgram();
    }
}    
...   
```

in shadermanager.h
```
...
    void registerShader(const std::string& name, const PainterShaderProgramPtr& shader);
...
```

in shadermanager.cpp
```
...
void ShaderManager::registerShader(const std::string& name, const PainterShaderProgramPtr& shader) {
    m_shaders[name] = shader;
}
...
```
