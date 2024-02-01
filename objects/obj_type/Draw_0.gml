draw_sprite_ext(spr_textbox,0,tX-16,tY-20,7.6,2,0,c_white,1);

//////// RENDER CHARACTERS ///////
for (var i = 0; i < floor(char_count); i++) //render each character individually
{	
	var _float_y = 0;
	
	var _shakeAmplitude = .7;
	var _rx = 0;
    var _ry = 0
	
	if (letterComeDown[i] > 0)
	{
		letterComeDown[i] = lerp(letterComeDown[i],0,.2);
	}
	
	if (float[i] == 1)
	{
		floatAngle[i] += 0.2;
		_float_y = sin(floatAngle[i])*2;
	}
	
	letterOpacity[i] += 0.2;	
	
	if (shake[i] == 1)
	{
		_rx = random_range(-_shakeAmplitude, _shakeAmplitude);
		_ry = random_range(-_shakeAmplitude, _shakeAmplitude);
	}

    draw_text_ext_color(
        tX + charX[i] + _rx,
        tY + charY[i] - letterComeDown[i] + _float_y + _ry,
        char[i],
		100,100,
		c_white,c_white,c_white,c_white,
		letterOpacity[i]
    );
}