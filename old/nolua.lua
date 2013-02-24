
--[[noweb-like script for lua
nolua разработан Александром Амзиным февральским вечером 2013 года]]--
InputFile = "C:\\Users\\macamzin\\Documents\\GitHub\\nolua\\nolua"
OutputFile = "C:\\Users\\macamzin\\Documents\\GitHub\\nolua\\noluanew.lua"
SourceCodeDefinitions = {}
CurrentSection = "DefaultSection" -- в DefaultSection сваливается документация без определений, но с вызовами этих определений. По уму можно было бы просто пройтись по DefaultSection и вычистить оттуда болтовню, оставив лишь определения. Но второй проход по файлу нагляднее. 

for line in io.lines(InputFile) do
	if string.sub(line,1,2) == "--" and string.sub(line,-1) == "=" then -- Ищем определение
		CurrentSection = string.sub (line,3,-2)
		print ("Filling section: "..CurrentSection) -- Сообщаем, если нашли
	elseif line == "--Конец--" or line == "--End--" then -- Ищем конец определения
		CurrentSection = "DefaultSection"
	elseif line then -- Не забываем положить очередную строчку в соответствующую секцию
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
		--SourceCode = SourceCode.."\n"..line -- нам абсолютно не нужно перетаскивать всю документацию и бесполезные определения
	end
end

SourceCode = SourceCode.."\n" -- добавляем пустую строчку в конце файла

local file = io.open(OutputFile, "w")
file:write (SourceCode)