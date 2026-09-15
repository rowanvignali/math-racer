% Rowan V for team L

function expression = generateExpression(allowedOperators, operatorCount, numberRange, alwaysPositive)
    operators = allowedOperators(randi(length(allowedOperators), 1, operatorCount));
    numbers = zeros(operatorCount + 1);
    numbers(length(numbers)) = randi(numberRange);

    multiplicationLimit = floor(numberRange.^(1/(1 + length(operators))));

    for index = operatorCount:-1:1
        operator = operators(index);

        if operator == "+"
            numbers(index) = randi(numberRange);
        elseif operator == "-"
            if alwaysPositive
                numbers(index) = randi([numbers(index + 1), numberRange(2)]);
            else
                numbers(index) = randi(numberRange);
            end
        elseif operator == "*"
            if numbers(index + 1) > multiplicationLimit(2)
                numbers(index + 1) = randi(multiplicationLimit);
            end

            numbers(index) = randi(multiplicationLimit);
        elseif operator == "/"
            numbers(index + 1) = randi([1, floor(sqrt(numberRange(2)))]);
            numbers(index) = numbers(index + 1) * randi([1, floor(numberRange(2) / numbers(index + 1))]);
        end
    end

    expression = string(numbers(1));

    for index = 1:operatorCount
        expression = expression + "" + operators(index) + "" + numbers(index + 1);
    end
end