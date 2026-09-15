function play(engine, grade, unitName)
    unit = engine.data.units{grade}.(unitName);

    backgroundName = unit.Background;

    backgroundTemplate = fillWithSpriteSet(engine, backgroundName, [1, 1], [16, 9]);
    foregroundTemplate = fillWithSpriteSet(engine, "Space", [1, 1], [16, 9]);

    pointsScored = 0;
    pointsRequired = getQuestionCount(unit);
    questionsFailed = 0;
    sigmas = 0;

    tic;

    while pointsScored < pointsRequired && pointsScored >= 0
        expression = generateExpression(unit.Operators, randi(unit.OperatorCount), unit.NumberRange, unit.AlwaysPositive);
        playerInput = "";
    
        while true
            car = engine.data.userData.SelectedCar;

            if backgroundName == "Abyss"
                car = car + "Locked";
            end

            foreground = [foregroundTemplate, drawText(engine, expression + "=" + playerInput, 2, 2, "White")];
            foreground{length(foreground) + 1} = {car, floor(pointsScored * 12 / (pointsRequired - 1)) + 1, 7};
        
            drawScene(engine, defineScenePart(engine, backgroundTemplate), defineScenePart(engine, foreground));
    
            input = getKeyboardInput(engine);

            if input == "return"
                break
            elseif input == "backspace"
                if ~isempty(playerInput{1})
                    playerInput{1}(end:end) = [];
                end
            elseif ~isnan(str2double(input)) && length(char(expression + "=" + playerInput)) < 14
                playerInput = playerInput + input;
            elseif input == "hyphen"
                playerInput = playerInput + "-";
            elseif input == "escape"
                pointsScored = -1;

                break
            end
        end
    
        if evaluate(expression) == str2double(playerInput)
            pointsScored = pointsScored + 1;
        else
            questionsFailed = questionsFailed + 1;

            if playerInput == "67" && randi(engine.data.sigma) == 1
                value = defineScenePart(engine, {{"Sigma", 1, 1}});

                drawScene(engine, value, value);
            
                pause(1);

                sigmas = sigmas + 1;
            end
        end
    end

    if pointsScored == pointsRequired
        elapsedTime = floor(toc) - sigmas;
        points = max(0, pointsRequired - questionsFailed);
        perfect = questionsFailed == 0;
    
        gradeData = engine.data.userData.LevelData{grade};
    
        levelData = struct("Points", points, "Time", elapsedTime, "Perfect", perfect);
    
        if isfield(gradeData, unitName)
            levelData = gradeData.(unitName);
    
            levelData.Points = max(levelData.Points, points);
            levelData.Time = min(levelData.Time, elapsedTime);
            levelData.Perfect = max(levelData.Perfect, perfect);
        end
    
        engine.data.userData.LevelData{grade}.(unitName) = levelData;
        engine.data.userData.LastBackground = backgroundName;
    
        if perfect && getPerfectCount(engine, grade) == 3
            reward = engine.data.rewards(grade).Prize;
            
            engine.data.userData.UnlockedCars.(reward) = true;
        end
    
        saveData(engine);
    
        background = fillWithSpriteSet(engine, backgroundName + "Dark", [1, 1], [16, 9]);
    
        elapsedTime = min(elapsedTime, 5999);
        
        time = sprintf('%01d:%02d', floor(elapsedTime / 60), mod(elapsedTime, 60));
    
        if perfect
            foreground = {{"RacePerfected", 1, 1}, {"RaceStats", 1, 5}};
        else
            foreground = {{"RaceFinished", 1, 1}, {"RaceStats", 1, 5}};
        end
    
        foreground = [foreground, drawText(engine, time, 9, 5, "SmallWhite"), drawText(engine, points + "/" + pointsRequired, 9, 6, "SmallWhite")];
    
        drawScene(engine, defineScenePart(engine, background), defineScenePart(engine, foreground));
    
        [~, ~, ~] = getMouseInput(engine);
    end

    titleScreen(engine);
end