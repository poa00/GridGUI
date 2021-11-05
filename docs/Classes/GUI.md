#GUI
<figure markdown="1">
A class representing a GUI.
</figure>
---
##Members

####BackgroundCtrls

> **desc**: An array of controls that should be lowered below all newly added controls and which have the style `WS_CLIPSIBLINGS` applied. To register a background control see `GridGUI.GUI.RegisterBackground`.

> **type**: array

> **default**: []

####DPIScale

> **desc**: Whether or not to correct for non standard dpi.

> **type**: bool

####DropTarges

> **desc**: An object of hwnds mapping to callbacks that will be call on `WM_DROPFILES` if the event was on a control with the corresponding hwnd. To register a callback see `GridGUI.GUI.RegisterDropTarget`.

> **type**: object

> **default**: {}

####ForegroundCtrls

> **desc**: An array of controls that should be raised above all newly added controls and which are redrawn after other controls have been drawn. To register a foreground control see `GridGUI.GUI.RegisterForeground`.

> **type**: array

> **default**: []

####GuiActivate

> **desc**: The callback that will be called on `WM_ACTIVATE`.

> **type**: Func|BoundFunc|false

####GuiClose

> **desc**: The callback that will be called on `WM_SYSCOMMAND` if `wParam` equals `SC_CLOSE`.

> **type**: Func|BoundFunc|false

####GuiContextMenu

> **desc**: The callback that will be called on `WM_CONTEXTMENU`.

> **type**: Func|BoundFunc|false

####GuiMoved

> **desc**: The callback that will be called on `WM_MOVE`.

> **type**: Func|BoundFunc|false

####GuiSize

> **desc**: The callback that will be called on `WM_SIZE`.

> **type**: Func|BoundFunc|false

####pos

> **desc**: The position of this GUI.

> **type**: GridGUI.Position

> **default**: GridGUI.Position(0, 0)

##Methods

####__CheckOptions
**desc**: Parses option strings for values that are used by the class and updated the instance based on the values.

**args**:

> **name**: options

> **desc**: An ahk GUI option string.

> **type**: string

**returns**:

> **desc**: The `options` argument minus anything that class handles, currently only `gLabels` are removed.

> **type**: string

####__DPIScale
**desc**: Scale a position by the dpi ratio, that is `A_ScreenDPI / 96`.

**args**:

> **name**: pos

> **desc**: The `GridGUI.Position` instance to scale.

> **type**: GridGUI.Position

> **name**: enlarge

> **desc**: Whether to increase or decrease the size of `pos`.

> **type**: bool

**returns**:

> **desc**: The scaled position.

> **type**: GridGUI.Position

####__GuiActivate
**desc**: The internal callback on `WM_ACTIVATE` that calls the user defined `GridGUI.GUI.GuiActivate` if it evaluates to true. The callback is called with the low-order word of `wParam`.

**args**:

> **name**: wParam

> **desc**: Low-order word is the active state of the changed window, the high-order word is whether the window was minimised. If the low-order word is **1** the window was activated, if it is **2** the window was activated by a mouse click and if it is **0** the window is deactivated.

> **type**: number

> **name**: lParam

> **desc**: The hwnd of the window where the active state of the window changed.

> **type**: number

> **name**: msg

> **desc**: WM_ACTIVATE (0x0006).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__GuiContextMenu
**desc**: The internal callback on `WM_CONTEXTMENU` that calls the user defined `GridGUI.GUI.GuiContextMenu` if it evaluates to true. The callback is called with the clicked coordinate as a `GridGUI.Position` and with the hwnd of the windows that was right-clicked.

**args**:

> **name**: wParam

> **desc**: The hwnd of the windows that was right-clicked.

> **type**: hwnd

> **name**: lParam

> **desc**: The clicked coordinate. The low-order word is the x coordinate. The high-order word is the y coordinate.

> **type**: number

> **name**: msg

> **desc**: WM_CONTEXTMENU (0x007B).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__GuiDropFiles
**desc**: The internal callback on `WM_DROPFILES` that calls the user defined `GridGUI.GUI.DropTarges` if the callback associated array has the `hwnd` argument as one of its key. The callback is called with an array of the dropped files.

**args**:

> **name**: hDrop

> **desc**: A handle to an internal structure describing the dropped files.

> **type**: number

> **name**: lParam

> **desc**: Always zero.

> **type**: number

> **name**: msg

> **desc**: WM_DROPFILES (0x0233).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__GuiInit
**desc**: Initialises all the members of the GUI class.

####__GuiMoved
**desc**: The internal callback on `WM_MOVE` that calls `GridGUI.GUI._GuiMoved` with the new location as a `GridGUI.Position`.

**args**:

> **name**: wParam

> **desc**: Unused.

> **type**: number

> **name**: lParam

> **desc**: The coordinate of the top left corner of the window. The low-order word is the x coordinate and the high-order word is the y coordinate.

> **type**: number

> **name**: msg

> **desc**: WM_MOVE (0x0003).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__GuiSize
**desc**: The internal callback on `WM_SIZE` that calls `GridGUI.GUI._GuiSize` with the new area as a `GridGUI.Position` where x and y are both zero and with the `wParam` argument.

**args**:

> **name**: wParam

> **desc**: The type of resizing that have occurred. **0** is normal resizing, **1** means that the window was minimised and **2** means that it was maximised.

> **type**: number

> **name**: lParam

> **desc**: The new area of the window. The low-order word is the width and the high-order word is the height.

> **type**: number

> **name**: msg

> **desc**: WM_SIZE (0x0005).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__LowerBackgoundCtrls
**desc**: Lowers the z-order of all registered controls in `GridGUI.GUI.BackgroundCtrls`. To register controls as background controls see `GridGUI.GUI.RegisterBackground`.

####__New
**desc**: Constructor.

**args**:

> **name**: title

> **desc**: The title of the newly created GUI.

> **type**: string

> **name**: options

> **desc**: The gui option string that the GUI will be created with.

> **type**: string

> **name**: hwnd

> **desc**: If specified then no new GUI will be created and no `OnMessage` callbacks will be set up. Instead the `GridGUI.GUI` instance will work like a wrapper for the GUI that can be used to interact with it.

> **type**: string

**returns**:

> **desc**: A new `GridGUI.GUI` instance.

> **type**: GridGUI.GUI

####__OnAdd
**desc**: Updates the z-order of registered controls. Called when a control is added to the GUI.

####__OnPaint
**desc**: The internal callback on `WM_PAINT` that calls `GridGUI.GUI.__ReDrawForgoundCtrls` to fix issues with overlapping controls for controls registered in `GridGUI.GUI.ForegroundCtrls`.

**args**:

> **name**: wParam

> **desc**: Unused.

> **type**: number

> **name**: lParam

> **desc**: Unused.

> **type**: number

> **name**: msg

> **desc**: WM_PAINT (0x000F).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####__RaiseForgoundCtrls
**desc**: Raises the z-order of all registered controls in `GridGUI.GUI.ForegroundCtrls`. To register controls as background controls see `GridGUI.GUI.RegisterForeground`.

####__ReDrawForgoundCtrls
**desc**: Redraws the controls registered with `GridGUI.GUI.RegisterForeground`. Called on `WM_PAINT`.

####__SysCommand
**desc**: The internal callback on `WM_SYSCOMMAND` that calls the user defined `GridGUI.GUI.GuiClose` callback on `SC_CLOSE` if the callback variable evaluates to true.

**args**:

> **name**: wParam

> **desc**: The type of system command requested, see link for a list of values.

> **type**: number

> **name**: lParam

> **desc**: The coordinate of the mouse, if this message was triggered by a menu selection, otherwise the argument is unused. The low-order word is the x coordinate and the high-order word is the y coordinate.

> **type**: number

> **name**: msg

> **desc**: WM_SYSCOMMAND (0x0112).

> **type**: number

> **name**: hwnd

> **desc**: The hwnd of the window or control that recieved the message.

> **type**: hwnd

####_GuiMoved
**desc**: An internal callback used to update the x and y coordinate of `GridGUI.GUI.pos` and to call the user defined `GridGUI.GUI.GuiMoved` callback

**args**:

> **name**: pos

> **desc**: The new coordinate of the top left corner of the GUI. The width and height are both zero.

> **type**: GridGUI.Position

####_GuiSize
**desc**: An internal callback used to update the width and height of `GridGUI.GUI.pos` and to call the user defined `GridGUI.GUI.GuiSize` callback

**args**:

> **name**: pos

> **desc**: The new area of the GUI. The x and y coordinate are both zero.

> **type**: GridGUI.Position

> **name**: resizeEvent

> **desc**: A number indicating whether the GUI was maximised, minimised or neither that is passed on to the user defined `GridGUI.GUI.GuiSize` callback. See the link for what the numbers mean.

> **type**: number

####Add
**desc**: Adds most standard ahk controls to the GUI.

**args**:

> **name**: controlType

> **desc**: The type of the control. Can be `Text, Edit, UpDown, Picture, Button, Checkbox, DropDownList, ComboBox, ListBox, Link, Hotkey, DateTime, MonthCal, Slider, Progress, GroupBox and ActiveX`. For `Radio, ListView, TreeView, Tab3 and StatusBar` see [AdditionalControls](AdditionalControls)

> **type**: string

> **name**: options

> **desc**: The options that the GuiControl will be created with. Does not accept vVars. Can be an object with keys the same names as the optional arguments that this method takes.

> **type**: string

> **name**: text

> **desc**: The text that the control will be created with.

> **type**: string

**returns**:

> **desc**: The added control instance.

> **type**: GridGUI.ArbitraryControl

####Color
**desc**: A thin method wrapper for `Gui, Color`.

**args**:

> **name**: WindowColor

> **desc**: The colour of the background of the GUI. See link for the supported format.

> **type**: string

> **name**: ControlColor

> **desc**: The colour of the background of controls that are added to the GUI in the future. See link for the supported format.

> **type**: string

####ControlGetFocus
**desc**: Retrives the hwnd of the control with input focus.

**returns**:

> **desc**: The hwnd of the focused control.

> **type**: hwnd

####Default
**desc**: A thin method wrapper for `Gui, Default`.

####Destroy
**desc**: A thin method wrapper for `Gui, Destroy`.

####Flash
**desc**: A thin method wrapper for `Gui, Flash`, except that it used a bool instead of a string to indicate that the colour should be restored.

**args**:

> **name**: Off

> **desc**: If `false` the GUI flashes. If `true` the colour of the GUI is restored.

> **type**: bool

####Font
**desc**: A thin method wrapper for `Gui, Font`

**args**:

> **name**: Options

> **desc**: Styling option string, see link for detail of what options are available.

> **type**: string

> **name**: FontName

> **desc**: The name of the font to apply.

> **type**: string

####Hide
**desc**: A thin method wrapper for `Gui, Hide`

####ListView
**desc**: Changes the default `ListView` to the specified hwnd. See the link for what changing the default `ListView` does.

**args**:

> **name**: hwnd

> **desc**: The hwnd of the `ListView` to set as the default.

> **type**: hwnd

**returns**:

> **desc**: The hwnd of the `ListView` that was previously the default.

> **type**: hwnd

####Margin
**desc**: A thin method wrapper for `Gui, Margin`

**args**:

> **name**: x

> **desc**: The horisontal margin of controls that are added to the GUI.

> **type**: string

> **name**: y

> **desc**: The vertical margin of controls that are added to the GUI.

> **type**: string

####Maximize
**desc**: A thin method wrapper for `Gui, Maximize`

####Menu
**desc**: A thin method wrapper for `Gui, Menu`

**args**:

> **name**: MenuName

> **desc**: The name of the menu to attach to the GUI menu bar. Menues are made using the `Menu` command, see link for details.

> **type**: string

####Minimize
**desc**: A thin method wrapper for `Gui, Minimize`

####MinSize
**desc**: Sets the minsize of the GUI, that is the size that the GUI can't be reduced beyond by drag resizing.

**args**:

> **name**: x

> **desc**: The minimal width of the GUI. If `""` the min width is left unchanged.

> **type**: string

> **name**: y

> **desc**: The minimal height of the GUI. If `""` the min height is left unchanged.

> **type**: string

####Options
**desc**: Applies styles and options to the GUI.

**args**:

> **name**: options

> **desc**: The ahk GUI style and option string to apply to the GUI. See link for supported styles and options.

> **type**: string

####RegisterBackground
**desc**: Registers a control as a background control, that is their z-order is lowered below any current and future controls.

**args**:

> **name**: ctrl

> **desc**: The `GridGUI.GuiControlClass` instance that will be registered.

> **type**: GridGUI.GuiControlClass

####RegisterDropTarget
**desc**: Registers a control as a file drag and drop target. Any registered control will have its callback called whenever files are dropped on the control.

**args**:

> **name**: ctrl

> **desc**: The `GridGUI.ControlClass` instance that will be registered.

> **type**: GridGUI.ControlClass

> **name**: Callback

> **desc**: The callback to call when files are dropped on the control.

> **type**: Func|BoundFunc

####RegisterForeground
**desc**: Registers a control to be redrawn after all other controls as well as their z-order is raised above any current and future controls.

**args**:

> **name**: ctrl

> **desc**: The `GridGUI.GuiControlClass` instance that will be registered.

> **type**: GridGUI.GuiControlClass

####Restore
**desc**: A thin method wrapper for `Gui, Restore`

####Show
**desc**: A thin method wrapper for `Gui, Show`

**args**:

> **name**: options

> **desc**: The options string describing how to show the GUI. See link for available options.

> **type**: string

> **default**: AutoSize

####Submit
**desc**: A thin method wrapper for `Gui, Submit`

**args**:

> **name**: NoHide

> **desc**: Whether or not to hide the GUI after submitting it.

> **type**: bool

####TreeView
**desc**: Changes the default `TreeView` to the specified hwnd. See the link for what changing the default `TreeView` does.

**args**:

> **name**: hwnd

> **desc**: The hwnd of the `TreeView` to set as the default.

> **type**: hwnd

**returns**:

> **desc**: The hwnd of the `TreeView` that was previously the default.

> **type**: hwnd
