.model small
.stack 100h

.data
welcomemsg db 0Dh, 0Ah
            db '**************************************************', 0Dh, 0Ah
            db '*                                                *', 0Dh, 0Ah
            db '*   WELCOME TO THE PARKING MANAGEMENT SYSTEM!    *', 0Dh, 0Ah
            db '*                                                *', 0Dh, 0Ah
            db '**************************************************', 0Dh, 0Ah, '$'

blank_line db 0Dh, 0Ah, '$'
separator db '--------------------------------------------------', 0Dh, 0Ah, '$'
menu db 0Dh, 0Ah, '==================== MENU ========================', 0Dh, 0Ah, '$'
menu1 db ' [1] Park Rikshaw in Zone A', 0Dh, 0Ah, '$'
menu2 db ' [2] Park Car in Zone B', 0Dh, 0Ah, '$'
menu3 db ' [3] Park Bus in Zone C', 0Dh, 0Ah, '$'
menu4 db ' [4] Show Parking Record', 0Dh, 0Ah, '$'
menu5 db ' [5] Delete All Records', 0Dh, 0Ah, '$'
menu6 db ' [6] Exit Program', 0Dh, 0Ah, '$'
msg1 db 0Dh, 0Ah, '------------', 0Dh, 0Ah, '!!! Sorry, Parking Is FULL. Please try later. !!!', 0Dh, 0Ah, '------------', 0Dh, 0Ah, '$'
msg2 db 0Dh, 0Ah, '------------', 0Dh, 0Ah, '*** Invalid Input! Please select a valid option. ***', 0Dh, 0Ah, '------------', 0Dh, 0Ah, '$'
msg7 db 0Dh, 0Ah, '------------', 0Dh, 0Ah, '>> Total Amount Collected: Rs. ','$'
msg8 db 0Dh, 0Ah, '>> Total Vehicles Parked: ','$'
msg9 db 0Dh, 0Ah, '>> Rikshaws Parked (Zone A): ','$'
msg10 db 0Dh, 0Ah, '>> Cars Parked (Zone B): ','$'
msg11 db 0Dh, 0Ah, '>> Buses Parked (Zone C): ','$'
msg12 db 0Dh, 0Ah, '------------', 0Dh, 0Ah, '--- All Records Deleted Successfully! ---', 0Dh, 0Ah, '------------', 0Dh, 0Ah, '$'
msg13 db 0Dh, 0Ah, '+++ Rikshaw parked in Zone A. Time Slot: ','$'
msg14 db 0Dh, 0Ah, '+++ Car parked in Zone B. Time Slot: ','$'
msg15 db 0Dh, 0Ah, '+++ Bus parked in Zone C. Time Slot: ','$'
slot1 db '[1] 09:00 AM - 10:00 AM', 0Dh, 0Ah, '$'
slot2 db '[2] 10:00 AM - 11:00 AM', 0Dh, 0Ah, '$'
slot3 db '[3] 01:00 PM - 02:00 PM', 0Dh, 0Ah, '$'
slot4 db '[4] 03:00 PM - 04:00 PM', 0Dh, 0Ah, '$'

amount dw 0
count db 0
r db 0
c db 0
b db 0
MAX_CAPACITY dw 15
time_slot db ?
enter_msg db 'Press ENTER to continue...', 0Dh, 0Ah, '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov dx, offset welcomemsg
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h

while_:
    mov dx, offset menu
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h

    mov dx, offset menu1
    mov ah, 09h
    int 21h
    mov dx, offset menu2
    mov ah, 09h
    int 21h
    mov dx, offset menu3
    mov ah, 09h
    int 21h
    mov dx, offset menu4
    mov ah, 09h
    int 21h
    mov dx, offset menu5
    mov ah, 09h
    int 21h
    mov dx, offset menu6
    mov ah, 09h
    int 21h
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al

    cmp al, '1'
    je call_rikshaw
    cmp al, '2'
    je call_car
    cmp al, '3'
    je call_bus
    cmp al, '4'
    je call_recrd
    cmp al, '5'
    je call_delt
    cmp al, '6'
    je end_

    mov dx, offset msg2
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    jmp while_

call_rikshaw:
    call select_time
    call rikshaw
    call clear_screen
    jmp while_

call_car:
    call select_time
    call caar
    call clear_screen
    jmp while_

call_bus:
    call select_time
    call buss
    call clear_screen
    jmp while_

call_recrd:
    call recrd
    call clear_screen
    jmp while_

call_delt:
    call delt
    call clear_screen
    jmp while_

end_:
    mov ah, 4ch
    int 21h
main endp

select_time proc
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset slot1
    mov ah, 09h
    int 21h
    call newline
    mov dx, offset slot2
    mov ah, 09h
    int 21h
    call newline
    mov dx, offset slot3
    mov ah, 09h
    int 21h
    call newline
    mov dx, offset slot4
    mov ah, 09h
    int 21h
    call newline
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov time_slot, al
    ret
select_time endp

print_time proc
    cmp time_slot, 1
    je show1
    cmp time_slot, 2
    je show2
    cmp time_slot, 3
    je show3
    cmp time_slot, 4
    je show4
    ret
show1:
    mov dx, offset slot1
    jmp show_common
show2:
    mov dx, offset slot2
    jmp show_common
show3:
    mov dx, offset slot3
    jmp show_common
show4:
    mov dx, offset slot4
show_common:
    mov ah, 09h
    int 21h
    call newline
    mov dx, offset separator
    mov ah, 09h
    int 21h
    call newline
    ret
print_time endp

rikshaw proc
    mov al, count
    xor ah, ah
    cmp ax, MAX_CAPACITY
    jl continue_rikshaw

    mov dx, offset msg1
    mov ah, 09h
    int 21h
    jmp end_rikshaw

continue_rikshaw:
    mov ax, 200
    add amount, ax
    inc count
    inc r
    mov dx, offset msg13
    mov ah, 09h
    int 21h
    call print_time

end_rikshaw:
    ret
rikshaw endp

caar proc
    mov al, count
    xor ah, ah
    cmp ax, MAX_CAPACITY
    jl continue_caar

    mov dx, offset msg1
    mov ah, 09h
    int 21h
    jmp end_caar

continue_caar:
    mov ax, 300
    add amount, ax
    inc count
    inc c
    mov dx, offset msg14
    mov ah, 09h
    int 21h
    call print_time

end_caar:
    ret
caar endp

buss proc
    mov al, count
    xor ah, ah
    cmp ax, MAX_CAPACITY
    jl continue_buss

    mov dx, offset msg1
    mov ah, 09h
    int 21h
    jmp end_buss

continue_buss:
    mov ax, 400
    add amount, ax
    inc count
    inc b
    mov dx, offset msg15
    mov ah, 09h
    int 21h
    call print_time

end_buss:
    ret
buss endp

recrd proc
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset msg7
    mov ah, 09h
    int 21h
    mov ax, amount
    call print_number
    call newline
    mov dx, offset msg8
    mov ah, 09h
    int 21h
    mov al, count
    xor ah, ah
    call print_number
    call newline
    mov dx, offset msg9
    mov ah, 09h
    int 21h
    mov al, r
    xor ah, ah
    call print_number
    call newline
    mov dx, offset msg10
    mov ah, 09h
    int 21h
    mov al, c
    xor ah, ah
    call print_number
    call newline
    mov dx, offset msg11
    mov ah, 09h
    int 21h
    mov al, b
    xor ah, ah
    call print_number
    call newline
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    ret
recrd endp

delt proc
    mov amount, 0
    mov count, 0
    mov r, 0
    mov c, 0
    mov b, 0

    mov dx, offset msg12
    mov ah, 09h
    int 21h
    ret
delt endp

print_number proc
    push ax
    mov cx, 0
    mov bx, 10

convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convert_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop

    pop ax
    ret
print_number endp

newline proc
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    ret
newline endp

clear_screen proc
    ; Prompt for Enter
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset separator
    mov ah, 09h
    int 21h
    mov dx, offset blank_line
    mov ah, 09h
    int 21h
    mov dx, offset enter_msg
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    cmp al, 0Dh ; Enter key
    jne skip_clear
    ; Clear screen using DOS interrupt
    mov ah, 0
    mov al, 3
    int 10h
skip_clear:
    ret
clear_screen endp

end main