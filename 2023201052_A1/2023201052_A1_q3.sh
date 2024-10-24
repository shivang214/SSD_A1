#!/bin/bash


read -p "Input=" file   #readin the file content using the path specified

set -f   #for the * character to be considered as a normal character



  # Read each line from the file and reverse
  while IFS= read -r line || [[ -n "$line" ]]; do

     words=($line)  # Split the line into an array of words

     warray=()   # empty array for storing the words for reverse
     sarray=()   # separate array for the characters


#Traversing through the words array from the file

    for item in "${words[@]}"
     do
        
        #checking for the special characters to push into symbol array
        if [[ $item == '#' || $item == '$'|| $item == '*' || $item == '@' ]]
         then
            sarray+=("$item")
        else
            warray+=("$item")
        fi
    done

    output=""
    widx=$((${#warray[@]} - 1))
    sidx=0

    for item in "${words[@]}"
     do
      if [[ $item == '#' || $item == '$'|| $item == '*' || $item == '@' ]]
      then
            output+=" $item"    

            sidx+=1             #incrementing the symbol index to maintain the position  
         else
            output+=" ${warray[widx]}"  #adding the words on the desired location of the output

            widx=$(($widx - 1))         #decrementing the index to get the reversed required output
         fi
      done

  echo "${output:1}"  # Print the reversed line 
    
done < "$file"
