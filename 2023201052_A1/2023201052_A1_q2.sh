#!/bin/bash

read N

read prices


 IFS=' ' read -ra prices <<< $prices



maxp=0
mini=${prices[0]}

for ((i=1; i<N; i++)); do
    if ((prices[i] < mini)); then
        mini=${prices[i]}
    else
        profit=$((prices[i] - mini))
        if ((profit > maxp)); then
            maxp=$profit
        fi
    fi
done

echo "Maximum Profit: $maxp"
