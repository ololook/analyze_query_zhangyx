#!/bin/sh
statnum=`date -d "$1" +%s`
endnum=`date -d "$2" +%s`
awk  ' function cal(tm) {
        split(tm,m,"[ :]+")
        return mktime("20"substr(m[1],1,2)" "substr(m[1],3,2)" "substr(m[1],5,2)" "m[2]" "m[3]" "m[4])
                    }

{if($0~/^[0-9]/&& $2~/:/) {
        strime=$1" "$2;
        if(cal(strime)<='"$endnum"' && cal(strime)>='"$statnum"')
             { host = 1;}
        else { host = 0;}
        }

    if($0~/Query|Connect/)

                {query=1;}
        else    {query=0;}
if (host == 1 && query == 1) {print $0}
  else  if (cal(strime)>'"$endnum"') {exit;}}' $3