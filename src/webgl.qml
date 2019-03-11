Item {
	anchors.fill: context;

	GlContext {
		x: 10%;
		y: 10%;
		width: 50%;
		height: 50%;

		VertexShader { id: vertexShader; }
		FragmentShader { id: fragmentShader; }

		Program { id: program; }

		onDrawScene(delta): {
			var gl = this.gl
			gl.clearColor(0.0, 0.0, 0.0, 1.0);  // Clear to black, fully opaque
			gl.clearDepth(1.0);                 // Clear everything
			gl.enable(gl.DEPTH_TEST);           // Enable depth testing
			gl.depthFunc(gl.LEQUAL);            // Near things obscure far things

			// Clear the canvas before we start drawing on it.
			gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

			// Create a perspective matrix, a special matrix that is
			// used to simulate the distortion of perspective in a camera.
			// Our field of view is 45 degrees, with a width/height
			// ratio that matches the display size of the canvas
			// and we only want to see objects between 0.1 units
			// and 100 units away from the camera.
			var fieldOfView = 45 * Math.PI / 180;   // in radians
			var aspect = gl.canvas.clientWidth / gl.canvas.clientHeight;
			var zNear = 0.1;
			var zFar = 100.0;
			var mat4 = window.mat4
			var programInfo = this._programInfo
			var projectionMatrix = mat4.create();

			// note: glmatrix.js always has the first argument
			// as the destination to receive the result.
			mat4.perspective(
				projectionMatrix,
				fieldOfView,
				aspect,
				zNear,
				zFar
			);

			// Set the drawing position to the "identity" point, which is
			// the center of the scene.
			var modelViewMatrix = mat4.create();

			// Now move the drawing position a bit to where we want to
			// start drawing the square.

			mat4.translate(
				modelViewMatrix,     // destination matrix
				modelViewMatrix,     // matrix to translate
				[-0.0, 0.0, -6.0]    // amount to translate
			);

			mat4.rotate(
				modelViewMatrix,  // destination matrix
				modelViewMatrix,  // matrix to rotate
				this.cubeRotation,     // amount to rotate in radians
				[0, 0, 1]       // axis to rotate around (Z)
			);

			mat4.rotate(modelViewMatrix,  // destination matrix
			modelViewMatrix,  // matrix to rotate
			this.cubeRotation * .7,// amount to rotate in radians
			[0, 1, 0]);       // axis to rotate around (X)

			// Tell WebGL how to pull out the positions from the position
			// buffer into the vertexPosition attribute

			var buffers = this._buffers
			{
				var numComponents = 3;
				var type = gl.FLOAT;
				var normalize = false;
				var stride = 0;
				var offset = 0;
				gl.bindBuffer(gl.ARRAY_BUFFER, buffers.position);
				gl.vertexAttribPointer(
				programInfo.attribLocations.vertexPosition,
				numComponents,
				type,
				normalize,
				stride,
				offset);
				gl.enableVertexAttribArray(
				programInfo.attribLocations.vertexPosition);
			}

			// Tell WebGL how to pull out the colors from the color buffer
			// into the vertexColor attribute.
			{
				numComponents = 4;
				type = gl.FLOAT;
				normalize = false;
				stride = 0;
				offset = 0;
				gl.bindBuffer(gl.ARRAY_BUFFER, buffers.color);
				gl.vertexAttribPointer(
				programInfo.attribLocations.vertexColor,
				numComponents,
				type,
				normalize,
				stride,
				offset);
				gl.enableVertexAttribArray(
				programInfo.attribLocations.vertexColor);
			}

			// Tell WebGL which indices to use to index the vertices
			gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, buffers.indices);

			// Tell WebGL to use our program when drawing

			gl.useProgram(programInfo.program);

			// Set the shader uniforms

			gl.uniformMatrix4fv(
			programInfo.uniformLocations.projectionMatrix,
			false,
			projectionMatrix);
			gl.uniformMatrix4fv(
			programInfo.uniformLocations.modelViewMatrix,
			false,
			modelViewMatrix);

			{
			var vertexCount = 36;
			type = gl.UNSIGNED_SHORT;
			offset = 0;
			gl.drawElements(gl.TRIANGLES, vertexCount, type, offset);
			}

			this.cubeRotation += delta;
		}

		initBuffers: {
			var gl = this.gl
			// Create a buffer for the cube's vertex positions.
			var positionBuffer = gl.createBuffer();

			// Select the positionBuffer as the one to apply buffer
			// operations to from here out.
			gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);

			// Now create an array of positions for the cube.
			var positions = [
				// Front face
				-1.0, -1.0,  1.0,
				1.0, -1.0,  1.0,
				1.0,  1.0,  1.0,
				-1.0,  1.0,  1.0,

				// Back face
				-1.0, -1.0, -1.0,
				-1.0,  1.0, -1.0,
				1.0,  1.0, -1.0,
				1.0, -1.0, -1.0,

				// Top face
				-1.0,  1.0, -1.0,
				-1.0,  1.0,  1.0,
				1.0,  1.0,  1.0,
				1.0,  1.0, -1.0,

				// Bottom face
				-1.0, -1.0, -1.0,
				1.0, -1.0, -1.0,
				1.0, -1.0,  1.0,
				-1.0, -1.0,  1.0,

				// Right face
				1.0, -1.0, -1.0,
				1.0,  1.0, -1.0,
				1.0,  1.0,  1.0,
				1.0, -1.0,  1.0,

				// Left face
				-1.0, -1.0, -1.0,
				-1.0, -1.0,  1.0,
				-1.0,  1.0,  1.0,
				-1.0,  1.0, -1.0,
			];

			// Now pass the list of positions into WebGL to build the
			// shape. We do this by creating a Float32Array from the
			// JavaScript array, then use it to fill the current buffer.
			gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);

			// Now set up the colors for the faces. We'll use solid colors
			// for each face.
			var faceColors = [
				[1.0,  1.0,  1.0,  1.0],    // Front face: white
				[1.0,  0.0,  0.0,  1.0],    // Back face: red
				[0.0,  1.0,  0.0,  1.0],    // Top face: green
				[0.0,  0.0,  1.0,  1.0],    // Bottom face: blue
				[1.0,  1.0,  0.0,  1.0],    // Right face: yellow
				[1.0,  0.0,  1.0,  1.0],    // Left face: purple
			];

			// Convert the array of colors into a table for all the vertices.
			var colors = [];

			for (var j = 0; j < faceColors.length; ++j) {
				var c = faceColors[j];
				// Repeat each color four times for the four vertices of the face
				colors = colors.concat(c, c, c, c);
			}

			var colorBuffer = gl.createBuffer();
			gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);
			gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(colors), gl.STATIC_DRAW);

			// Build the element array buffer; this specifies the indices
			// into the vertex arrays for each face's vertices.
			var indexBuffer = gl.createBuffer();
			gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);

			// This array defines each face as two triangles, using the
			// indices into the vertex array to specify each triangle's
			// position.
			var indices = [
				0,  1,  2,      0,  2,  3,    // front
				4,  5,  6,      4,  6,  7,    // back
				8,  9,  10,     8,  10, 11,   // top
				12, 13, 14,     12, 14, 15,   // bottom
				16, 17, 18,     16, 18, 19,   // right
				20, 21, 22,     20, 22, 23,   // left
			];

			// Now send the element array to GL
			gl.bufferData(gl.ELEMENT_ARRAY_BUFFER,
			new Uint16Array(indices), gl.STATIC_DRAW);

			return {
				position: positionBuffer,
				color: colorBuffer,
				indices: indexBuffer,
			};
		}

		onCompleted: {
			var vsSource = "attribute vec4 aVertexPosition;" +
				"attribute vec4 aVertexColor;" +
				"uniform mat4 uModelViewMatrix;" +
				"uniform mat4 uProjectionMatrix;" +
				"varying lowp vec4 vColor;" +
				"void main(void) {" +
					"gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;" +
					"vColor = aVertexColor;" +
				"}"

			// Fragment shader program
			var fsSource = "varying lowp vec4 vColor;" +
				"void main(void) {" +
					"gl_FragColor = vColor;" +
				"}"

			this.cubeRotation = 0;

			var vertexShaderImpl = vertexShader.create(vsSource)
			var fragmentShaderImpl = fragmentShader.create(fsSource)
			program.attachShader(vertexShaderImpl)
			program.attachShader(fragmentShaderImpl)
			program.linkProgram()
			var shaderProgram = program.create()

			// Collect all the info needed to use the shader program.
			// Look up which attributes our shader program is using
			// for aVertexPosition, aVevrtexColor and also
			// look up uniform locations.
			var gl = this.gl
			this._programInfo = {
				program: shaderProgram,
				attribLocations: {
					vertexPosition: gl.getAttribLocation(shaderProgram, 'aVertexPosition'),
					vertexColor: gl.getAttribLocation(shaderProgram, 'aVertexColor'),
				},
				uniformLocations: {
					projectionMatrix: gl.getUniformLocation(shaderProgram, 'uProjectionMatrix'),
					modelViewMatrix: gl.getUniformLocation(shaderProgram, 'uModelViewMatrix'),
				},
			};

			this._buffers = this.initBuffers(gl);
			this.startRender()
		}
	}
}
