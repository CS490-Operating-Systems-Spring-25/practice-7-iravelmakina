.section .data
    prompt_message:
        .asciz "Enter a line of up to 16 symbols (e.g., 'yybb'): "

    color_codes:
        .asciz "\033[40m"            // black
        .asciz "\033[41m"            // red
        .asciz "\033[42m"            // green
        .asciz "\033[44m"            // blue
        .asciz "\033[43m"            // yellow
        .asciz "\033[47m"            // white
        .asciz "\033[46m"            // cyan
        .asciz "\033[45m"            // magenta
    reset_code:
        .asciz "\033[0m"             // reset color

    new_line:
        .asciz "\n"

    symbol:
        .asciz ":::"

.section .bss
    input_buffer: 
        .skip 16  // Reserve 16 bytes for input buffer

    flush_buffer:
        .skip 1   // Reserve 1 byte for flush buffer

.section .text
    .global _start

_start:
    // Print the prompt message
    mov x0, #1               // stdout
    ldr x1, =prompt_message  // Load address of prompt message
    mov x2, #49              // Length of prompt message
    mov x8, #64              // Syscall write
    svc #0

    // Read user input (up to 16 characters)
    mov x0, #0               // stdin
    ldr x1, =input_buffer    // Load address of input buffer
    mov x2, #16              // Max length (16 bytes)
    mov x8, #63              // Syscall read
    svc #0
    mov x5, x0               // Store the number of bytes read in x5 

    // If last character is '\n', trim it from x5
    subs x6, x5, #1            // Bytes read - 1 to get the index of the last character in the input
    blt skip_trim_and_flush    // If x5 < 1 (no characters read), skip trimming and flushing

    ldr x1, =input_buffer      // Load the address of the input buffer into x1
    add x1, x1, x6             // Calculate the address of the last character
    ldrb w7, [x1]              // Load the last character into w7 (1 byte)

    cmp w7, #10                // Compare the last character with '\n'
    bne skip_trim_and_flush    // If the last character is not '\n', skip trimming and flushing

    subs x5, x5, #1            // If the last character is '\n', reduce the count of bytes read (x5) by 1
    b skip_flush_loop          // Skip the flush loop since the input is already trimmed

skip_trim_and_flush:
    cmp x5, #16
    blt skip_flush_loop        // If less than 16 bytes, skip flush loop

flush_loop:
    mov x0, #0               // stdin
    ldr x1, =flush_buffer    // Load address of flush buffer
    mov x2, #1               // Max length (1 byte)
    mov x8, #63              // Syscall read
    svc #0

    cmp x0, #1               // Check if we read 1 byte
    bne skip_flush_loop      // If not, skip the flush loop

    ldr x1, =flush_buffer
    ldrb w6, [x1]            // Load the byte read into w6
    cmp w6, #10              // Compare with newline character
    bne flush_loop           // If not newline, continue flushing
skip_flush_loop:
  
    // Iterate through the input and map each character to its corresponding color escape code
    mov x3, #0               // Start with the first byte of the input buffer

map_input_to_colors:
    cmp x3, x5               // Check if we processed all bytes
    beq done_mapping         // If null byte, stop the mapping

    ldr x19, =input_buffer   // Load the address of the input buffer
    add x19, x19, x3         // Calculate the address of the current character
    ldrb w5, [x19]           // Load the current character into w5

    cmp w5, #10              // Check if the character is null (EOF)
    beq done_mapping         // If null byte, stop the mapping

    // Map the color code based on input character
    bl color_mapping         // Get the corresponding color escape code

    mov x0, #1               // stdout
    mov x2, #5               // Max length of escape code (e.g., "\033[40m" is 5 bytes)
    mov x8, #64              // Syscall write
    svc #0

    mov x0, #1               // stdout
    mov x2, #3               // Max length of symbol (e.g., ":::" is 3 bytes)
    ldr x1, =symbol          // Load symbol string
    mov x8, #64              // Syscall write
    svc #0

    mov x0, #1               // stdout
    ldr x1, =reset_code      // Load the reset escape code
    mov x2, #4               // Max length of reset code (e.g., "\033[0m" is 4 bytes)
    mov x8, #64              // Syscall write
    svc #0

continue:
    // Increment index and loop
    add x3, x3, #1           // Move to the next byte of the input
    b map_input_to_colors    // Loop again

done_mapping:
    // Print a newline after the color codes
    mov x0, #1               // stdout
    ldr x1, =new_line        // Load the newline string
    mov x2, #1               // Max length of newline string (e.g, "\n" is 1 byte)
    mov x8, #64              // Syscall write
    svc #0

    // Exit the program
    mov x0, #0               // Exit code 0
    mov x8, #93              // Syscall exit
    svc #0

// Color Mapping
color_mapping:
    cmp w5, #'B'             // Compare with 'B' (Black)
    beq black_color
    cmp w5, #'r'             // Compare with 'r' (Red)
    beq red_color
    cmp w5, #'g'             // Compare with 'g' (Green)
    beq green_color
    cmp w5, #'b'             // Compare with 'b' (Blue)
    beq blue_color
    cmp w5, #'y'             // Compare with 'y' (Yellow)
    beq yellow_color
    cmp w5, #'w'             // Compare with 'w' (White)
    beq white_color
    cmp w5, #'c'             // Compare with 'c' (Cyan)
    beq cyan_color
    cmp w5, #'m'             // Compare with 'm' (Magenta)
    beq magenta_color
    b continue               // If no match, continue to the next character

black_color:
    ldr x1, =color_codes     // Load the black color code into x1
    ret

red_color:
    ldr x1, =color_codes+6   // Load the red color code into x1 (6 bytes offset)
    ret

green_color:
    ldr x1, =color_codes+12  // Load the green color code into x1 (12 bytes offset)
    ret

blue_color:
    ldr x1, =color_codes+18  // Load the blue color code into x1 (18 bytes offset)
    ret

yellow_color:
    ldr x1, =color_codes+24  // Load the yellow color code into x1 (24 bytes offset)
    ret

white_color:
    ldr x1, =color_codes+30  // Load the white color code into x1 (30 bytes offset)
    ret

cyan_color:
    ldr x1, =color_codes+36  // Load the cyan color code into x1 (36 bytes offset)
    ret

magenta_color:
    ldr x1, =color_codes+42  // Load the magenta color code into x1 (42 bytes offset)
    ret
