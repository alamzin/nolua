--lua port of noweb

--copyright


InputFile = "C:\\Users\\macamzin\\Documents\\GitHub\\nolua\\noluanolua.lua"
OutputFile = "C:\\Users\\macamzin\\Documents\\GitHub\\nolua\\noluaparsed.lua"


SourceCodeDefinitions = {}

CurrentSection = "DefaultSection"

for line in io.lines(InputFile) do
	if string.sub(line,1,2) == "--" and string.sub(line,-1) == "=" then
		CurrentSection = string.sub (line,3,-2)
		print ("Filling section: "..CurrentSection)
	elseif line == "--Конец--" or line == "--End--" then
		CurrentSection = "DefaultSection"
	elseif line then
		if SourceCodeDefinitions[CurrentSection] == nil then SourceCodeDefinitions[CurrentSection]="" end
		SourceCodeDefinitions[CurrentSection] = SourceCodeDefinitions[CurrentSection].."\n"..line
	end
end

SourceCode = ""

for line in io.lines(InputFile) do
	if string.sub(line,1,2) == "--" and string.sub(line,-2) == "--" then
		Section = string.sub (line,3, - 3)
		if SourceCodeDefinitions[Section] == nil then SourceCodeDefinitions[Section]="" end
		SourceCode = SourceCode..SourceCodeDefinitions[Section]
	else
		--SourceCode = SourceCode.."\n"..line
	end
end

print ("OUTPUT::::::")

local file = io.open(OutputFile, "w")
file:write (SourceCode)
