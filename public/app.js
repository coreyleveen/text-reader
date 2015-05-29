var form = document.getElementById("photo-form"),
    cameraInput = document.getElementById("camera-input"),
    submitButton = document.getElementById("submit-button");

form.onsubmit = function(e) {
    event.preventDefault();

    submitButton.value = "Uploading...";

    var file = cameraInput.files[0];

    if (!file.type.match('image.*')) {
        alert("You must upload an image file.");
        submitButton.value = "Upload";
        return;
    }

    var img = new Image();

    var height,
        width;

    img.onload = function() {
        height = this.height;
        width  = this.width;
    };


    img.src = URL.createObjectURL(file);

    var reader = new FileReader();

    reader.onload = function(e) {
        var contents = e.target.result;
        // Creates an ArrayBuffer representation of the file

        console.log("File contents: " + contents);

        var uintc8 = new Uint8ClampedArray(contents);
    };

    reader.onerror = function(e) {
        console.error("File could not be read! Code " + e.target.error.code);
    };

    reader.readAsArrayBuffer(file);

    debugger;


    // var formData = new FormData();

    // var xhr = new XMLHttpRequest();

    // xhr.open("POST", "/to_voice", true);

    // xhr.onload = function() {
    //     if (xhr.status === 200) {
    //         alert("Success!");
    //         submitButton.value = "Upload";
    //     } else {
    //         alert("An error occurred :/");
    //     }
    // };

    // xhr.send(formData);
};
