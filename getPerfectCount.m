% Rowan V for team L

function perfect = getPerfectCount(engine, grade)
    perfect = 0;

    grade = engine.data.userData.LevelData{grade};
    unitNames = fieldnames(grade);

    for unitIndex = 1:length(unitNames)
        perfect = perfect + grade.(unitNames{unitIndex}).Perfect;
    end
end