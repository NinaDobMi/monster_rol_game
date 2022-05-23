#!/bin/bash
#Creamos una funcion llamada turno donde vamos a ejecutar todas las acciones posibles de un turno del juego
#en este caso no hemos necesitado ningun parametro pero en caso de que fuera necesario creariamos una variable
#dentro de los parentesis
turno() {
#El siguiente paso es declarar las variables que necesitaremos que son las siguientes:
#-hay_monstruo: en esta variable generaremos un numero aleatorio que usaremos para comprobar si hay un monstruo en el camino o no
#-turno_heroe: esta variable tendra dos valores (1 y 0) esto nos permitira comprobar si es el turno del heroe o no
#-monstruo: aqui generaremos un numero entre 1 y 3 y nos permitira generar el tipo de monstruo que se genera
#-vida_monst: es la vida del monstruo, si se le mata esta variable valdra 0
hay_monstruo=$[RANDOM%2]
turno_heroe=1
monstruo=$[1+RANDOM%3]
vida_monst=1
#lo primero que vamos a comprobar es que si hay un monstruo o no, en caso de haberlo comenzara un bucle el cual solo parara cuando hayamos matado al monstruo, en caso de no haber
#simplemente se monstrara un mensaje por pantalla y terminara la ejecucion de la funcion
if [ $hay_monstruo -eq 1 ]; then
#como hay un monstruo y no podemos terminar hasta que el monstruo haya muerto generaremos un bucle en el que comprobaremos en cada vuelta que la vida del monstruo sea 1 (que el monstruo
#esta vivo)
while [ $vida_monst -eq 1 ];
do
#en caso de que haya un monstruo habra dos turnos, el del heroe y el del monstruo. Para ello comprobaremos que el turno del heroe sea 1
if [ $turno_heroe -eq 1 ]; then
#en el turno del heroe se podrá realizar dos acciones, atacar o defender
	echo "monstruo encontrado"
#sleep sirve para para durante x segundos el programa, hemos seleccionado 1 segundo
	sleep 1
#ahora vamos a pedir por pantalla que accion quiere el usuario (1 para atacar o 2 para defender) en caso de no ser ninguna de esas dos mostraremos un error
	echo "pulsa 1 para atacar o 2 para defender"
	read opcion
#comprobamos que accion ha elegido
	if [ $opcion -eq 1 ]; then
#como el usuario ha elegido ataque generaremos los dados de ataque del heroe
		dado_heroe_ataque=$[3+RANDOM%18]
		echo "atacas con $dado_heroe_ataque"
#como cada monstruo tiene unos valores diferentes de ataque y defensa comprobaremos que monstruo ha salido y en cada caso comprobaremos si es dado del heroe es mayor que el del monstruo
#en caso de que el monstruo saque un dado mayor que el del heroe a este se le quitara 1 punto de vida, en caso contrario el monstruo morira
		case $monstruo in
			1)
				dado_orco_defensa=$[2+RANDOM%12]
				echo "el orco se defiende con $dado_orco_defensa"
				if [ $dado_heroe_ataque -gt $dado_orco_defensa ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
			2)
				dado_trol_defensa=$[1+RANDOM%6]
				echo "el trol se defiende con $dado_trol_defensa"
				if [ $dado_heroe_ataque -gt $dado_trol_defensa ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
			3)
				dado_esq_defensa=$[2+RANDOM%12]
				echo "el esqueleto se defiende con $dado_esq_defensa"
				if [ $dado_heroe_ataque -gt $dado_esq_defensa ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
		esac
	elif [ $opcion -eq 2 ]; then
#Si el usuario elige defender generaremos los dados de defensa del heroe
		dado_heroe_defensa=$[4+RANDOM%24]
		echo "te defiendes con $dado_heroe_defensa"
#al defender se retrocedera 5 pasos por lo tanto deberemos añadir a escape 5
		let escape=escape+5
#la mecanica de defensa es parecida a la de ataque pero generaremos los dados de ataque del monstruo y los compararemos con los de defensa del heroe
		case $monstruo in
			1)
				dado_orco_ataque=$[3+RANDOM%18]
				echo "el orco ataca con $dado_orco_ataque"
				if [ $dado_heroe_defensa -gt $dado_orco_ataque ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
			2)
				dado_trol_ataque=$[2+RANDOM%12]
				echo "el trol ataca con $dado_trol_ataque"
				if [ $dado_heroe_defensa -gt $dado_trol_ataque ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
			3)
				dado_esq_ataque=$[1+RANDOM%6]
				echo "el esqueleto ataca con $dado_esq_ataque"
				if [ $dado_heroe_defensa -gt $dado_esq_ataque ]; then
				let vida_monst=vida_monst-1
				echo "has matado al monstruo"
				else
				let vida_heroe=vida_heroe-1
				echo "has perdido una vida"
				fi
				;;
		esac
	else
		echo "comando incorrecto"
	fi
#como el turno del heroe ha terminado pondremos la variable del heroe a 0 para que el siguiente turno sea el del monstruo
let turno_heroe=turno_heroe-1
else
#en caso de que sea el turno del monstruo comenzara una mecanica igual que cuando el usuario se defiende pero en este caso el heroe se defendera con tres dados
	echo "el monstruo ataca"
	sleep 1
	dado_heroe_defensa=$[4+RANDOM%24]
	echo "te defiendes con un $dado_heroe_defensa"
        case $monstruo in
                1)
			dado_orco_ataque=$[3+RANDOM%18]
			echo "el orco ataca con $dado_orco_ataque"
                        if [ $dado_heroe_defensa -gt $dado_orco_ataque ]; then
                        let vida_monst=vida_monst-1
                        echo "has matado al monstruo"
                        else
                        let vida_heroe=vida_heroe-1
                        echo "has perdido una vida"
                        fi
                        ;;
                2)
                        dado_trol_ataque=$[2+RANDOM%12]
 			echo "el trol ataca con $dado_trol_ataque"
			if [ $dado_heroe_defensa -gt $dado_trol_ataque ]; then
                        let vida_monst=vida_monst-1
                        echo "has matado al monstruo"
                        else let vida_heroe=vida_heroe-1
                        echo "has perdido una vida"
                        fi
                        ;;
                3)
                        dado_esq_ataque=$[1+RANDOM%6]
			echo "el esqueleto ataca con $dado_esq_ataque"
			if [ $dado_heroe_defensa -gt $dado_esq_ataque ]; then
                        let vida_monst=vida_monst-1
                        echo "has matado al monstruo"
                        else let vida_heroe=vida_heroe-1
                        echo "has perdido una vida"
                        fi
                        ;;
        esac
#añadimos 1 al turno del heroe para que el siguiente turno sea el del heroe
let turno_heroe=turno_heroe+1
fi
#fin del bucle
done
else 
	echo "no hay monstruo"
fi
}
#fin de la funcion
#declaramos las variables necesarias para que el programa funciones. Escape donde guardaremos los pasos que necesita el heroe para salir, la vida del heroe y todos los dados que se van 
#a lanzar
escape=60
vida_heroe=4
dado_heroe_ataque=$[3+RANDOM%18]
dado_heroe_defensa=$[4+RANDOM%24]
dado_heroe_andar=$[2+RANDOM%12]


dado_orco_ataque=$[3+RANDOM%18]
dado_orco_defensa=$[2+RANDOM%12]

dado_trol_ataque=$[2+RANDOM%12]
dado_trol_defensa=$[1+RANDOM%6]

dado_esq_ataque=$[1+RANDOM%6]
dado_esq_defensa=$[2+RANDOM%12]

#El juego consistira en tirar un dado que indicara los pasos que da ese turno y luego ejecutara la funcion turno donde se puede generar un monstruo o no
#generaremos un bucle donde evaluaremos que la vida del heroe sea mayor que 0, es decir, que no muera y que no haya conseguido salir del castillo, es decir, que escape sea mayor que 0
while [ $vida_heroe -gt 0 ] && [ $escape -gt 0 ]; do
	echo "tienes $vida_heroe puntos de vida y te quedan $escape pasos para salir"
	sleep 1
#generamos los dados donde nos mostrara cuantos pasos da ese turno
	dado_heroe_andar=$[2+RANDOM%12]
#a escape le restamos el valor que salga en el dado
	let escape=escape-dado_heroe_andar
#como en el ultimo turno puede salir un numero mayor que los pasos que le quedan por dar comprobaremos que lo que saca el dado es mayor que los pasos que le queda, de esta forma
#comprobaremos que el valor de escape nunca baje de 0 y que en el ultimo turno pueda salir un monstruo
	if [ $escape -gt 0 ]; then
	echo "avanzas $dado_heroe_andar pasos y te quedan $escape"
	sleep 1
	turno
	fi
done
#por ultimo comprobaremos si escape es 0 o menor que 0, en este caso el jugador habra ganado
if [ $escape -eq 0 ] || [ $escape -lt 0 ]; then
	echo "enhorabuena has ganado"
fi
#en caso de que la vida sea 0 el jugador habra perdido
if [ $vida_heroe -eq 0 ]; then
        echo "Has perdido, otra vez sera"
fi
