﻿
#Include %A_ScriptDir%\..\GridGUI.ahk

myGui := new GridGUI("Grid Test", "resize")
myGui.GuiClose := GridGUI.ExitApp

myGui.Add("1-3", 1, "Edit", , , 1, , 1)
myGui.Add(1, 2, "Button", , "Button")
myGui.Add(2, 2, "Edit", "w0", , 1, , 1)
oWB := myGui.Add(3, "2-3", "ActiveX", "w113 h43", "shell explorer").vVar
oWB.Navigate("about:<!DOCTYPE HTML><html><body style=""{margin:0;}""><img src=""https://i.imgur.com/FlGrIY3.gif""></body></html>")
oWB.document.body.style.overflow := "hidden"
myGui.Add(1, 3, "Button", , "Button")
myGui.Add(2, 3, "Button", , "Button Button")
myGui.Add("1-3", 4, "Button", , "Button", 1, , 1)
myGui.AutoSize()
myGui.Show()
return

+::myGui.Margin(myGui.margins["x"] + 1, myGui.margins["y"] + 1)
-::myGui.Margin(myGui.margins["x"] - 1, myGui.margins["y"] - 1)
