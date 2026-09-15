% Rowan V for team L

classdef simplerGameEngine < simpleGameEngine
    properties
        data = struct()
        spriteSheetSize = []
        spriteSets = {}
        spriteSetNames = [""]
        windowSize = []
    end

    methods
        function obj = simplerGameEngine(windowSize, sprites_fname, sprite_height, sprite_width, zoom, background_color)
            obj = obj@simpleGameEngine(sprites_fname, sprite_height, sprite_width, zoom, background_color);

            obj.windowSize = [windowSize(2), windowSize(1)];

            [sprites_image, ~, ~] = imread(sprites_fname);
            
            sprites_size = size(sprites_image);
            sprite_row_max = (sprites_size(1)+1)/(sprite_height+1);
            sprite_col_max = (sprites_size(2)+1)/(sprite_width+1);

            obj.spriteSheetSize = [sprite_row_max, sprite_col_max];
        end

        function defineSpriteSet(obj, name, corner1, corner2)
            index = length(obj.spriteSets) + 1;

            obj.spriteSets{index} = [corner1, corner2];
            obj.spriteSetNames(index) = name;
        end

        function values = defineScenePart(obj, sprites)
            values = ones(obj.windowSize);

            for index = 1:length(sprites)
                sprite = sprites{index};
                spriteName = sprite{1};
                spriteX = sprite{2};
                spriteY = sprite{3};

                spriteSet = obj.spriteSets{obj.spriteSetNames == spriteName};

                for x = 0:spriteSet(3)-spriteSet(1)
                    for y = 0:spriteSet(4)-spriteSet(2)
                        coordinates = [spriteY + y, spriteX + x];
                        spriteData = [spriteSet(1) + x, spriteSet(2) + y - 1];
                        values(coordinates(1), coordinates(2)) = spriteData(1) + (spriteData(2) * obj.spriteSheetSize(2));
                    end
                end
            end
        end

        function values = fillWithSpriteSet(obj, sprite, corner1, corner2)
            values = {};

            spriteSet = obj.spriteSets{obj.spriteSetNames == sprite};
            spriteX = [spriteSet(1), spriteSet(3)];
            spriteXRange = spriteX(2) - spriteX(1) + 1;
            spriteY = [spriteSet(2), spriteSet(4)];
            spriteYRange = spriteY(2) - spriteY(1) + 1;

            for x = 0:spriteXRange:corner2(1)-corner1(1)
                for y = 0:spriteYRange:corner2(2)-corner1(2)
                    coordinates = corner1 + [x, y];
                    values{length(values) + 1} = {sprite, coordinates(1), coordinates(2)};
                end
            end
        end

        function values = drawText(~, text, x, y, prefix)
            values = {};
            offset = 0;

            if (ischar(text) == false)
                text = convertStringsToChars(text);
            end

            for index = 1:length(text)
                character = text(index);
                coordinates = [x + index - 1 - offset, y];

                if character ~= ":"
                    values{length(values) + 1} = {prefix + character, coordinates(1), coordinates(2)};
                else
                    offset = offset + 1;
                    values{length(values)}{1} = values{length(values)}{1} + ":";
                end
            end
        end
    end
end