# Lumia Text Box Advance

这是一个 Godot 工程，使用的 Godot 版本为 v4.3 。

## 25-02-10

这个工程是一个极简的文本显示器场景。这个场景运行的效果是，我们可以通过敲击空格键或者 Enter 键来显示下一段对话，文本会以类似打字的方式显示出来，就像视觉小说中那样。不过，这个场景可以添加到各种项目中。

这个场景的根节点为 TextBox ，可以在子节点 Scripts 下实例化 Script 场景，可以在这个场景的检查器中添加文本。场景运行时会读取所有 Scripts 下的 Script 结点，按顺序显示 Script 中的对话。

目前（2025-02-10），我们可以设置 TextBox 的位置和大小、字体、字体大小、文字颜色和文本背景颜色。

注意事项：

- 如果在打字机的动画没有播放完时推进文本，会将对话立刻完全显示出来。

- 在每个 Script 的 Dialogues 数组的最后，需要预留一个空字符串。如果不这样，最后一段文本的打字动画无法跳过，因为没有下一段对话了。

- 文本推进的方式默认是引擎自带的键位映射“ui-accept”，可以在 text_box.gd 中的 _unhandled_input() 函数中自行修改。
- 在最开始，第一个 Script 还没有被加载，需要多按一次键加载它。而在实际应用中，可以先使用 text_box.gd 中的 add_script() 函数手动添加 Script，这样就不用多按一次键了。

## 25-02-11

去掉了在 TextBox 中设置字体的功能。字体可以直接在 RichTextLabel 中设置，这样更灵活。

## 25-05-04

在原有的 Lumia Text Box 的基础上，使用 Lumia Scripts Parser 作为脚本解析器。这样可以直接使用 csv 格式的文本文件作为对话脚本。

# BBCode 的使用

`[i][/i]` 斜体

`[b][/b]` 粗体

`[i][b][/b][i]` 粗斜体

`[u][/u]` 下划线

`[s][/s]` 删除线

`[color=...][/color]` 指定文字颜色

`[shake][/shake]` 抖动效果

```
RichTextLabel is a flexible way of adding text to your project, with support for [i]italics[/i], [b]bold[/b] and [i][b]both[/b][/i].
[u]Underline[/u] and [s]strikethrough[/s] work too, including with [u][i]italics[/i][/u], [u][b]bold[/b][/u] and [u][i][b]both[/b][/i][/u].

Text [color=#4cf]color[/color], [fgcolor=#49c9]foreground [color=#4cf]color[/color][/fgcolor]  and  [bgcolor=#49c9]background [color=#4cf]color[/color][/bgcolor]  can be adjusted.

It's also possible to include [img]res://unicorn_icon.png[/img] [font_size=24]custom images[/font_size], as well as [color=aqua][url=https://godotengine.org]custom URLs[/url][/color]. [hint=This displays a hint.]Hover this to display a tooltip![/hint]
Left alignment is default,[center]but center alignment is supported,[/center][right]as well as right alignment.[/right]

[fill][dropcap font_size=48 color=yellow margins=0,-10,0,-12]F[/dropcap]ill alignment is also supported, and allows writing very long text that will end up fitting the horizontal space entirely with words of joy. Drop caps are also supported. When using a drop cap, the first character of a paragraph is made larger, taking up several lines of text and optionally using a specific font or color.[/fill]

Several effects are also available:    [pulse]Pulse[/pulse]    [wave]Wave[/wave]    [tornado]Tornado[/tornado]    [shake]Shake[/shake]    [fade start=75 length=7]Fade[/fade]    [rainbow]Rainbow[/rainbow]

[table=2]
[cell border=#fff3 bg=#fff1]
[ul]
Tables
are supported.
[/ul]
[/cell]
[cell border=#fc13 bg=#fc11]
[ol]
Ordered
list example.
[/ol]
[/cell]

[/table]

You can also create custom tags/effects, or customize behavior of [lb]url[rb] tags on click. For full reference, [color=aqua][url=https://docs.godotengine.org/en/latest/tutorials/gui/bbcode_in_richtextlabel.html]check the documentation.[/url][/color]
```

