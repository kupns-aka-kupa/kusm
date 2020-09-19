%include    "config.mac"

[bits 64]
            global          ENTRYPOINT

            extern          _strrev
            extern          _inplace_strrev
            extern          _strmirror
            extern          _print

            section         .bss

            struc           mytype
mt_long:    resd            1
mt_word:    resw            1
mt_byte:    resb            1
mt_str:     resb            32
            endstruc

            section         .data
massive:    dd              0x00, 0x01, 0x02, 0x03, 0x04, 0x05
string:     db              '1234567'

            section         .text

ENTRYPOINT:
            mov             rdi, string
            mov             rsi, 1
            call            _strmirror
            mov             rdi, string
            call            _print

            __exit__
