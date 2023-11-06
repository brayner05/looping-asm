.section .data
max:
	.byte 1

acc:
	.byte 1

msg:
	.string "Hello, World!\n"

.section .text
.globl _start

_start:
	movb $0, acc
	movb $10, max

_loop:
	# If acc >= max, exit the loop
	movb acc, %al
	movb max, %bl
	cmp %bl, %al
	jge _exit
	
	# Print the message to the terminal
	call _greet
	
	# Increment acc
	movb acc, %al
	incb %al
	movb %al, acc
	jmp _loop

_greet:

	movl $4, %eax
	movl $1, %ebx
	movl $msg, %ecx
	movl $14, %edx
	int $0x80
	ret

_exit:
	movl $1, %eax		# Invoke sys_exit()
	xor %ebx, %ebx		# Set exit code to 0
	int $0x80		# Invoke syscall
