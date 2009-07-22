module codecs.image.codec;

import graphics.bitmap;

import core.string;
import core.stream;

import codecs.codec;

struct ImageFrameDescription {
	uint time;	//time till the display of the next image
	uint xoffset;	//the x offset of the image within the main image
	uint yoffset; //the y offset of the image within the main image
	uint clearFirst; //whether or not to clear the image prior to drawing next frame
	uint clearColor; //the color to use when clearing
}

class ImageCodec : Codec {
public:
	StreamData decode(Stream stream, ref Bitmap view) {
		return StreamData.Invalid;
	}

	override String name() {
		return new String("Unknown Image Codec");
	}
}
