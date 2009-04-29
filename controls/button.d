module controls.button;

import core.control;
import core.color;
import core.definitions;
import core.string;
import core.graphics;

import core.windowedcontrol;

import graphics.brush;

enum ButtonEvent : uint
{
	Pressed,
	Released,
	Selected,
}

template ControlPrintCSTRList()
{
	const char[] ControlPrintCSTRList = `
	this(int x, int y, int width, int height, String value)
	{
		super(x,y,width,height,value);
	}
	this(int x, int y, int width, int height, StringLiteral value)
	{
		super(x,y,width,height,value);
	}
`;
}

// Section: Controls

// Description: This control will provide a simple push button.
class Button : WindowedControl
{
	// support Events
	mixin(ControlAddDelegateSupport!("Button", "ButtonEvent"));

	// Description: This will create a button with the specified dimensions and text.
	this(int x, int y, int width, int height, String value, ControlCallback callback = null)
	{
		super(x,y,width,height);
		_value = new String(value);

		setDelegate(callback);
	}

	// Description: This will create a button with the specified dimensions and text.
	this(int x, int y, int width, int height, StringLiteral value, ControlCallback callback = null)
	{
		super(x,y,width,height);
		_value = new String(value);

		setDelegate(callback);
	}

	override void OnAdd()
	{
		Color c;
		c.setRGB(0xc8, 0x00, 0x00);

		_brsh = new Brush(c);
		_pen = new Pen(Color.Black);
		_font = new Font(FontSans, 8, 400, false, false, false);

		c.setRGBA(0xc8, 0x00, 0x80, 0x40);
		_brsh.setColor(c);
	}

	override void OnDraw(ref Graphics g)
	{
		g.setBrush(_brsh);
		g.setPen(_pen);

		g.drawRect(_x, _y, _r, _b);

		// Draw the text
		Size sz;

		g.setFont(_font);
		g.measureText(_value, sz);

		int x, y;

		x = _x + ((_width - sz.x)/2);
		y = _y + ((_height - sz.y)/2);

		g.setTextModeTransparent();

		g.setTextColor(Color.Red);

		g.drawText(x, y, _value);
	}

	override bool OnPrimaryMouseDown(ref Mouse mouseProps)
	{
		RequestCapture();

		FireEvent(ButtonEvent.Pressed);

		return true;
	}

	override bool OnPrimaryMouseUp(ref Mouse mouseProps)
	{
		if (_hovered)
		{
			FireEvent(ButtonEvent.Selected);
		}

		FireEvent(ButtonEvent.Released);

		RequestRelease();

		return true;
	}

	override bool OnMouseEnter()
	{
		_brsh.setColor(Color.White);

		return true;
	}

	override bool OnMouseLeave()
	{
		Color c;
		c.setRGB(0xc8, 0xc8, 0xc8);

		_brsh.setColor(c);

		return true;
	}

	override bool OnKeyDown(uint keyCode)
	{
		return false;
	}

	void setText(String newTitle)
	{
		_value = new String(newTitle);
	}

	void setText(StringLiteral newTitle)
	{
		_value = new String(newTitle);
	}

	String getText()
	{
		return _value;
	}

protected:
	String _value;

private:

	Brush _brsh;
	Pen _pen;

	Font _font;
}
