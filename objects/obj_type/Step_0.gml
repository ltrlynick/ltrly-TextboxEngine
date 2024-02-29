nextLine();

/////// TYPEWRITTER ///////

if (!done) //if its not done
{
	if (checkSymbol)
	{
		for(var i = 0; i < string_length(text[line]); i++)
		{
			checkFor(i,"/f");
			checkFor(i,"/s");
		}
		
		checkSymbol = 0;
	}
	
	else
	{
		if keyboard_check_pressed(ord("X"))
		{
			skip = true;	
		}
		
		if(!skip)
		{
			//increment it by char_spd while its less than the length of the text
			incrementCharCount();
    
		    // If there are any untyped letters so far, add them in
		    if (array_length(char) < floor(char_count)) 
			{
				addLetter();
		    }
		}
		else
		{
			var i = ceil(char_count);
			
			while(i <= string_length(text[line]))
			{
				var letter = string_copy(text[line], i, 1);
				var charWidth = string_width(letter);
				var charWidthDifferenceSpacing = 0 //experimentation
				
				if (floor(lastSpace) != floor(i - 1) && string_char_at(text[line], i - 1) == " ") //if theres an empty space
				{
					lastSpace = floor(i - 1); //lastSpace is the position where we found it
	
					var width = stringLength;
	
					for (var a = lastSpace + 1; a < string_length(text[line]); a++)
					{
					    if (string_copy(text[line], a, 1) == " ")
						{
					        break;
						}
		
					    width++;
		
					    if (width > lineWidth)
						{
						    space = space + 1;
						    stringLength = 0;
						    break;
						}
					}	
				}
				
				if((i-1) == -1)
				{
					i++;
					continue;	
				}
				
				char[i-1] = letter;
				charX[i-1] = charWidth * stringLength;
				charY[i-1] = space * ( (string_width("A") * 2) + charWidthDifferenceSpacing); //experimentation
				stringLength++;
				
				show_debug_message(i);
				i++;
			}
		
			char_count = string_length(text[line]);
			done = true;
		}
	}
}

if(keyboard_check(ord("R")))
{
	game_restart();	
}
