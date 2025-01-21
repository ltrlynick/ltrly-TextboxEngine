// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initTextbox()
{
	subString = text[line];
	
	char = []; //this creates an empty array
	charX = [];
	charY = [];

	lineWidth = 34;
	// move lineWidth for character icon space
	lastSpace = 0;
	stringLength = 0;
	space = 0;

	char_count = 0;
	char_incr = char_spd;

	done = false;
	skip = false;

	checkSymbol = 1;

	letterComeDown = [];
	letterOpacity = [];

	float = [];
	floatAngle = [];
	
	charShake = [];
	shake = [];
	
	font_xScale = 1; //experimentation lol
	font_yScale = 1;
	
	recWidth = 0;
	recHeight = 0;
	
	fillUpCharEffectArrays();
}

function fillUpCharEffectArrays()
{
	for(var i = 0; i < string_length(subString); i++) //fill up arrays so that they are ready
	{
		floatAngle[i] = 0;
		float[i] = 0;
		shake[i] = 0;
		letterComeDown[i] = letterComeDownY;
		letterOpacity[i] = letterOpacityLevel;
	}
}

function nextLine()
{
	if (line < array_length(text)-1)
	{
		if (keyboard_check_pressed(vk_space))
		{
			line += 1;
			initTextbox();
		}
	}
	else
	{
		if (keyboard_check_pressed(vk_space))
		{
			line = 0; //im looping the text rn for testing purposes
			initTextbox();
		}
	}
}

/// @param _iteration The iteration of the for loop
/// @param _symbol The symbol it searches for
function checkFor(_iteration, _symbol)
{
    var _check = string_copy(subString,_iteration,2);
            
    if (_check != _symbol)
    {
        return;
    }
    
    subString = string_delete(subString,_iteration,2);
        
    var floatFound = 0;
    var shakeFound = 0;
    
    for(var ii = _iteration-1; ii <= string_length(subString); ii++)
    {
        var _s = string_copy(subString,ii,2);
        
        if (_s == _symbol)
        {
            subString = string_delete(subString,ii,2);
            
            floatFound = effectSymbolFound(_symbol);
            shakeFound = effectSymbolFound(_symbol);
        }

        findWhereSymbolEnds("/f", _symbol, floatFound, float, ii);
        findWhereSymbolEnds("/s", _symbol, shakeFound, shake, ii);
    }
}

function effectSymbolFound(_symbol)
{
    switch(_symbol)
    {
        case "/f": return 1; break;
        case "/s": return 1; break;
    }
}

/// @param _symbolCheck		The symbol we are gonna check
/// @param _symbol			The symbol that the code is currently looking for
/// @param _effectFound		The effectFound boolean check
/// @param _effectArray		The effectFound array of the effect
/// @param _iterator		The "i" of the for loop
function findWhereSymbolEnds(_symbolCheck, _symbol, _effectFound, _effectFoundArray, _iterator)
{
	if(_symbol == _symbolCheck)
	{
	    if (_effectFound == 1)
	    {
	        _effectFoundArray[_iterator] = 0;
	    }
    
	    else
	    {
	        _effectFoundArray[_iterator-1] = 1;
	    }
	}
}

function checkSpace(_currentChar)
{
	lastSpace = floor(_currentChar - 1); //lastSpace is the position where we found it
	
	var width = stringLength;
	
	for (var _iterator = lastSpace + 1; _iterator < string_length(subString); _iterator++)
	{
	    if (string_copy(subString, _iterator, 1) == " ")
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

function incrementCharCount()
{
	if (char_count == ceil(char_count))
		char_count = ceil(char_count);
	
	if (char_count < string_length(subString))
	{
		char_count += char_incr;
		
		//repurpose this part of the code
		
	    if (floor(lastSpace) != floor(char_count - 1) && string_char_at(subString, char_count - 1) == " ") //if theres an empty space
	    {
	        checkSpace(char_count);
	    }
		
		
		if (string_copy(subString, char_count, 1) == ".") //find a better way to do this man, come on, chop chop, ur an adult now, fix ur own problems
		{
			char_incr = 0;
			
			if(alarm[0] == -1)
			{
				alarm[0] = 30;	
			}	
		}
		else if (string_copy(subString, char_count, 1) == ",")
		{
			char_incr = 0;
			
			if(alarm[0] == -1)
			{
				alarm[0] = 15;	
			}	
		}
		else
		{
			char_incr = char_spd;
		}
		
	}
	else
	{
	    char_count = string_length(subString); //at the end char is the same number as the length
	    done = true;
	}
}

function addLetter()
{
	var letter = string_copy(subString, char_count, 1);
	var charWidth = string_width(letter);
	
	var charWidthDifferenceSpacing = 0 //experimentation

	if( ceil(char_count) % 2 == 0)
	{
		audio_play_sound(snd_type,0,0);
		audio_sound_pitch(snd_type,random_range(1,1.2));
	}

	if (font_yScale != 1) { charWidthDifferenceSpacing = (font_yScale)*3;} //experimentation
	else { charWidthDifferenceSpacing = 0;} //experimentation
	
	char[char_count - 1] = letter;
	charX[char_count - 1] = charWidth * stringLength;
	charY[char_count - 1] = space * ( (string_width("A") * 2) + charWidthDifferenceSpacing); //experimentation
	stringLength++;
}
