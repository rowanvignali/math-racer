% Rowan V for team L, meant for use in titleScreen.m

function unitSelectOld(engine)
    grades = engine.data.units;
    pageMax = ceil(length(grades) / 3);

    page = 2;

    pageStart = page * 3 - 2;
    pageEnd = min(page * 3, length(grades));
    background = fillWithSpriteSet(engine, "Space", [1, 1], [16, 9]);
    foreground = background;

    for grade = pageStart:pageEnd
        index = grade - page * 3 + 3;
        units = grades{grade};
        unitNames = fieldnames(units);

        background{length(background) + 1} = {"Grade Sign", 1, index * 3 - 2};

        foreground{length(foreground) + 1} = {"White" + grade, 2, index * 3 - 1};
        foreground{length(foreground) + 1} = {getNumberSuffix(grade), 3, index * 3 - 2};

        for unitIndex = 1:length(unitNames)
            unitName = unitNames{unitIndex};
            unit = units.(unitName);

            foreground{length(foreground) + 1} = {"Level", 5 + 3 * unitIndex, index * 3 - 1};
            foreground{length(foreground) + 1} = {"White" + unit.Level, 6 + 3 * unitIndex, index * 3 - 1};

            convertedDifficulty = engine.data.difficulties(unit.Difficulty);

            for operatorIndex = 1:min(3, length(unit.Operators))
                operator = unit.Operators{operatorIndex};

                foreground{length(foreground) + 1} = {operator + "Sign", 3 + 3 * unitIndex + operatorIndex, index * 3 - 1};
            end

            for lightIndex = 1:3
                % background{length(background) + 1} = {"Traffic Light", 4 + 3 * unitIndex, index * 3 - 3 + lightIndex};
                background{length(background) + 1} = {"Traffic Light", 3 + 3 * unitIndex + lightIndex, index * 3 - 2};
                foreground{length(foreground) + 1} = {convertedDifficulty + " Light", 3 + 3 * unitIndex + lightIndex, index * 3 - 2};
            end
        end
    end
    
    drawScene(engine, defineScenePart(engine, background), defineScenePart(engine, foreground));
end