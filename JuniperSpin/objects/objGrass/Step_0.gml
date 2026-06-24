if (place_meeting(x, y, objGuy)) {
    touched = true;
    image_speed = defaultSpeed;
} else {
    if (touched) {
        image_speed = 0;
        image_index -= defaultSpeed; // Reverse animation speed.
        if (image_index <= 0) {
            image_index = 0;
            touched = false;
        }
    }
}