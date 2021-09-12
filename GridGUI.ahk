﻿Class GridGUI {
	#Include %A_LineFile%\..\GridGUI-lib\Gui.ahk
	#Include %A_LineFile%\..\GridGUI-lib\Grid.ahk
	#Include %A_LineFile%\..\GridGUI-lib\Version.ahk
	
	__New(title := "", options := "", showGrid := false) {
		return new GridGUI.GridGUIClass(title, options, showGrid)
	}
	
	Area(w, h, x := 0, y := 0) {
		return new GridGUI.Position(x, y, w, h)
	}
	
	Pos(x, y, w := 0, h := 0) {
		return new GridGUI.Position(x, y, w, h)
	}

	Class GridGUIClass Extends GridGUI.GUI {

		__New(title := "", options := "", showGrid := false) {
			local Base
			Base.__New(title, options)
			this.__Init(showGrid)
		}
		
		__Init(showGrid) {
			this.grid := new GridGUI.Grid()
			this.showGrid := showGrid
			this.gridlines := [[], []]
			this.margins := {x: 5, y: 5}
		}
		
		Add(x, y, type, options := "", text := "", exW := 0, exH := 0, fillW := 0, fillH := 0, justify := "C") {
			local ctrl
			if(IsObject(options)) {
				text :=		options.HasKey("text") ?	options["text"] :		text
				exW :=		options.HasKey("exW") ?		options["exW"] :		exW
				exH :=		options.HasKey("exH") ?		options["exH"] :		exH
				fillW :=	options.HasKey("fillW") ?	options["fillW"] :		fillW
				fillH :=	options.HasKey("fillH") ?	options["fillH"] :		fillH
				justify :=	options.HasKey("justify") ?	options["justify"] :	justify
				options :=	options.HasKey("options") ?	options["options"] :	""
			}
			ctrl := new GridGUI.ArbitraryControl(this.hwnd, type, options, text)
			return this.AddControl(x, y, ctrl, exW, exH, fillW, fillH, justify)
		}
		
		AddControl(x, y, ctrl, exW := 0, exH := 0, fillW := 0, fillH := 0, justify := "C") {
			local pos, gridCell
			if(IsObject(exW)) {
				exH :=		exW.HasKey("exH") ?		exW["exH"] :		exH
				fillW :=	exW.HasKey("fillW") ?	exW["fillW"] :		fillW
				fillH :=	exW.HasKey("fillH") ?	exW["fillH"] :		fillH
				justify :=	exW.HasKey("justify") ?	exW["justify"] :	justify
				exW :=		exW.HasKey("exW") ?		exW["exW"] :		0
			}
			pos := this.__TranslateGridPos(x, y)
			gridCell := new GridGUI.Cell(pos, ctrl, exW, exH, fillW, fillH, justify, this.margins["x"], this.margins["y"])
			gridCell.cPos := this.__DPIScale(gridCell.cPos, false)
			this.grid.AddCell(gridCell)
			return ctrl
		}
		
		GetCellGroupsAt(GridPos) {
			return this.grid.columns.columns[GridPos.x].cells[GridPos.y]
			;return this.grid.rows.rows[GridPos.y].cells[GridPos.x]
		}
		
		GetCellGroup(Ctrl) {
			local i, cell
			for i, cell in this.grid.cells {
				if(ctrl.hwnd = cell.ctrl.hwnd) {
					return cell
				}
			}
		}
		
		GetNewestCellGroup() {
			return this.grid.cells[this.grid.cells.Length()]
		}
		
		Show(options := "AutoSize") {
			local Base
			if(options = "AutoSize") {
				options := "w" this.grid.GetMinWidth() " h" this.grid.GetMinHeight()
			}
			Base.Show(options)
		}
		
		AutoSize() {
			this.pos.w := this.grid.GetMinWidth()
			this.pos.h := this.grid.GetMinHeight()
			this.Draw(this.pos)
		}
		
		Margin(x := "", y := "") {
			local i, cell
			this.margins["x"] := (x != "") ? x : this.margins["x"]
			this.margins["y"] := (y != "") ? y : this.margins["y"]
			for i, cell in this.grid.cells {
				cell.borderX := this.margins["x"]
				cell.borderY := this.margins["y"]
			}
			this.ReDraw()
		}
		
		ReDraw() {
			this.grid.ResetConstants()
			this.Draw(this.pos)
		}
		
		Draw(pos) {
			local area
			area := pos.copy(), area.x := 0, area.y := 0
			this.grid.CalculatePositions(area)
		}
		
		GuiSize(pos) {
			local Base, area
			Base.GuiSize(pos)
			this.Draw(this.pos)
			if(this.showGrid) {
				ToolTip, % "Pos: (" this.pos.x ", " this.pos.y ")`nSize: (" this.pos.w ", " this.pos.h ")`nRSize: (" pos.w ", " pos.h ")"
				area := this.pos.copy(), area.x := 0, area.y := 0
				This.DrawGrid(area)
			}
		}
		
		GuiMoved(pos) {
			local Base
			Base.GuiMoved(pos)
			if(this.showGrid) {
				ToolTip, % "Pos: (" this.pos.x ", " this.pos.y ")`nSize: (" this.pos.w ", " this.pos.h ")"
			}
		}
		
		DrawGrid(area) {
			local Base, ctrl, x, y, i, width, height
			if(!this.gridlines[1].Length()) {
				loop % this.grid.widths.Count() + 1 {
					ctrl := Base.Add("Progress", "h2")
					ctrl.GuiControl("+Background777777", "")
					this.gridlines[1].Push(ctrl)
				}
				loop % this.grid.heights.Count() + 1 {
					ctrl := Base.Add("Progress", "w2")
					ctrl.GuiControl("+Background777777", "")
					this.gridlines[2].Push(ctrl)
				}
			}
			
			area := area ? area : this.pos
			x := 0
			this.gridlines[1][1].GuiControl("Move", "x" area.x + x " y" area.y " w" 2 " h" area.h)
			for i, width in this.grid.widths {
				x += width
				this.gridlines[1][A_Index + 1].GuiControl("Move", "x" area.x + x " y" area.y " w" 2 " h" area.h)
			}
			y := 0
			this.gridlines[2][1].GuiControl("Move", "x" area.x " y" area.y + y " w" area.w " h" 2)
			for i, height in this.grid.heights {
				y += height
				this.gridlines[2][A_Index + 1].GuiControl("Move", "x" area.x " y" area.y + y " w" area.w " h" 2)
			}
		}
		
		__TranslateGridPos(x, y) {
			local w, h, pos
			w := 1
			h := 1
			if(pos := InStr(x, "-")) {
				w += SubStr(x, pos + 1) - SubStr(x, 1, pos - 1)
				x := SubStr(x, 1, pos - 1)
			}
			if(pos := InStr(y, "-")) {
				h += SubStr(y, pos + 1) - SubStr(y, 1, pos - 1)
				y := SubStr(y, 1, pos - 1)
			}
			return new GridGUI.Position(x, y, w, h)
		}
	}
	
	Class SubGrid Extends GridGUI.GridGUIClass {
	
		__New(guiHwnd, area := false, DPIScale := true, showGrid := false) {
			this.hwnd := guiHwnd
			this.__Init(area, showGrid)
			this.DPIScale := DPIScale
		}
		
		__Init(area, showGrid) {
			local Base
			Base.__Init(showGrid)
			this.pos := area ? area : new GridGUI.Position(0, 0, 0, 0)
			if(this.pos.w) {
				this.initialWidth := true
				this.initialWidthVal := this.pos.w
			}
			if(this.pos.h) {
				this.initialHeight := true
				this.initialHeightVal := this.pos.h
			}
		}
		
		Draw(area) {
			this.pos := area
			this.grid.CalculatePositions(area)
			if(this.showGrid) {
				This.DrawGrid(this.pos)
			}
		}
		
		ControlGetPos() {
			return this.pos
		}
	}
}
