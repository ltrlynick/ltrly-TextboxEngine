// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initTextbox()
{
	tX = 50; //start position of X
	tY = 50; //start position of Y

	char = []; //this creates an empty array
	charX = [];
	charY = [];

	lineWidth = 45;
	lastSpace = 0;
	stringLength = 0;
	space = 0;

	char_count = 0;
	char_spd = 0.5;
	char_incr = char_spd;

	done = false;

	checkSymbol = 1;

	letterComeDown = [];
	letterOpacity = [];

	float = [];
	floatAngle = [];
	
	charShake = [];
	shake = [];
	
	recWidth = 0;
	recHeight = 0;
	
	fillUpCharEffectArrays();
}

function fillUpCharEffectArrays()
{
	for(var i = 0; i < string_length(text[line]); i++)
	{
		floatAngle[i] = 0;
		float[i] = 0;
		shake[i] = 0;
		letterComeDown[i] = 15;
		letterOpacity[i] = 0;
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
}

/// @param _iteration The iteration of the for loop
/// @param _symbol The symbol it searches for
function checkFor(_iteration, _symbol)
{
    var _check = string_copy(text[line],_iteration,2);
            
    if (_check != _symbol)
    {
        return;
    }
    
    text[line] = string_delete(text[line],_iteration,2);
        
    var floatFound = 0;
    var shakeFound = 0;
    
    for(var ii = _iteration-1; ii <= string_length(text[line]); ii++)
    {
        var _s = string_copy(text[line],ii,2);
        
        if (_s == _symbol)
        {
            text[line] = string_delete(text[line],ii,2);
            
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

function checkSpace()
{
	lastSpace = floor(char_count - 1); //lastSpace is the position where we found it
	
	var width = stringLength;
	
	for (var i = lastSpace + 1; i < string_length(text[line]); i++)
	{
	    if (string_copy(text[line], i, 1) == " ")
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
	
	if (char_count < string_length(text[line]))
	{
	    char_count += char_incr;
		
		//repurpose this part of the code
		
	    if (floor(lastSpace) != floor(char_count - 1) && string_char_at(text[line], char_count - 1) == " ") //if theres an empty space
	    {
	        checkSpace();
	    }
		
		
		if (string_copy(text[line], char_count, 1) == ".") //find a better way to do this man, come on, chop chop, ur an adult now, fix ur own problems
		{
			char_incr = 0;
			
			if(alarm[0] == -1)
			{
				alarm[0] = 30;	
			}	
		}
		else if (string_copy(text[line], char_count, 1) == ",")
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
	    char_count = string_length(text[line]); //at the end char is the same number as the length
	    done = true;
	}
}

function addLetter()
{
	var letter = string_copy(text[line], char_count, 1);
	var charWidth = string_width(letter);

	audio_play_sound(snd_type,0,0);
	audio_sound_pitch(snd_type,irandom_range(1,1.3));

	char[char_count - 1] = letter;
	charX[char_count - 1] = charWidth * stringLength;
	charY[char_count - 1] = space * 24;
	
	var tempRecWidth = string_width("A") * stringLength;
	
	if (tempRecWidth >= recWidth)
	{
		recWidth = tempRecWidth + string_width(".");
	}
	
	recHeight = lerp(recHeight,(space+1)*24,.5);
	
	stringLength++;	
}
