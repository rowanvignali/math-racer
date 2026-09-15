clc
clear

units = jsondecode(fileread("data/units.json"));
unit = units{4}.AdvancedDivision;

expression = generateExpression(unit.Operators, randi(unit.OperatorCount), unit.NumberRange, unit.AlwaysPositive);

disp(expression)
disp(evaluate(expression))