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

    var formData = new FormData();
    formData.append("photo", file, file.name);

    var xhr = new XMLHttpRequest();

    debugger;
}
