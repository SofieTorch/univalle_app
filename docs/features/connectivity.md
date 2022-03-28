# Connectivity

Verifica el estado de la conexión a internet.  

## Workflow
En cuanto la aplicación se inicia, se ha de verificar en todo momento el estado de la conexión a internet, ya que la necesita para su funcionamiento.  
Si el dispositivo pierde la conexión a internet, se mostrará una ventana emergente (dialog) informando de la pérdida de conexión y bloqueando el uso de la app. Dicho mensaje desaparecerá cuando la conexión a internet se recupere, además, también se mostrará un snackbar informando que la conexión ha sido recuperada.

## Behaviour
* Se hace uso del package [connectivity_plus](https://pub.dev/packages/connectivity_plus) para la verificación de conexión.
* Se reciben los eventos `Requested`, `Lost` y `Retrieved`.
    * El evento `Requested` se dispara al iniciar la aplicación, para inicializar la verificación de conexión. Al recibir este evento, el bloc hace una llamada inicial de verificación y se suscribe al stream del objeto `Connectivity` del package connectivity_plus para escuchar los cambios en la conexión.
    * Los eventos Lost y Retrieved informan sobre el cambio de conexión, son disparados por el objeto Connectivity del package connectivity_plus cuando ocurre dicho cambio.
* Se retornan los estados `Initial`, `Loading`, `Connected` y `Disconnected`.
    * `Initial` es el estado inicial del bloc al ser creado y no recibir ningún evento.
    * `Loading` se retornará luego de recibir el evento Requested y antes de recibir algún evento sobre el estado de la conexión, refleja que la verificación de conectividad está cargando.
    * `Connected` y `Disconnected` son retornados luego de los eventos `Lost` y `Retrieved`, para que la interfaz sepa del estado de la conexión y cambie de acuerdo a ésta.
### About user interface
Respecto a la interfaz, los eventos que enviará y los estados que recibirá, están los siguientes puntos a considerar:
* Al iniciar la aplicación se instancia un `ConnectivityBloc` y se envía el evento `Requested`.
* Al recibir el estado `Disconnected`, se mostrará el dialog `ConnectivityLostDialog`, el cual informa sobre el estado de la conexión (es decir, sin conexión) y bloquea el uso de la app.
* Al recibir el estado `Connected` luego de un `Disconnected`, el dialog anterior se cerrará y desbloqueará la app, además se mostrará un snackbar informando que la conexión ha sido recuperada.
* Al recibir el estado `Connected` al principio, no habrá cambios y la app funcionará con normalidad hasta que un nuevo estado sea recibido.

