% RESETS DATA, DOES NOT SAVE ANYWHERE

file = fopen("userData.json", 'W');

if file < 0
    error("Unable to open file: %s", msg);
end

fwrite(file, fileread("data/blankUserData.json"));

fclose(file);