# Glorious dotfiles

## Intro
This is a small fork of this repo => https://github.com/manilarome/the-glorious-dotfiles
But it's only containing the awesome theme code.

My goal was to understand and a play a little bit with this theme.
I did some refactoring on the code and I also wanted it to be easier to customize.

## Configuration

There is only file to edit : configuration/apps.lua !

Which theme do you want to use "linear, floppy, gnawesome"
For the moment only gnawesome theme is fully working.

```lua
	theme = "gnawesome"
```

After choosing a theme you may want to cutomize the panels.
For each panel the configuration will look the same.
Here is a an exemple for the dock panel :
```lua
	dock = {
    	enabled = true, -- Do you want this enable this panel or not ?
    	position = 'bottom', -- (left, bottom,top,right) Do you want the panel to be on the left side ? On the bottom ?
		height = 60, -- Height of the dock
		margin = 5, -- TODO Not implemented yet
    
    	-- Here you can choose the widgets you want inside your panel
		widgets = { { 'search-apps', 'separator', 'tag-list', 'xdg-folders', 7 }, { 'systray', 'tray-toggler', 'wifi', 'battery', 'clock', 'layout-box', 7 }, { 'xdg-folders.trash' } }
	},


```

## Pictures

![Example](doc_img/20200520_160851.png)

![Example1](doc_img/20200520_161728.png)