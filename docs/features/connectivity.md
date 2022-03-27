# Connectivity

## Main pupose
Verifica el estado de la conexión a internet.  

## Workflow
En cuanto la aplicación se inicia, se ha de verificar en todo momento el estado de la conexión a internet, ya que la necesita para su funcionamiento.  
Si el dispositivo pierde la conexión a internet, se mostrará una ventana emergente (dialog) informando de la pérdida de conexión y bloqueando el uso de la app. Dicho mensaje desaparecerá cuando la conexión a internet se recupere, además, también se mostrará un snackbar informando que la conexión ha sido recuperada.

## Behaviour
* Se hace uso del package [connectivity_plus](https://pub.dev/packages/connectivity_plus) para la verificación de conexión.
* Se manejan los eventos Requested, Lost y Retrieved.
    * El evento Requested se dispara al iniciar la aplicación, para inicializar la verificación de conexión. Al recibir este evento, el bloc hace una llamada inicial de verificación y se suscribe al stream del objeto Connectivity del package connectivity_plus para escuchar los cambios en la conexión.
    * Los eventos Lost y Retrieved informan sobre el cambio de conexión, son disparados por el objeto Connectivity del package connectivity_plus cuando ocurre dicho cambio.
* 

