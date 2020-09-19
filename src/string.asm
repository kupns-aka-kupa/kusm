%include    "config.mac"
[bits 64]

            global          _strrev
            global          _itoa
            global          _strmirror
            global          _strcopy
            global          _inplace_strrev
            global          _print

            extern          _div

            section         .bss
buf:        resb            1b << 6

            section         .text

; ==========================================

_inplace_strrev:
            enter           0, 0
            call            _strlen
            mov             rsi, rdi
            add             rsi, rax
            dec             rsi
            shr             rax, 1
.loop:
            mov             bl, [rsi]
            mov             bh, [rdi]
            mov             [rsi], bh
            mov             [rdi], bl
            dec             rsi
            inc             rdi
            dec             rax
            jnz             .loop
.end:
            leave
            ret

; ==========================================

_strcopy:
            enter           0, 0
            call            _strlen
            mov             rdx, 0x00
            mov             rcx, rdi
.while:
            cmp             rax, rdx
            jl              .end

            mov             r8, [rcx + rdx]
            mov             [buf + rdx], r8

            inc             rdx
            jmp             .while
.end:
            mov             rax, buf
            leave
            ret

; ==========================================
;           ARGS
;           rdi             str pointer
;           rsi             [0 || 1]
;
;           rsi == 0        left mirroring
;              \
;               == 1        right mirroring

_strmirror:
            enter           0, 0
            call            _strlen
            mov             rcx, rsi

            mov             rsi, rdi
            add             rsi, rax
            dec             rsi
            shr             rax, 1

            dec             rcx
            jz             .lmirror
.rmirror:
            mov             bh, [rdi]
            mov             [rsi], bh

            dec             rsi
            inc             rdi
            dec             rax
            loopnz          .rmirror
            jmp             .end
.lmirror:
            mov             bl, [rsi]
            mov             [rdi], bl
            dec             rsi
            inc             rdi
            dec             rax
            loopnz          .lmirror
.end:
            leave
            ret

; ==========================================

_itoa:
            enter           0, 0
            mov             ebx, 0xCCCCCCCD
            xor             rdi, rdi

.loop:
            mov             ecx, eax

            mul             ebx
            shr             edx, 3

            mov             eax, edx

            lea             edx, [edx * 5]
            shl             rdi, 8
            lea             edx, [edx * 2 - '0']
            sub             ecx, edx

            lea             rdi, [rdi + rcx]

            test            eax, eax
            jnz             .loop

            leave
            ret

; ==========================================

_strrev:
            enter           0, 0
            call            _strlen
            mov             rdx, 0x00
            mov             rcx, rdi
.while:
            cmp             rax, rdx
            jl              .end

            lea             rbx, [rcx + rax - 1]
            sub             rbx, rdx

            mov             r8, [rbx]
            mov             [buf + rdx], r8

            inc             rdx
            jmp             .while
.end:
            mov             rax, buf
            leave
            ret

; ==========================================

_strlen:
            enter           0, 0
            mov             rax, 0x00
            mov             rcx, rdi
.while:
            cmp             byte [rcx], 0x00
            je              .end
            inc             rax
            inc             rcx
            jmp             .while
.end:
            leave
            ret

; ==========================================

_print:
            enter           0, 0
            call            _strlen
            mov             rdx, rax
            mov             rsi, rdi
            mov             rdi, 1
            mov             rax, SYSCALL_WRITE
            syscall
            leave
            ret

; ==========================================
