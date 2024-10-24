#!/bin/bash

# input from the user
read -p "Jaggu X = " jaggu_x
read -p "Jaggu Y = " jaggu_y
read -p "Police X = " police_x
read -p "Police Y = " police_y
read -p "H = " time

for ((i = 1; i <= time; i++)); do
    read -p "Police X = " new_police_x
    read -p "Police Y = " new_police_y

    # Calculating the  distance between points
    a1=$jaggu_x
    b1=$jaggu_y
    a2=$new_police_x
    b2=$new_police_y
    distance=$(echo "scale=2; sqrt(($a2 - $a1)^2 + ($b2 - $b1)^2)" | bc)

    if (( $(echo "$distance < 2" | bc -l) )); then
        echo "Location Reached"
        break
    elif ((i == time)); then
        echo "Time over"
        break
    else
        # Calculating the direction wrt to the policewomen
         x1=$jaggu_x
       y1=$jaggu_y
        x2=$new_police_x
         y2=$new_police_y

        # Calculating the direction from the x coordinate from jaggu and police
        xcor=$((x2 - x1))

        # Calculating the direction from the y coordinate from jaggu and police
        ycor=$((y2 - y1))

        if ((xcor == 0 && ycor == 0)); then
            echo "Location Reached"
        else
            if ((xcor >= 0 && ycor >= 0)); then
                direction="SW"
            elif ((xcor > 0 && ycor == 0)); then
                direction="W"
            elif ((xcor == 0 && ycor >= 0)); then
                direction="S"
            elif ((xcor == 0 && ycor <= 0)); then
                direction="N"
            elif ((xcor < 0 && ycor == 0)); then
                direction="E"
            elif ((xcor < 0 && ycor > 0)); then
                direction="SE"
            elif ((xcor > 0 && ycor < 0)); then
                direction="NW"
            elif ((xcor < 0 && ycor < 0)); then
                direction="NE"
            fi

            echo "$(printf "%.2f" $distance) $direction"
        fi
    fi
done
