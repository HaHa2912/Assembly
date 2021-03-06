inchuoi macro chuoi         ; tao ham de in chuoi ra man hinh
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small     ; khai bao mo hinh loai nho
.stack 50        ; khai bao bien stack gom 50 phan tu
.data            ; khai bao bien/du lieu
    tb1 db 'Nhap ma SV: $'
    tb2 db 10,13,'Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    xdong db 10,13,'$'
    masv db 100,8,100 dup('$')
    masv1 db 'at160614'
    masv2 db 'AT160614'
    chuoi db 0,-2,10,-75,25,29,-35,-100,200
    tb4 db 10,13,'So phan tu am(-) la: $'
    am db 0 
    tb5 db 10,13,'So phan tu duong(+) la: $'
    duong db 0

.code
main proc        ; phan ham chinh
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    inchuoi tb1    ; in thong bao 1 ra man hinh
    lea si, masv    ; gan si la masv
    xor cx, cx      ; lam sach cx
    nhapmasv: 
        mov ah, 01h     ; nhap 1 ky tu
        int 21h
        mov [si], al     ; gan ky tu vua nhap vao gia tri si
        inc cx           ; tang cx, tang si len 1 don vi
        inc si
        cmp cx, 8        ; so sanh cx voi 8
        je sosanh         ; neu bang thi chuyen sang phan sosanh
        jmp nhapmasv      ;neu k bang th? quay lai nhapmasv

sosanh:
    cld ; chon chieu xu ly chuoi
    mov cx,8          ; so ky tu can so sanh la 8
    lea si, masv      ; gan dia chi nguon
    lea di, masv1      ; gan dia chi dich
    repe cmpsb        ; so sanh tung ky tu
    je intb2          ; neu bang thi chuyen intb2
    cld               ; neu k bang thi chon chieu xu ly chuoi
    mov cx, 8         ;
    lea si, masv
    lea di, masv2
    repe cmpsb
    je intb2          ; neu bang thi intb2
    inchuoi tb3
    inchuoi xdong       ; in tb3 ra man hinh
    jmp main         ; nhay den thoat
    
intb2:
    inchuoi tb2
    mov si, 0
    lap:
        cmp chuoi[si], 0
        je boqua
        jl soam
        inc duong
        inc si
        cmp si, 9
        je intb
        jmp lap

boqua:
    inc si
    cmp si, 9
    je intb
    jmp lap
    
soam:
    inc am
    inc si
    cmp si, 9
    je intb
    jmp lap

intb:
    inchuoi tb4
    mov ah, 0
    mov al, am
    call xuat
    inchuoi tb5
    mov ah, 0
    mov al, duong
    call xuat
            
thoat:
    mov ah, 08h      ; dung man hinh xem kq
    int 21h    
    mov ah, 4Ch      ; thoat chuong trinh
    main endp

xuat proc
    mov cx, 0
    mov bx, 10
    chuyen:
        xor dx, dx
        div bx
        add dl, 30h
        push dx
        inc cx
        cmp ax, 0
        je inmh 
        jmp chuyen
    inmh:
        pop dx
        mov ah, 02h
        int 21h
        loop inmh
    ret
    xuat endp

end main