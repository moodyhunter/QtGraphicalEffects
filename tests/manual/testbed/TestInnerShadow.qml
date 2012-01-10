/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Graphical Effects module.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import "../../../src/effects"

TestCaseTemplate {

    ImageSource {
        id: imageSource
        source: "images/butterfly.png"
        anchors.centerIn: parent
        forcedUpdateAnimationRunning: updateCheckBox.selected
    }

    ShaderEffectSource {
        id: shaderEffectSource
        sourceItem: imageSource
        hideSource: enabledCheckBox.selected
        smooth: true
    }

    InnerShadow {
        id: effect
        anchors.fill: imageSource
        horizontalOffset: (offsetPicker.xValue - 0.5) * width
        verticalOffset: (offsetPicker.yValue - 0.5) * height
        samples: samplesSlider.value
        radius: radiusSlider.value
        spread: spreadSlider.value
        color: colorPicker.color
        visible: enabledCheckBox.selected
        cached: cachedCheckBox.selected
        fast: fastCheckBox.selected
        source: sourceType.value == "shaderEffectSource" ? shaderEffectSource : imageSource
    }

    PositionPicker {
        id: offsetPicker
        xValue: 0.50
        yValue: 0.50
    }

    bgColor: bgColorPicker.color
    controls: [
        Control {
            caption: "general"
            Label {
                caption: "horizontalOffset"
                text: effect.horizontalOffset
            }
            Label {
                caption: "verticalOffset"
                text: effect.verticalOffset
            }
            Slider {
                id: radiusSlider
                minimum: 0
                maximum: 16
                value: 8
                caption: "radius"
            }
            Slider {
                id: samplesSlider
                minimum: 0
                maximum: 32
                value: 32
                integer: true
                caption: "samples"
            }
            Slider {
                id: spreadSlider
                minimum: 0
                maximum: 1.0
                value: 0.0
                caption: "spread"
            }
            CheckBox {
                id: fastCheckBox
                caption: "fast"
                selected: false
            }
        },

        Control {
            caption: "color"
            ColorPicker {
                id: colorPicker
                hue: 0
                saturation: 0
                lightness: 0
                alpha: 1.0
            }
        },

        Control {
            caption: "advanced"
            last: true
            Label {
                caption: "Effect size"
                text: effect.width + "x" + effect.height
            }
            Label {
                caption: "FPS"
                text: fps
            }
            CheckBox {
                id: cachedCheckBox
                caption: "cached"
            }
            CheckBox {
                id: enabledCheckBox
                caption: "enabled"
            }
            CheckBox {
                id: updateCheckBox
                caption: "animated"
                selected: false
            }
            RadioButtonColumn {
                id: sourceType
                value: "shaderEffectSource"
                caption: "source type"
                RadioButton {
                    caption: "shaderEffectSource"
                    selected: caption == sourceType.value
                    onPressedChanged: sourceType.value = caption
                }
                RadioButton {
                    caption: "image"
                    selected: caption == sourceType.value
                    onPressedChanged: {
                        sourceType.value = caption
                        updateCheckBox.selected = false
                    }
                }
            }
            BGColorPicker {
                id: bgColorPicker
                color: "#ababab"
            }
        }
    ]
}