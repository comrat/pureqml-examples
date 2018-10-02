{% extends "build.py" %}
{% block plugins %}
	{{ super() }}
        os.system('cordova plugins add https://github.com/cordova-plugin-camera-preview/cordova-plugin-camera-preview.git')
        os.system('cordova plugins add cordova-plugin-speechrecognition')
{% endblock %}
