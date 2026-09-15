function credits(engine)
    value = defineScenePart(engine, {{"Sigma", 1, 1}});

    drawScene(engine, value, value);

    pause(1);

    titleScreen(engine);
end