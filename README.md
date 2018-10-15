# PureQML Examples
## 1. camera
### 1.1. Description
Camera overlay application example based on [cordova-plugin-camera-preview](https://www.npmjs.com/package/cordova-plugin-camera-preview)
### 1.2. Build & Install

Clone repo and build it:
```
git clone https://github.com/comrat/pureqml-examples.git
cd pureqml-examples
git submodule init
git submodule update
```
Install app on android:
```
./smart-tv-deployer/build.py -p android
```

### 1.3. Preview
![GitHub Logo](https://github.com/comrat/pureqml-examples/raw/master/dist/screens/camera.png)

## 2. Voice
### 2.1. Description
Simple voice recognition app. Just press button and try to say something.
### 1.2. Build & Install
```
./smart-tv-deployer/build.py -p android -a voice
```
