#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


VARIABLE=$1
#if there is no an argument
if [[ -z $VARIABLE ]]
then
  echo "Please provide an element as an argument."

#elif the argument is an atomic number
elif [[ $VARIABLE =~ ^[0-9]+$ ]]
then
  #echo "es un numero"
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$VARIABLE")
  
  if [[ -z $DATA ]]
    then
      echo "I could not find that element in the database."

  else
    echo $DATA | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done

  fi


#elif the argument is a symbol
elif [[ ${#VARIABLE} -le 2  ]]
then
  #echo "is a symbol"
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$VARIABLE'")
  
  if [[ -z $DATA ]]
    then
      echo "I could not find that element in the database."

  else
    echo $DATA | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done

  fi

#else the argument is a name
else
#echo "is a name"
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$VARIABLE'")
  
  if [[ -z $DATA ]]
    then
      echo "I could not find that element in the database."

  else
    echo $DATA | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done

  fi

fi