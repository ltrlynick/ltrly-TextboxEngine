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
		//increment it by char_spd while its less than the length of the text
		incrementCharCount();
    
	    // If there are any untyped letters so far, add them in
	    if (array_length(char) < floor(char_count)) 
		{
			addLetter();
	    }
	}
}