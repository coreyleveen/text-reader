// var form = document.getElementById("photo-form"),
//     cameraInput = document.getElementById("camera-input"),
//     submitButton = document.getElementById("submit-button");

// form.onsubmit = function(e) {
//     event.preventDefault();

//     submitButton.value = "Uploading...";

//     var file = cameraInput.files[0];

//     if (!file.type.match('image.*')) {
//         alert("You must upload an image file.");
//         submitButton.value = "Upload";
//         return;
//     }

//     var img = new Image();

//     img.onload = function() {
//         var canvas = document.createElement("canvas");
//         var context = canvas.getContext("2d");
//         context.drawImage(this, 0, 0);
//         var myData = context.getImageData(0, 0, this.width, this.height);
//         var text = OCRAD(myData);
//         alert(text);
//         window.location.reload();
//     };

//     img.src = URL.createObjectURL(file);



//     var formData = new FormData();

//     var xhr = new XMLHttpRequest();

//     xhr.open("POST", "/to_voice", true);

//     xhr.onload = function() {
//         if (xhr.status === 200) {
//             alert("Success!");
//             submitButton.value = "Upload";
//         } else {
//             alert("An error occurred :/");
//         }
//     };

//     xhr.send(formData);
// };
