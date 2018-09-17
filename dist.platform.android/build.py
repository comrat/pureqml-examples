{% extends "build.py" %}
{% block plugins %}
	{{ super() }}
        os.system('cordova plugins add https://github.com/cordova-plugin-camera-preview/cordova-plugin-camera-preview.git')
{% endblock %}
