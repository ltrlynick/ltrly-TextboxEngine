if (line < array_length(text)-1)
{
	if (keyboard_check_pressed(vk_space))
	{
		line += 1;
		
		char = []; //this creates an empty array
		charX = [];
		charY = [];

		lastSpace = 0;
		stringLength = 0;
		space = 0;

		char_count = 0;

		done = false;

		checkSymbol = 1;

		float = [];
		floatAngle = [];
	}
}

/////// TYPEWRITTER ///////
if (!done) //if its not done
{
	if (checkSymbol)
	{
		for(var i = 0; i < string_length(text[line]); i++)
		{
			floatAngle[i] = 0;
			
			var _check = string_copy(text[line],i,2);
			
			if (_check == "/f")
			{
				text[line] = string_delete(text[line],i,2);
		
				var floatFound = 0;
		
				for(var ii = i-1; ii <= string_length(text[line]); ii++)
				{
					var _s = string_copy(text[line],ii,2)
			
					if (_s == "/f")
					{
						text[line] = string_delete(text[line],ii,2);
						floatFound = 1;
					}
			
					if (floatFound == 1)
					{
						float[ii] = 0;	
					}
					else
					{
						float[ii-1] = 1;
					}
				}
			}
		}
		
		checkSymbol = 0;
	}
	
	else
	{
		//increment it by char_spd while its less than the length of the text
	    if (char_count < string_length(text[line]))
	    {
	        char_count += char_spd;
			
	        if (floor(lastSpace) != floor(char_count - 1) && string_char_at(text[line], char_count - 1) == " ") //if theres an empty space
	        {
	            lastSpace = floor(char_count - 1); //lastSpace is the position where we found it
            
	            var width = stringLength;
	            for (var i = lastSpace + 1; i < string_length(text[line]); i++) {
	                if (string_copy(text[line], i, 1) == " ")
	                    break;
	                width++;
	                if (width > lineWidth) {
	                    space = space + 1;
	                    stringLength = 0;
	                    break;
	                }
	            }
	        }
	    }
	    else
	    {
	        char_count = string_length(text[line]); //at the end char is the same number as the length
	        done = true;
	    }
    
	    if (char_count == ceil(char_count))
	        char_count = ceil(char_count);
    
	    // If there are any untyped letters so far, add them in
	    if (array_length(char) < floor(char_count)) 
		{
	        var letter = string_copy(text[line], char_count, 1);
	        show_debug_message(letter);
	        var charWidth = string_width(letter);

	        char[char_count - 1] = letter;
	        charX[char_count - 1] = charWidth * stringLength;
	        charY[char_count - 1] = space * 24;
        
	        stringLength++;
	    }
	}
}


	
//if (stringLength > lineWidth)
//{
//    space = space + 1;
//    stringLength = 0;
            
//    // Retroactively move the letters from the last space to now
//    for (var i = lastSpace; i < char_count; i++) {
//        charX[i] = charWidth * stringLength;
//        charY[i] = space * 12;
//        stringLength = stringLength + 1;
//    }
//}
        