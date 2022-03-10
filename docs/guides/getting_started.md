---
order: 
icon: rocket
author:
    - name: Sofie
      email: sofie.torch@outlook.com
---

# Getting started

## Set up :rocket:
Para poner el proyecto en marcha y correr la app, necesitarás:
* Instalar el SDK de Flutter en tu computadora.
* Seleccionar un directorio para el proyecto, navegar a él desde la terminal, y correr:
  ```
    git clone https://github.com/SofieTorch/univalle_app.git
  ```
  Así obtendrás el proyecto en `tu-directorio/univalle_app/`.  
* Instalar las dependencias, con el comando:
  ```
    flutter pub get
  ```
* Ya tienes el proyecto completo! Este proyecto tiene principalmente dos "sabores": **development** y **production**.  
  Para correr el "sabor" deseado, ya sea en un emulador o un dispositivo físico, puedes usar la configuración de compilación en VSCode/Android Studio, o correr los siguientes comandos:
  ```
  # Development
  $ flutter run --flavor development --target lib/main_development.dart

  # Production
  $ flutter run --flavor production --target lib/main_production.dart
  ```

>**Nota:** También existe un "sabor" *staging*, pero está en desuso. De cualquier forma, si lo deseas lo puedes correr con `flutter run --flavor staging --target lib/main_staging.dart`.

## Running Tests :test_tube:
Para correr todos los unit y widget tests usa el siguiente comando:
```
$ flutter test --coverage --test-randomize-ordering-seed random
```

Para ver un reporte de coverage generado puedes usar <a href="https://github.com/linux-test-project/lcov" target="_blank">Icov</a>.
```
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---
  
==- [DESUSE] Working with Translations 🌐

Este proyecto se basa en [flutter_localizations][flutter_localizations_link] y sigue la [guía oficial de internacionalización con Flutter][internationalization_link].  

**Adding Strings**  

1. Para agregar un nuevo string localizable, abre el archivo `app_en.arb` en `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Agrega una nueva llave/valor y una descripción.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Usa el nuevo string.

```dart
import 'package:univalle_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```  

**Adding Supported Locales**  

Actualiza el `CFBundleLocalizations` array en el archivo `Info.plist` en `ios/Runner/Info.plist` para incluir una nueva localización.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

**Adding Translations**  

1. Para cada lozalización soportada, agrega un nuevo archivo ARB en `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Agrega los strings traducidos en el archivo `.arb`:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```
===

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization