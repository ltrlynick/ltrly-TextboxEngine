//////// RENDER CHARACTERS ///////
for (var i = 0; i < floor(char_count); i++) //render each character individually
{	
	var _float_y = 0;
	
	if (float[i] == 1)
	{
		floatAngle[i] += 0.2;
		_float_y = sin(floatAngle[i])*2;
	}
	
    draw_text(
        tX + charX[i],
        tY + charY[i]+_float_y,
        char[i]
    );
}