;;defer.asm

%define  MAX_DEFER_FUNC 10 
%define SYS_WRITE       4 
%define STDOUT_FILENO   1 
%define SYSCALL         0x80

SECTION .text 
    global Defer 
    global ReturnDef
Defer :
    push ebp 
    mov ebp ,esp 
    mov eax, [ebp + 8] 
    mov esi, [stack_counter] 
    mov edi, defer_stack 
    mov [edi + esi * 4] , eax
    inc esi 
    cmp esi , MAX_DEFER_FUNC 
    jge .ignore
    mov DWORD[stack_counter] , esi 
    pop ebp 
    ret 
.ignore:
    mov eax, SYS_WRITE 
    mov ebx, STDOUT_FILENO 
    mov ecx, msg 
    mov edx, msgLen 
    int SYSCALL  
    pop ebp 
    ret 

ReturnDef:
    push ebp 
    mov ebp ,esp 
    mov edi ,defer_stack 
    mov esi ,[stack_counter] 
    dec esi 
.again:
    cmp esi , 0 
    js .over
    mov eax, [edi  + esi * 4] 
;    pusha
    call eax 
;    popa
    dec esi 
    jmp .again
.over:
    xor eax, eax 
    pop ebp 
    ret 

SECTION .data 
    msg     :db "SURPASSED_limit of deferred functions",0,0xa
    msgLen  : equ $ - msg 
SECTION .bss 
    defer_stack    : resb 1024 
    stack_counter  : resd 1 
