#!/bin/bash

echo -e "Content-type: text/html\n\n"

#NBTS=4
EQ[1]="LAMPADA"
EQ[2]="VENTILADOR"
EQ[3]="LED"
EQ[4]="UMIDIFICADOR"


for i in $(seq ${#EQ[@]}); do
 if [[ $(cat /tmp/www/cgi-bin/t$i.txt) -eq 0 ]]; then
  C[$i]="checked"
  else
  C[$i]=" "
 fi
 if [[ ${EQ[i]} == "" ]]; then
  C[$i]="disabled"
 fi

done

_CSS(){

cat <<EOF

<style>
body {
    background: #eee;
}

.toggle {
    margin-bottom: 40px;
}

.toggle > input {
    display: none;
}

.toggle > label {
    position: relative;
    display: block;
    height: 20px;
    width: 44px;
    background: #898989;
    border-radius: 100px;
    cursor: pointer;
    transition: all 0.3s ease;
}
.toggle > label:after {
    position: absolute;
    left: -2px;
    top: -3px;
    display: block;
    width: 26px;
    height: 26px;
    border-radius: 100px;
    background: #fff;
    box-shadow: 0px 3px 3px rgba(0,0,0,0.05);
    content: '';
    transition: all 0.3s ease;
}
.toggle > label:active:after {
    transform: scale(1.15, 0.85);
}
.toggle > input:checked ~ label {
    background: #6fbeb5;
}
.toggle > input:checked ~ label:after {
    left: 20px;
    background: #179588;
}
.toggle > input:disabled ~ label {
    background: #d5d5d5;
    pointer-events: none;
}
.toggle > input:disabled ~ label:after {
    background: #bcbdbc;
}
</style>
EOF
}

_BOTAO(){
echo "<center><div class='toggle'>"
#eval echo '$EQ'$1
echo ${EQ[$1]}
echo    "<input onclick='acao$1()' type='checkbox' id='t$1' ${C[$1]}>"
#echo    "<button onclick='acao()'>Teste</button>"
echo    "<label for='t$1'></label>"
echo "</div></center>"

}

_SCRIPT(){
#cat <<EOF
echo "<script>"
echo "var xmlhttp;"
echo "xmlhttp=new XMLHttpRequest();"
for i in $(seq ${#EQ[@]}); do
 echo "function acao$i()"
        echo "{"
        echo "xmlhttp.open(\"GET\",\"acao.sh?$i\", true);"
        echo "xmlhttp.send();"
        echo "}"
done
echo "</script>"
#EOF
}

_CSS
for i in $(seq ${#EQ[@]}); do
 if [[ ${EQ[$i]} != "" ]]; then
  _BOTAO $i
 fi
done
#_BOTAO 2
#_BOTAO 3
#_BOTAO 4
_SCRIPT
