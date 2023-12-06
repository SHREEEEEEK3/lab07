#!/user/bin/lua5.3

lgi = require('lgi')
gtk = lgi.require("Gtk", "3.0")
cairo = lgi.cairo

gtk.init()

wnd = gtk.Window 
{
	title = 'g21_tihonov c',
	default_width = 410,
	default_height = 470,
	on_delete_event = gtk.main.quit,
	gtk.Box 
	{
		border_width = 10,
		spacing = 10,
		orientation = 'VERTICAL',
		gtk.DrawingArea 
		{
			expand = true,
			id = 'canvas',
			width = 400,
			height = 400
		},
		gtk.Box 
		{
			orientation = 'HORIZONTAL',
			spacing = 10,
			gtk.Button 
			{
				id = 'btn1',
				label = 'NEXT'
			},
			gtk.Button 
			{
				id = 'btn2',
				label = 'PERV'
			}
		}	
	}	
}

cnv = wnd.child.canvas
btn1 = wnd.child.btn1
btn2 = wnd.child.btn2

a = 35
b = 35
c = 35

function cnv:on_draw(cr)
	cr:set_source_rgb(1, 1, 1)
	cr:paint()	
	
	for x = 1, 25 do
		for y = 1, 25 do
			for z = 1, 25 do
				cr:move_to(x*15, y*15)
				cr:rel_line_to(5, -10)
				cr:rel_line_to(5, 10)
				cr:rel_line_to(-10, 0)
				cr:close_path()
				cr:set_source_rgb(x/a, y/b, z/c)
				cr:fill()
			end
		end
	end
	
	return true
end

function wnd:on_destroy()
	gtk.main_quit()
end

function btn1:on_clicked()
 	a = a * 1
	b = b - 1
	c = c + 1
	cnv:queue_draw()
end

function btn2:on_clicked()
 	a = a / 1
	b = b + 1
	c = c - 1
	cnv:queue_draw()
end

wnd:show_all()

gtk.main()
