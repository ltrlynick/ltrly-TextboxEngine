nextLine();

/////// TYPEWRITTER ///////

if (!done) //if its not done
{
	if (checkSymbol)
	{
		for(var i = 0; i < string_length(subString); i++) //FIXIT when skipping, effects kinda break
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
			//I CANT BE BOTHERED TO PUT THIS IN A FUNCTION RN
			//deal w the nesting im too tired for this rn
			
			//code here is just slightly modified version of functions
			//I use for incrementCharCount() and addLetter();
			
			//I am planning to modify my functions so I wont have to do all this, but
			//for now deal with it.
			
			var i = ceil(char_count); 
			//typewriter on by default, as soon as the skip is activated,
			//make the iterator be that character position we were at
			
			while(i <= string_length(subString)) //iterator here is our current char count
			{
				var letter = string_copy(subString, i, 1);
				var charWidth = string_width(letter);
				var charWidthDifferenceSpacing = 0 //experimentation
				
				if (floor(lastSpace) != floor(i - 1) && string_char_at(subString, i - 1) == " ") //if theres an empty space
				{
					checkSpace(i);
				}
				
				if((i-1) == -1) //in case the player activates skip in the 0 character
				{
					i++;
					continue;	
				}
				
				if (array_length(char) < floor(i)) 
				{
					char[i-1] = letter;
					charX[i-1] = charWidth * stringLength;
					charY[i-1] = space * ( (string_width("A") * 2) + charWidthDifferenceSpacing); //charWidthDifferenceSpacing experimentation
				}
				
				// ------ FLOAT TEXT FIX WHEN SKIP ------ // 
				// when ur home tomorrow try to understand why this works LOL
				for (var b = 0; b < floor(i); b++)
				{
					if (float[b] == 1)
					{
						floatAngle[b] += 0.2;
					}
				}
				
				stringLength++;
				i++;
			}
		
			char_count = string_length(subString);
			
			done = true;
		}
	}
}

if(keyboard_check(ord("R")))
{
	game_restart();	
}
