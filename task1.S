.section .data
    buffer: 
        .fill 256, 1, 0  // Allocate a 256-byte buffer and initialize it to 0
    filename:
        .asciz "asm.sh"  // Define the filename as "task1.md"
    newline:
        .asciz "\n"        // Define a newline character for output formatting
    error_message:
        .asciz "Error: Failed to open the file\n"  // Error message to print if the file cannot be opened


.section .text
    .global _start  // Define the global entry point for the program

_start:
    // Step 1: Get the current directory using getcwd syscall (17)
    ldr x0, =buffer      // Load the address of the buffer (where the directory will be stored)
    mov x1, #256         // Set the size of the buffer (256 bytes)
    mov x8, #17          // Syscall number for getcwd (17)
    svc #0               // Make the syscall to get the current directory

    // Step 2: Print the directory path using write syscall (64)
    mov x0, #1           // File descriptor for standard output (stdout)
    ldr x1, =buffer      // Load the address of the buffer (containing the current directory)
    mov x2, #256         // Set the number of bytes to write (256 bytes)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Make the syscall to write the directory to stdout

    // Step 2.1: Print a newline using write syscall (64)
    mov x0, #1           // File descriptor for standard output (stdout)
    ldr x1, =newline     // Load the address of the newline string
    mov x2, #1           // Set the number of bytes to write (1 byte for newline)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Make the syscall to print the newline

    // Step 3: Open a file using openat syscall (56)
    mov x0, #-100        // dfd = AT_FDCWD (current directory) for openat
    ldr x1, =filename    // Load the address of the filename ("task1.md")
    mov x2, #0           // O_RDONLY (read-only) flag
    mov x3, #0           // Mode: not needed for read-only (set to 0)
    mov x8, #56          // Syscall number for openat (56)
    svc #0               // Make the syscall to open the file
    mov x19, x0          // Save the returned file descriptor in x19

    // Step 3.1: Check if the file was opened successfully
    cmp x19, #0          // Compare the file descriptor with 0
    blt print_error       // If less than 0, branch to error handling

    // Step 4: Read a line from the file using read syscall (63)
    mov x0, x19          // Load the file descriptor (from x19) into x0 (arg0)
    ldr x1, =buffer      // Load the address of the buffer to store the data (arg1)
    mov x2, #256         // Set the number of bytes to read (256 bytes) (arg2)
    mov x8, #63          // Syscall number for read (63)
    svc #0               // Make the syscall to read from the file into the buffer

    // Step 5: Write the read line to stdout using write syscall (64)
    ldr x1, =buffer      // Load the address of the buffer into x1 (arg1)
    mov x2, x0           // The number of bytes read is now in x0 (arg2)
    mov x0, #1           // File descriptor for stdout (1) (arg0)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Perform the syscall to write the buffer contents to stdout

    // Step 5.1: Print a newline using write syscall (64)
    mov x0, #1           // File descriptor for standard output (stdout)
    ldr x1, =newline     // Load the address of the newline string
    mov x2, #1           // Set the number of bytes to write (1 byte for newline)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Make the syscall to print the newline

    // Step 6: Change file permissions using chmod syscall (52)
    mov x0, x19          // Load the file descriptor into x0 (arg0)
    mov x1, #0755        // Set the permissions to rwxr-xr-x (arg1)
    mov x8, #52          // Syscall number for chmod (52)
    svc #0               // Make the syscall to change the file permissions

    // Step 7: Change the file owner/group using chown syscall (55)
    mov x0, x19          // Load the file descriptor into x0 (arg0)
    mov x1, #1000        // Set the user ID to 1000 (arg1)
    mov x2, #1000        // Set the group ID to 1000 (arg2)
    mov x8, #55          // Syscall number for chown (55)
    svc #0               // Make the syscall to change the file owner/group

    // Step 8: Close the file using close syscall (57)
    mov x0, x19          // Load the file descriptor into x0 (arg0)
    mov x8, #57          // Syscall number for close (57)
    svc #0               // Perform the syscall to close the file

    b exit              // Branch to exit

print_error:
    // Print the error message to stderr (file descriptor 2)
    mov x0, #2           // File descriptor for stderr (2)
    ldr x1, =error_message // Load the address of the error message
    mov x2, #31          // Set the number of bytes to write (length of error message)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Make the syscall to print the error message

    // Print the error code (file descriptor 2)
    mov x0, #2           // File descriptor for stderr (2)
    mov x1, x19
    mov x2, #4         // Set the number of bytes to write (256 bytes)
    mov x8, #64          // Syscall number for write (64)
    svc #0               // Make the syscall to print the error code

exit:
    // Step 9: Exit the program with exit code 1
    mov x0, #1           // Exit status code 1 (arg0)
    mov x8, #93          // Syscall number for exit (93)
    svc #0               // Perform the syscall to exit the program with code 1
