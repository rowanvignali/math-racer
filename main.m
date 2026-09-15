% Rowan V for team L

clc
clear

% Engine Definition

engine = simplerGameEngine([16, 9], "assets/SpriteSheet.png", 8, 8, 2, [50, 50, 50]);

% Sprite Definitions

spriteDefinitions = jsondecode(fileread("assets/spriteIndex.json"));

for index = 1:length(spriteDefinitions)
    sprite = spriteDefinitions{index};

    defineSpriteSet(engine, sprite{1}, sprite{2}, sprite{3});
end

% Data Definitions

engine.data.availableCars = jsondecode(fileread("data/availableCars.json"));
engine.data.difficulties = ["Green", "Yellow", "Red"];
engine.data.rewards = jsondecode(fileread("data/rewards.json"));
engine.data.units = jsondecode(fileread("data/units.json"));
engine.data.userData = jsondecode(fileread("data/userData.json"));

% INCREDIBLY IMPORTANT, DO NOT TOUCH

engine.data.sigma = 67;

% Parallel Processing Setup
% NOTE: I didn't end up using this, mainly because it was annoying to
% implement, but I figured I'd keep the setup here.

%installedAddons = matlab.addons.installedAddons();
%parallelProcessingIndex = find(strcmp(installedAddons.Name, "Parallel Computing Toolbox"));
%parallelProcessingInstalled = ~isempty(parallelProcessingIndex);
%parallelProcessingValue = -1;

%if parallelProcessingInstalled
    %parallelProcessingValue = installedAddons.Enabled(parallelProcessingIndex);
%end

%engine.data.parallelProcessing = parallelProcessingValue;

% Begin Loop

titleScreen(engine)