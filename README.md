# PureQML Examples
To work with all examples clone the repo and update submodules:
```
git clone https://github.com/comrat/pureqml-examples.git
cd pureqml-examples
git submodule init
git submodule update
```

## 1. camera
### 1.1. Description
Camera overlay application example based on [cordova-plugin-camera-preview](https://www.npmjs.com/package/cordova-plugin-camera-preview)
### 1.2. Build & Install
Build and install app on android:
```
./smart-tv-deployer/build.py -p android
```

### 1.3. Preview
![GitHub Logo](https://github.com/comrat/pureqml-examples/raw/master/dist/screens/camera.png)

## 2. Voice
### 2.1. Description
Simple voice recognition app. Just press button and try to say something.
### 1.2. Build & Install
Build and install app on android:
```
./smart-tv-deployer/build.py -p android -a voice
```

### 1.3. Preview
![GitHub Logo](https://github.com/comrat/pureqml-examples/raw/master/dist/screens/voice.jpg)

## 3. WebGL
### 3.1. Description
[WebGL](https://ru.wikipedia.org/wiki/WebGL) usage with PureQML example. Works on Smart TV (at least LG WebOS), android and web browsers.
### 3.2. Build & Install
Build and install app on android:
```
./smart-tv-deployer/build.py -p android -a webgl
```
### 3.3. Preview
![GitHub Logo](https://github.com/comrat/pureqml-examples/raw/master/dist/screens/webgl.png)


## 4. Subtitles
### 4.1. Description
Subtitles control can parse .srt subtitle and trigger corresponded line than attached video player progress occurs.
### 4.2. Build & Install
```
./smart-tv-deployer/build.py -p webos -a subtiles
```
### 4.3. Preview
![GitHub Logo](https://github.com/comrat/pureqml-examples/raw/master/dist/screens/subtitles.png)
