% Rowan V for team L, meant for use in titleScreen.m

function unitSelect(engine)
    grades = engine.data.units;
    grade = 1;

    backgroundTemplate = fillWithSpriteSet(engine, "Space", [1, 1], [16, 9]);
    foregroundTemplate = backgroundTemplate;

    backgroundTemplate{length(backgroundTemplate) + 1} = {"Grade Sign", 1, 1};

    foregroundTemplate{length(foregroundTemplate) + 1} = {"UnitSelectLeft", 13, 1};
    foregroundTemplate{length(foregroundTemplate) + 1} = {"UnitSelectRight", 15, 1};
    foregroundTemplate{length(foregroundTemplate) + 1} = {"Back", 13, 3};

    while true
        background = backgroundTemplate;
        foreground = foregroundTemplate;

        if grade == 1
            foreground{length(foreground) + 1} = {"UnitSelectLeftInactive", 13, 1};
        end

        if grade == length(grades)
            foreground{length(foreground) + 1} = {"UnitSelectRightInactive", 15, 1};
        end
    
        foreground{length(foreground) + 1} = {"White" + grade, 2, 2};
        foreground{length(foreground) + 1} = {getNumberSuffix(grade), 3, 1};
    
        units = grades{grade};
        unitNames = fieldnames(units);
    
        prize = engine.data.rewards(grade);
    
        background{length(background) + 1} = {prize.Background + "Prize", 7, 1};
        foreground{length(foreground) + 1} = {prize.Prize, 8, 1};
    
        perfectCount = getPerfectCount(engine, grade);
    
        foreground = [foreground, drawText(engine, "P:" + perfectCount + "/3", 8, 3, "SmallWhite")];
    
        for unitIndex = 0:(length(unitNames) - 1)
            unitName = unitNames{unitIndex + 1};
            unit = units.(unitName);
            
            background{length(background) + 1} = {unit.Background + "Preview", 1, 4 + 2 * unitIndex};
    
            convertedDifficulty = engine.data.difficulties(unit.Difficulty);
    
            background{length(background) + 1} = {"Traffic Light", 1, 4 + 2 * unitIndex};
            foreground{length(foreground) + 1} = {convertedDifficulty + " Light", 1, 4 + 2 * unitIndex};
    
            for operatorIndex = 1:length(unit.Operators)
                operator = unit.Operators{operatorIndex};
    
                foreground{length(foreground) + 1} = {operator + "Sign", 1 + operatorIndex, 4 + 2 * unitIndex};
                foreground{length(foreground) + 1} = {"Sign Bottom", 1 + operatorIndex, 5 + 2 * unitIndex};
            end

            foreground{length(foreground) + 1} = {"Level", 6, 4 + 2 * unitIndex};
            foreground{length(foreground) + 1} = {"White" + unit.Level, 6, 5 + 2 * unitIndex};
    
            foreground{length(foreground) + 1} = {"Personal Best", 9, 4 + 2 * unitIndex};
    
            gradeData = engine.data.userData.LevelData{grade};
            points = 0;
            personalBest = "NA";
            checkType = 0;
    
            if isfield(gradeData, unitName)
                savedData = gradeData.(unitName);
    
                time = min(savedData.Time, 5999);
    
                personalBest = sprintf('%01d:%02d', floor(time / 60), mod(time, 60));
    
                points = savedData.Points;
    
                checkType = savedData.Perfect + 1;
            end
    
            questions = points + "/" + getQuestionCount(unit);
    
            foreground{length(foreground) + 1} = {"Check" + checkType, 7, 4 + 2 * unitIndex};
            background{length(background) + 1} = {"Check Slot", 7, 4 + 2 * unitIndex};
    
            foreground = [foreground, drawText(engine, personalBest, 11, 4 + 2 * unitIndex, "SmallWhite"), drawText(engine, questions, 11, 5 + 2 * unitIndex, "SmallWhite")];
        end
    
        drawScene(engine, defineScenePart(engine, background), defineScenePart(engine, foreground));

        [y, x, button] = getMouseInput(engine);

        if button == 1
            unit = floor((y - 2) / 2);

            if unit > 0
                play(engine, grade, unitNames{unit})

                break
            elseif y <= 2 && x >= 13
                if x >= 15
                    if grade < length(grades)
                        grade = grade + 1;
                    end
                else
                    if grade > 1
                        grade = grade - 1;
                    end
                end
            elseif y == 3 && x >= 13
                titleScreen(engine)
                
                break
            end
        end
    end
end