function customize(engine)
    cars = engine.data.availableCars;

    % Background sprite setup
    background = fillWithSpriteSet(engine, "Garage", [1, 1], [16, 9]);
    foreground = fillWithSpriteSet(engine, "Space", [1, 1], [16, 9]);

    foreground{length(foreground) + 1} = {"Back", 13, 9};
    
    % Car sprite setup (Locked & Unlocked)
    for index = 1:length(cars)
        xIndex = rem(index - 1, 3) + 1;
        yIndex = 1 + floor((index - 1) / 3);

        unlocked = isfield(engine.data.userData.UnlockedCars, cars{index});

        if unlocked
            foreground{length(foreground) + 1} = {cars{index}, xIndex * 5 - 3, yIndex * 3 - 1};
        else
            foreground{length(foreground) + 1} = {cars{index} + "Locked", xIndex * 5 - 3, yIndex * 3 - 1};
        end
    end

    % Scene drawing (only happens once to save time, as the screen here only changes when you enter)
    drawScene(engine, defineScenePart(engine, background), defineScenePart(engine, foreground));

    while true
        [y, x, button] = getMouseInput(engine);

        if button == 1
            % Grid position corresponding to around where a car would be
            % (1, 1) would be the red car from (2, 2) to (5, 3)
            xIndex = floor((x + 4) / 5);
            yIndex = floor((y + 2) / 3);
            
            if x >= 13 && y == 9
                titleScreen(engine);

                break
            % Determines whether or not the given car is on the correct
            % part of the grid / whether or not it's between the separation
            % lines
            elseif xIndex <= 3 && mod(x, 5) ~= 1 && mod(y, 3) ~= 1
                index = xIndex + (yIndex - 1) * 3;
    
                % Checks if the car exists and is unlocked
                if index <= length(cars) && any(cars{index}) && isfield(engine.data.userData.UnlockedCars, cars{index})
                    engine.data.userData.SelectedCar = cars{index};

                    saveData(engine);
                end
            end
        end
    end
end