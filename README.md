# Data

name  |init |size|
------|-----|----|
byte  |db   |1   |
word  |dw   |2   |
dword |dd   |4   |
float |dq   |8   |
dfloat|dt   |10  |

### 128 :

xmm0 ... xmm15

### 64 :
reg|alias
---|-----
r0 |rax
r1 |rcx
r2 |rdx
r3 |rbx
r4 |rsp
r5 |rbp
r6 |rsi
r7 |rdi
r8 |-
...|-
r15|-


### 32 :

reg |alias
----|-----
r0d |eax
r1d |ecx 
r2d |edx
r3d |ebx 
r4d |esp
r5d |ebp
r6d |esi
r7d |edi
r8d |-
... |-
r15d|-

     
### 16 :

reg |alias
----|-----
r0w |ax
r1w |cx
r2w |dx
r3w |bx
r4w |sp
r5w |bp
r6w |si
r7w |di
r8w |-
... |-
r15w|-


### 8 :

reg |alias
----|-----
r0b |al
r1b |cl
r2b |dl
r3b |bl
r4b |spl
r5b |bpl
r6b |sil
r7b |dil
r8b |-
... |-
r15b|-

### 1 :

`ah`  

`ch` 

`dh`  

`bh`

### Calling

#### Function args:

|int \ *| float  |
|:-----:|:------:|
|  rdi  |  xmm0  |
|  rsi  |  xmm1  |
|  rdx  |  xmm2  |
|  rcx  |  xmm3  |
|  r8   |  xmm4  |
|  r9   |  xmm5  |
|       |  xmm6  |
|       |  xmm7  |

#### Stack args :
```
[rsp + 8]

[rsp + 12]

[rsp + 16]

...
```

##### Note :
The stack pointer `rsp` must be aligned to a 16-byte boundary before making a call, by 

```asm
push 0x08
or
sub rsp, 0x08
```
#### Registers preserve : 

`rbp`, `rbx`, `r12`, `r13`, `r14`, `r15`

#### Local vars :
```
[rsp - 8]

[rsp - 16]

[rsp - 24]

...
```



#### Return : 

`rax` or `rdx:rax`

`xmm0`
