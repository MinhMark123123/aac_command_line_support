<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

- Generate data_layer
- Generate domain_layer
- Generate presentation_layer
- Generate app feature
- Support generate with your custom structure

## Getting started

- To install local : `pub global activate --source path` then ```export PATH="$PATH":"$HOME/.pub-cache/bin"```
- To uninstall : `pub global deactivate aac_command_line_support`

## Usage

To generate a feature in data layer type:

```
maac data_layer --feature=your_feature_name
```
For example:
```shell
maac data_layer --feature=authentication
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.

#### Command support


