% Rowan V for Team L

% WE LOVE THE SHUNTING YARD ALGORITHM!!!!!!!!!!!!!!!!

function answer = evaluate(expression)
    operators = ['+', '-', '*', '/'];
    operatorPrecedence = [1, 1, 2, 2];
    expressionOperators = [];
    expressionNumbers = [];

    if (ischar(expression) == false)
        expression = convertStringsToChars(expression);
    end

    index = 1;

    while index <= length(expression)
        character = expression(index);

        operator = find(operators == character);

        if operator
            precedence = operatorPrecedence(operator);

            while isempty(expressionOperators) == false && expressionOperators(end) > precedence
                value = applyOperator(expressionNumbers(end - 1), expressionOperators(end), expressionNumbers(end));

                expressionOperators(end) = [];
                expressionNumbers(end) = [];
                expressionNumbers(end) = value;
            end

            expressionOperators(end + 1) = operator;
        elseif isstrprop(character, 'digit')
            number = string(character);

            while (index + 1 <= length(expression)) && isstrprop(expression(index + 1), 'digit')
                index = index + 1;

                number = number + string(expression(index));
            end

            expressionNumbers(end + 1) = str2double(number);
        end

        index = index + 1;
    end

    while isempty(expressionOperators) == false
        value = applyOperator(expressionNumbers(end - 1), expressionOperators(end), expressionNumbers(end));

        expressionOperators(end) = [];
        expressionNumbers(end) = [];
        expressionNumbers(end) = value;
    end

    answer = expressionNumbers(1);
end