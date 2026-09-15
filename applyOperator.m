% Rowan V for team L, meant for use by evaluate.m

function value = applyOperator(number1, operator, number2)
    if operator == 1
        value = number1 + number2;
    elseif operator == 2
        value = number1 - number2;
    elseif operator == 3
        value = number1 * number2;
    elseif operator == 4
        value = number1 / number2;
    end
end