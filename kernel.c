void kernel_main(void) {
    const char *message = "Hello my OS!";
    char *video_memory = (char *) 0xb8000;

    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];
        video_memory[i * 2 + 1] = 0x07;
    }

    while (1);  // this infinate loop will keep it running
}
