% Rowan V for team L

function saveData(engine)
    file = fopen("data/userData.json", 'W');

    if file < 0
        error("Unable to open file: %s", msg);
    end

    fwrite(file, jsonencode(engine.data.userData, "PrettyPrint", true));

    fclose(file);
end