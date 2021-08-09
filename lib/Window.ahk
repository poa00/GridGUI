﻿
#Include %A_LineFile%\..\Position.ahk

Class Window {
	Static		WM_SIZE		:= 0x0005
			,	WM_SIZING	:= 0x0214
			,	WM_MOVE		:= 0x0003


	__New(hwnd, callbacks := False) {
		this.hwnd := hwnd
		this.callbacks := callbacks
		this.__Setup()
	}
	
	__Setup() {
		if(IsObject(this.callbacks)) {
			for i, callback in this.callbacks {
				OnMessage(callback.msgNum, callback.function)
			}
		}
	}
	
	WinShow() {
		WinShow, WinTitle, % "ahk_id " this.hwnd
	}
	
	WinHide() {
		WinHide, WinTitle, % "ahk_id " this.hwnd
	}
	
	WinGetPos() {
		WinGetPos, x, y, w, h, % "ahk_id " this.hwnd
		return new Position(x, y, w, h)
	}
	
	WinMove(x := "", y := "", w := "", h := "") {
		WinMove, % "ahk_id " this.hwnd, , % x, % y, % w , % h
	}
	
	WinExist() {
		return WinExist("ahk_id " this.hwnd)
	}
	
	WinActivate() {
		WinActivate, % "ahk_id " this.hwnd
	}
	
	WinGet(SubCommand) {
		WinGet, OutputVar, % SubCommand, % "ahk_id " this.hwnd
		return OutputVar
	}
	
	WinSet(SubCommand, Value) {
		WinSet, % SubCommand, % Value, % "ahk_id " this.hwnd
	}
	
	ControlGetFocus() {
		CtrlHwnd := ""
		ControlGetFocus, CtrlClass, % "ahk_id " this.hwnd
		if(CtrlClass) {
			ControlGet, CtrlHwnd, Hwnd, , % CtrlClass, % "ahk_id " this.hwnd
		}
		return CtrlHwnd
	}
	
	ToStr(indent := "") {
		return indent "Hwnd:`t" this.hwnd "`n" indent "Pos:`n" this.WinGetPos().ToStr("`t")
	}
}

Class GuiCallback {
	__New(msgNum, function) {
		this.msgNum := msgNum
		this.function := IsObject(function) ? function : Func(function)
	}
	
	ToStr(indent := "") {
		return indent "MsgNum`t:" this.msgNum "`n" indent "Function:`n" this.function.ToStr("`t")
	}
}