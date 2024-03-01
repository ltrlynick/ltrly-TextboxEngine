ImGui.SetNextWindowSize(200,200, ImGuiCond.Once);
ImGui.Begin("Test Window");

obj_type.tX = ImGui.SliderInt("Text X",obj_type.tX,0,room_width);
obj_type.tY = ImGui.SliderInt("Text Y",obj_type.tY,0,room_height);
obj_type.char_spd = ImGui.SliderFloat("Typing Speed", obj_type.char_spd,0,1);
obj_type.letterComeDownY = ImGui.SliderFloat("Letter Come Down Level",obj_type.letterComeDownY,0,room_height);
obj_type.letterOpacityLevel = ImGui.SliderFloat("Letter Starting Opacity Level",obj_type.letterOpacityLevel,0,1);

ImGui.Separator();

if(ImGui.Button("Play Text Again"))
{	
	with(obj_type)
	{
		initTextbox();
	}
}

ImGui.Separator();

if(ImGui.Button("Previous"))
{
	if ( (obj_type.line-1) < array_length(obj_type.text) )
	{
		obj_type.line = array_length(obj_type.text)-1;
	}
	else
	{
		obj_type.line -= 1;
	}
	
	with(obj_type)
	{
	
		initTextbox();
	}
}

ImGui.SameLine();


if(ImGui.Button("Next"))
{
	if ( (obj_type.line+1) > array_length(obj_type.text)-1 )
	{
		obj_type.line = 0;
	}
	else
	{
		obj_type.line += 1;
	}
	
	with(obj_type)
	{
		initTextbox();
	}
}

ImGui.Separator();

ImGui.End();