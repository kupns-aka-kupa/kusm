%include    "config.mac"

[bits 64]
            global          _div

            section         .bss

            section         .text
; ==========================================
_div:
            enter           0, 0
            mov             rax, rdi
            mov             rdx, 0x00
            mov             rcx, rsi
            div             rcx
            leave
            ret

; ==========================================
