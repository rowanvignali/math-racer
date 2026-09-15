% Rowan V for team L, meant for general use

function suffix = getNumberSuffix(number)
    suffix = "th";

    digit = mod(number, 10);

    if digit == 1
        suffix = "st";
    elseif digit == 2
        suffix = "nd";
    elseif digit == 3
        suffix = "rd";
    end
end