# Navigation

Administración de la navegación en la aplicación.

## Generated routes
Las rutas principales de la aplicación, declaradas en la clase `AppRouter`. Por ahora sólo existen dos:

1. `/` o `default`: la cual es la ruta principal y por defecto de la app, la cual redirige a la `RootPage`, en donde se encuentra la estructura principal para la navegación a través de la barra de navegación inferior.
2. `/login`: que enruta hacia la página de inicio de sesión.

Dentro de cada ruta se inicializan los Blocs necesarios en todas las rutas de la aplicación, por ejemplo:

* `ConnectivityBloc`, para verificar la conexión a internet, es necesario en todas las rutas, ya que se ha de verificar la conexión en todo momento.
* En lugar de instanciar nuevos objetos de `ConnectivityBloc` en cada ruta, o peor aún, instanciar uno nuevo en cada página; es más eficiente manejar una sola instancia de Connectivity BlocProvider para todas las rutas y así evitar la instanciación de objetos innecesarios.
* Para esto, se maneja una sola instancia de `ConnectivityBloc` dentro de la clase `AppRouter`, y con `BlocProvider.value()` se provee esta instancia a cada ruta. `BlocProvider.value()` toma un Bloc ya existente y lo provee, por lo que utilizarlo es conveniente en esta situación en la que sólo queremos una instancia para todas las rutas.

## Bottom navigation bar
La barra de navegación inferior es la forma principal de navegar entre páginas. Se encuentra dentro de RootView y administra su estado utilizando un NavigationCubit, el cual es instanciado y proveído desde `RootPage`.  

Actualmente se cuenta con cuatro páginas principales: Inicio, Académica, Pagos y Perfil. Cada una se traduce en un elemento de la barra de navegación.  

### Behaviour
Para el manejo de estado de la barra de navegación inferior y por ende, el cambio de interfaz al hacer click en un elemento de ésta, se utiliza un `NavigationCubit`.  

* El estado inicial de `NavigationCubit` es `NavigationHome`, que se traduce en la página Home siendo la página inicial de la app.
* `NavigationCubit` contiene el método `changePage()`, el cual recibe el índice de la página a la que se está navegando. Este método mapea el índice con el estado que refleja la página correspondiente (de acuerdo al orden de los elementos en la barra de navegación) y lo emite. Por ejemplo:
    * `changePage(0) => emits NavigationHome`, ya que la página Home o Inicio es la primera en la barra de navegación.
    * `changePage(3) => emits NavigationProfile`, ya que la página Profile o Perfil es la cuarta en la barra de navegación.
* La interfaz, al recibir el nuevo estado, retorna la página correspondiente a éste.
* Además, cada estado contiene un índice, el cual es leído por la barra de navegación para actualizar su elemento seleccionado:
    ```dart root_page.dart #3-5
    BottomNavigationBar(
        ...
        currentIndex: context.select(
            (NavigationCubit cubit) => cubit.state.index,
        ),
    ),
    ```
