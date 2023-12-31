// kernel.c - Hello, World! in C

void print_hello() {
    // Video memory address
    char *video_memory = (char *)0xb8000;

    // Attribute byte (light gray on black)
    char attribute_byte = 0x0F;

    // Message to be displayed
    char *hello = "Hello, World!";

    // Display the message on the screen
    for (int i = 0; i < 13; i++) {
        video_memory[i * 2] = hello[i];
        video_memory[i * 2 + 1] = attribute_byte;
    }
}

void kernel_main() {
    // Call the function to print "Hello, World!"
    print_hello();

    // Loop indefinitely
    while (1) {
        // This could be expanded with more functionality
    }
}
