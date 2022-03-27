---
order: -4
icon: file
---

# About documentation

Al escribir documentación, ésta debe estar redactada de forma clara y con la información necesaria para que los miembros del equipo entiendan lo que se busca redactar y puedan trabajar fácilmente.

Principalmente se busca tener la documentación escrita manualmente en archivos `.md`, los cuales serán ubicados dentro del directorio `docs/` para su posterior generación en la web page.

## Documenting code
En le caso del código, se escribirá documentación en línea a través de comentarios, en inglés, explicando cada clase, método, etc. que utiliza el feature. Se puede encontrar una guía de cómo escribir documentación en línea en Dart [aquí](https://dart.dev/guides/language/effective-dart/documentation), que si bien no es la regla, es bueno tomarla en cuenta.  

Para la generación de documentación en línea, se utiliza Dartdoc, el cual se basa en librerías para documentar y agrupar clases, archivos, etc. Por lo que, en el caso de documentar features, cada feature debe tener una librería declarada en el archivo barrel de su carpeta, con su respectiva descripción. Por ejemplo:

```dart #1-4 connectivity.dart
/// Contains the bloc needed to manage internet
/// connectivity status, and the widgets used to
/// listen and display bloc changes.
library connectivity;

export './bloc/connectivity_bloc.dart';
export './widgets/connectivity_listener.dart';
export './widgets/connectivity_lost_dialog.dart';
```
