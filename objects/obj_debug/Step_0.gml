ImGui.SetNextWindowSize(200,200, ImGuiCond.Once);
ImGui.Begin("Test Window");

obj_type.tX = ImGui.SliderInt("Text X",obj_type.tX,0,room_width);
obj_type.tY = ImGui.SliderInt("Text Y",obj_type.tY,0,room_height);
obj_type.char_spd = ImGui.SliderFloat("Typing Speed", obj_type.char_spd,0,1);

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
	obj_type.line -= 1;
	
	with(obj_type)
	{
	
		initTextbox();
	}
}

ImGui.SameLine();


if(ImGui.Button("Next"))
{
	obj_type.line += 1;
	
	with(obj_type)
	{
		initTextbox();
	}
}

ImGui.Separator();

show_debug_message(obj_type.float)

ImGui.End();