% Rowan V for team L, meant for use in main.m

function titleScreen(engine)
    background = {{engine.data.userData.LastBackground, 1, 1}};
    foreground = [fillWithSpriteSet(engine, "Space", [1, 1], [16, 9]), {{"TitleText", 1, 1}, {"Play", 7, 5}, {"Info", 2, 5}, {"Edit", 12, 5}}];

    drawScene(engine, defineScenePart(engine, background), defineScenePart(engine, foreground))

    %displayedMessage = text(0, 0, "");

    %if engine.data.parallelProcessing == -1
        %displayedMessage = text(0, 0, "Note: Parallel Processing Toolbox addon is not installed; some features will not be fully enabled.", "VerticalAlignment","top");
    %elseif engine.data.parallelProcessing == 0
        %displayedMessage = text(0, 0, "Note: Parallel Processing Toolbox addon is disabled; some features will not be fully enabled.");
    %end

    while true
        [y, x, button] = getMouseInput(engine);

        if button == 1 && y >= 5 && y <= 6
            if (x >= 7 && x <= 10)
                outcome = "Play";

                break
            elseif (x >= 2 && x <= 5)
                outcome = "Info";

                break
            elseif (x >= 12 && x <= 15)
                outcome = "Edit";

                break
            end
        end
    end

    %delete(displayedMessage);

    if outcome == "Play"
        unitSelect(engine);
    elseif outcome == "Info"
        credits(engine);
    elseif outcome == "Edit"
        customize(engine);
    end
end