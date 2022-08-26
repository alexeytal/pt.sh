#!/bin/bash

#datafile="${PT_PATH:-$XDG_DATA_HOME/pt.sh/pt.csv}"
[ -f ./pt.csv ] && datafile="pt.csv" || datafile="${PT_PATH:-$XDG_DATA_HOME/pt.sh/pt.csv}"
export GREP_COLORS='ms=1;33;30;48;5;10'

table="    1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  
  ┌───┐                                                               ┌───┐
1 │ H │                                                               │He │
  ├───┼───┐                                       ┌───┬───┬───┬───┬───┼───┤
2 │Li │Be │                                       │ B │ C │ N │ O │ F │Ne │
  ├───┼───┤                                       ├───┼───┼───┼───┼───┼───┤
3 │Na │Mg │                                       │Al │Si │ P │ S │Cl │Ar │
  ├───┼───┼───┬───┬───┬───┬───┬───┬───┬───┬───┬───┼───┼───┼───┼───┼───┼───┤
4 │ K │Ca │Sc │Ti │ V │Cr │Mn │Fe │Co │Ni │Cu │Zn │Ga │Ge │As │Se │Br │Kr │
  ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
5 │Rb │Sr │ Y │Zr │Nb │Mo │Tc │Ru │Rh │Pd │Ag │Cd │In │Sn │Sb │Te │ I │Xe │
  ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
6 │Cs │Ba │LAN│Hf │Ta │ W │Re │Os │Ir │Pt │Au │Hg │Tl │Pb │Bi │Po │At │Rn │
  ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
7 │Fr │Ra │ACT│Rf │Db │Sg │Bh │Hs │Mt │Ds │Rg │Cn │Nh │Fl │Mc │Lv │Ts │Og │
  └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
              ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
  Lanthanides │La │Ce │Pr │Nd │Pm │Sm │Eu │Gd │Tb │Dy │Ho │Er │Tm │Yb │Lu │
              ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
  Actinides   │Ac │Th │Pa │ U │Np │Pu │Am │Cm │Bk │Cf │Es │Fm │Md │No │Lw │
              └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘"

help(){
  cat <<-_EOF
Usage: pt.sh [option] [element]
Print the periodic table of element.

Positional arguments:
  element       [optional] One or multiple elements to be highlighted

Options:
 -s, -shell    highlight s,p,d elements
 -tm, -TM      highlight transiton metals
 -c, -C        print detailed info on elements

The file with the data for info cards is stored in `echo $XDG_DATA_HOME/pt/table.csv`.
A custom path can be set in the PT_PATH variable.
_EOF
}

tm(){
  TM="Sc Ti  V Cr Mn Fe Co Ni Cu Zn Y Zr Nb Mo \
  Tc Ru Rh Pd Ag Cd La Hf Ta W Re Os Ir Pt Au Hg Ac \
  Rf Db Sg Bh Hs Mt Ds Rg Cn "

  echo -e "$table" | grep --color -w -E "$(printf ' *%s *\n' $TM )|$"
}

shells(){
  s="H He Li Be Na Mg K Ca Rb Sr Cs Ba Fr Ra"
  p="B C N O F Ne Al Si P S Cl Ar Ga Ge As Se Br Kr In Sn \
  Sb Te I Xe Tl Pb Bi Po At Rn Nh Fl Mc Lv Ts Og"
  d="Sc Ti V Cr Mn Fe Co Ni Cu Zn Y Zr Nb Mo Tc Ru Rh Pd Ag Cd \
  Hf Ta W Re Os Ir Pt Au Hg Rf Db Sg Bh Hs Mt Ds Rg Cn"
  f="La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu \
  Ac Th Pa  U Np Pu Am Cm Bk Cf Es Fm Md No Lw"
  export GREP_COLORS='1;31'

  echo -e "$table" \
  | GREP_COLOR='1;31' grep --color=always -w -E "$(printf '%s\n' $s)|$" \
  | GREP_COLOR='1;35' grep --color=always -w -E "$(printf '%s\n' $p)|$" \
  | GREP_COLOR='1;36' grep --color=always -w -E "$(printf '%s\n' $d)|$" \
  | GREP_COLOR='1;32' grep --color=always -w -E "$(printf '%s\n' $f)|$" 
}

print_card()
{
  if grep -q -E "$(printf ' *%s *\n' "$@" )|$" <(echo $table)
  then
    awk -F "," '{
      if (NR==1){
        for(i=1; i<=NF; i++){
          gsub(/^[ \t]+/, "", $i); label[i]=$i
        }
      } else {
        if ($2 == "'$1'"){
          for(i=1; i<=NF; i++){
            gsub(/^[ \t]+/, "", $i); 
            if ($i) printf "%29s: %s \n", label[i], $i
          }
        }
      }
    }' $datafile
  fi
}

highlight(){
  echo -e "$table" | grep --color -w -E "$(printf ' *%s *\n' "$@" )|$"
}

case $1 in
  -h|--help) help ;;
  -c|-C) [ ! -z "$2" ] && print_card $2 ;;
  -tm|-TM) tm ;;
  -s|-shell) shells ;;
  *) [ "$#" -lt 1 ] && echo -e "$table" || highlight "$@" ;;
esac
