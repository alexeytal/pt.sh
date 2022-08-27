#!/bin/sh

[ -f ./pt.csv ] && datafile="pt.csv" || datafile="${PT_PATH:-$XDG_DATA_HOME/pt.sh/pt.csv}"

c1=$(echo "0;30;101")
c2=$(echo "0;30;102")
c3=$(echo "0;30;103")
c4=$(echo "0;30;104")
c5=$(echo "0;30;105")
c6=$(echo "0;30;100")

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
 -h, --help     print help
 -s, --shell    highlight s,p,d, and f elements
 -g, --group    group elements of the periodic table
 -c, --card     print detailed info for an element

The file with the data for the info cards is stored in `echo $XDG_DATA_HOME/pt/table.csv`.
A custom path can be set in the PT_PATH variable.
_EOF
}

highlight(){
  GREP_COLOR=$1 grep --color=always -w -E "$(printf ' *%s *\n' "$@" )|$"
}

shells(){
  s="H He Li Be Na Mg K Ca Rb Sr Cs Ba Fr Ra"
  p="B C N O F Ne Al Si P S Cl Ar Ga Ge As Se Br Kr In Sn \
  Sb Te I Xe Tl Pb Bi Po At Rn Nh Fl Mc Lv Ts Og"
  d="Sc Ti V Cr Mn Fe Co Ni Cu Zn Y Zr Nb Mo Tc Ru Rh Pd Ag Cd \
  Hf Ta W Re Os Ir Pt Au Hg Rf Db Sg Bh Hs Mt Ds Rg Cn"
  f="La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu \
  Ac Th Pa  U Np Pu Am Cm Bk Cf Es Fm Md No Lw"

  echo  "$table" \
    | highlight $c1 $s \
    | highlight $c2 $p \
    | highlight $c3 $d \
    | highlight $c4 $f \

  printf "\033["$c1"m%18s\033[00;37m "  "s-shell"
  printf "\033["$c2"m%18s\033[00;37m "  "p-shell"
  printf "\033["$c3"m%18s\033[00;37m "  "d-shell"
  printf "\033["$c4"m%18s\033[00;37m\n" "f-shell"
}

group(){
  AK="H Li Na K Rb Cs Fr"
  AM="Be Mg Ca Sr Ba Ra"
  HL="F Cl Br I At Ts"
  NB="He Ne Ar Kr Xe Rn Og"
  TM="Sc Ti  V Cr Mn Fe Co Ni Cu Zn Y Zr Nb Mo \
  Tc Ru Rh Pd Ag Cd La Hf Ta W Re Os Ir Pt Au Hg Ac \
  Rf Db Sg Bh Hs Mt Ds Rg Cn"
  SM="B Si Ge As Sb Te Po"

  echo  "$table" \
    | highlight $c1 $AK \
    | highlight $c2 $AM \
    | highlight $c3 $HL \
    | highlight $c4 $NB \
    | highlight $c5 $TM \
    | highlight $c6 $SM 

  printf "\033["$c1"m%s\033[00;37m "  "Alkali Metals"
  printf "\033["$c2"m%s\033[00;37m "  "Alkali Earth Metals"
  printf "\033["$c3"m%s\033[00;37m "  "Halogens"
  printf "\033["$c4"m%s\033[00;37m "  "Noble Gases"
  printf "\033["$c5"m%s\033[00;37m "  "Transition Metals"
  printf "\033["$c6"m%s\033[00;37m\n" "Semimetals"
}


print_card()
{
  if $(echo "$table" | grep -q -E "$(printf ' *%s *\n' "$@" )|$")
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

case $1 in
  -h|--help) help ;;
  -c|--card) [ ! -z "$2" ] && print_card $2 ;;
	-g|--group) group;;
  -s|--shells) shells ;;
  *) [ "$#" -lt 1 ] && echo "$table" || echo "$table" | highlight "$c2" "$@" ;;
esac
