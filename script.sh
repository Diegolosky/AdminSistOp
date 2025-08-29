#!/bin/bash

opc=0

function menu(){

    echo "MENÚ PRINCIPAL"

    echo "1 - Gestión de usuarios"

    echo "2 - Gestión de grupos"

    echo "3 - Gestión de redes"

    echo "4 - Gestión de Firewall"

    echo "5 - Salir"

    echo -n "Ingrese una opción: "

}


function gestion_usuarios() {

    opc_usuario=0

    while [ $opc_usuario -ne 4 ]; do

        clear

        echo "GESTIÓN DE USUARIOS"

        echo "1 - Crear usuario"

        echo "2 - Eliminar usuario"

        echo "3 - Listar usuarios"

        echo "4 - Volver al menú principal"

        echo -n "Ingrese una opción: "

        read opc_usuario

          case $opc_usuario in

            1)

                echo -n "Ingrese el nombre del nuevo usuario: "

                read nombre_usuario

                sudo useradd -m $nombre_usuario

                sudo passwd $nombre_usuario

                echo "Usuario $nombre_usuario creado correctamente.";;

            2)

                echo -n "Ingrese el nombre del usuario a eliminar: "

                read nombre_usuario

                sudo userdel -r $nombre_usuario

                echo "Usuario $nombre_usuario eliminado correctamente.";;

            3)

                echo "Lista de usuarios del sistema:"

                echo "..."

                cut -d: -f1 /etc/passwd | sort

                echo "...";;

            4)

                echo "Volviendo al menú principal...";;

            *)

                echo "Opción no válida. Intente nuevamente.";;

        esac

          if [ $opc_usuario -ne 4 ]; then

            echo -n "Presione Enter para continuar..."

            read

        fi

    done

}


function gestion_grupos() {

    opc_grupo=0

    while [ $opc_grupo -ne 5 ]; do

        clear

        echo "GESTIÓN DE GRUPOS"

        echo "1 - Crear grupo"

        echo "2 - Eliminar grupo"

        echo "3 - Listar grupos"

        echo "4 - Agregar usuario a grupo"

        echo "5 - Volver al menú principal"

        echo -n "Ingrese una opción: "

        read opc_grupo

 case $opc_grupo in

            1)

                echo -n "Ingrese el nombre del nuevo grupo: "

                read nombre_grupo

                sudo groupadd $nombre_grupo

                echo "Grupo $nombre_grupo creado correctamente.";;

            2)

                echo -n "Ingrese el nombre del grupo a eliminar: "

                read nombre_grupo

                sudo groupdel $nombre_grupo

                echo "Grupo $nombre_grupo eliminado correctamente.";;

            3)

                echo "Lista de grupos del sistema:"

                echo "..."

                cut -d: -f1 /etc/group | sort

                echo "...";;

            4)

                echo -n "Ingrese el nombre del usuario: "

                read nombre_usuario

                echo -n "Ingrese el nombre del grupo: "

                read nombre_grupo

                sudo usermod -aG $nombre_grupo $nombre_usuario

                echo "Usuario $nombre_usuario agregado al grupo $nombre_grupo";;
                 5)

                echo "Volviendo al menú principal...";;

            *)

                echo "Opción no válida. Intente nuevamente.";;

        esac

        if [ $opc_grupo -ne 5 ]; then

            echo -n "Presione Enter para continuar..."

            read

        fi

    done

}


function gestion_redes() {

    opc_red=0

    while [ $opc_red -ne 5 ]; do

        clear

        echo "GESTIÓN DE REDES"

        echo "1 - Mostrar configuración de red"

        echo "2 - Mostrar conexiones activas"

        echo "3 - Reiniciar interfaz de red"

        echo "4 - Probar conexión a internet"

        echo "5 - Volver al menú principal"

        echo -n "Ingrese una opción: "

        read opc_red
         case $opc_red in

            1)

                echo "Configuración de red actual:"

                echo "..."

                ip a

                echo "...";;

            2)

                echo "Conexiones de red activas:"

                echo "..."

                netstat -tulnp

                echo "...";;

            3)

                echo -n "Ingrese el nombre de la interfaz a reiniciar: "

                read interfaz

                sudo systemctl restart networking

                echo "Interfaz $interfaz reiniciada.";;

            4)

                ping -c 4 8.8.8.8

                ;;

            5)

                echo "Volviendo al menú principal...";;

            *)
              echo "Opción no válida. Intente nuevamente.";;

        esac

        if [ $opc_red -ne 5 ]; then

            echo -n "Presione Enter para continuar..."

            read

        fi

    done

}


function gestion_firewall() {

    opc_firewall=0

    while [ $opc_firewall -ne 6 ]; do

        clear

        echo "GESTIÓN DE FIREWALL"

        echo "1 - Mostrar reglas de firewall"

        echo "2 - Agregar regla de permiso"

        echo "3 - Agregar regla de bloqueo"

        echo "4 - Eliminar regla"

        echo "5 - Resetear firewall"

        echo "6 - Volver al menú principal"

        echo -n "Ingrese una opción: "

        read opc_firewall
         case $opc_firewall in

            1)

                echo "Reglas de firewall actuales:"

                echo "..."

                sudo iptables -L -nv --line-numbers

                echo "...";;

            2)

                echo -n "Ingrese el puerto a habilitar: "

                read puerto

                sudo iptables -A INPUT -p tcp --dport $puerto -j ACCEPT

                echo "Puerto $puerto habilitado en el firewall.";;

            3)

                echo -n "Ingrese la IP a bloquear: "

                read ip

                sudo iptables -A INPUT -s $ip -j DROP

                echo "IP $ip bloqueada en el firewall.";;

            4)

                echo -n "Ingrese el número de regla a eliminar: "

                read num_regla

                sudo iptables -D INPUT $num_regla

                echo "Regla $num_regla eliminada.";;
                  5)

                sudo iptables -F

                echo "Firewall reseteado a configuración por defecto";;

            6)

                echo "Volviendo al menú principal...";;

            *)

                echo "Opción no válida. Intente nuevamente.";;

        esac

        if [ $opc_firewall -ne 6 ]; then

            echo -n "Presione Enter para continuar..."

            read

        fi

    done

}

# Menú principal

while [ $opc -ne 8 ]; do

    clear

    menu

    read opc

    case $opc in
     1) gestion_usuarios;;

        2) gestion_grupos;;

        3) gestion_redes;;

        4) gestion_firewall;;

        5)


            clear

            break;;

        *)

            echo "Opción no válida. Intente nuevamente."

            echo -n "Presione Enter para continuar..."

            read;;

    esac

done