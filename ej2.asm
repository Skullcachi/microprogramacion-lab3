.MODEL small
.DATA
NUM1 DB ?
NUM2 DB ?
NSUMA DB 0
NRESTA DB 0
NMULT DB 0
NDIV DB 0
NMOD DB 0
C1 DB "Ingrese el primer numero: $"
C2 DB "Ingrese el segundo numero: $"
C3 DB "cadena$"
CMAYOR DB "MAYOR$"
CMENOR DB "MENOR$"
CIGUAL DB "IGUALES$"
CSUMA DB "suma: $"
CRESTA DB "resta: $"
CMULT DB "multiplicacion: $"
CDIV DB "division: $"
CMOD DB "residuo: $"
.code
ej2:
;iniciar programa
    MOV AX, @DATA   ; se obtiene la direccion de inicio del segmento de datos
    MOV DS, AX      ; asignamos al registro data segment la direccion de inicio de segmento
        
        XOR AX,AX
        XOR DX,DX
    ;OBTENCION DE NUMEROS
    MOV AH, 09H
    LEA DX, C1
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30h
    MOV NUM1, AL
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
        XOR AX,AX
        XOR DX,DX
     
    MOV AH, 09H
    LEA DX, C2
    INT 21h
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV NUM2, AL
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
    
    ;OPERACION DE SUMA             
    MOV AL, NUM1
    ADD AL, NUM2
    mov NSUMA, AL  
    
    ;OPERACION DE RESTA
    MOV AL, NUM1
    SUB AL, NUM2
    MOV NRESTA, AL
    
    ;OPERACION DE MULTIPLICACION
    
    MOV AL, 0H 
    XOR CL, CL
    MOV CL, 0H
    
    MULTIPLICACION:
    CMP CL, NUM2
    JE MULTEND
    ADD AL, NUM1
    ADD CL, 1H
    JMP MULTIPLICACION
    
    MULTEND:
    MOV NMULT, AL
    
    ;DIVISION Y MODULO
    MOV AL, NUM1
    XOR CL, CL
    MOV CL, 0H
    
    DIVISION:
    CMP AL, NUM2
    JL DIVISIONEND
    SUB AL, NUM2
    ADD CL, 1H
    JMP DIVISION  
    
    DIVISIONEND:
    MOV NDIV, CL
    MOV NMOD, AL
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
    ;RESULTADO SUMA
    MOV AH,09
    LEA DX,CSUMA
    INT 21h
    MOV DL,NSUMA
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
    ;RESULTADO RESTA
    MOV AH,09
    LEA DX,CRESTA
    INT 21h
    MOV DL,NRESTA
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
    ;RESULTADO MULTIPLICACION
    MOV AH,09
    LEA DX,CMULT
    INT 21h
    MOV DL,NMULT
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    
    ;RESULTADO DIVISION
    MOV AH,09
    LEA DX,CDIV
    INT 21h
    MOV DL,NDIV
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
                
    ;RESULTADO MODULO    
    MOV AH,09
    LEA DX, CMOD
    INT 21h
    MOV DL, NMOD
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    
    ;imprimir nueva linea
    MOV DL, 10
    MOV AH, 02h
    INT 21H
    JMP COMPARACION
    
    ;COMPARACIONES
    
    IGUALES:
    MOV DX, OFFSET CIGUAL
    MOV AH, 09H
    int 21H
    JMP FINALIZAR
    
    MAYOR:
    MOV DX, OFFSET CMAYOR
    MOV AH, 09H
    INT 21H
    JMP FINALIZAR
    
    MENOR:
    MOV DX, OFFSET CMENOR
    MOV AH, 09H
    INT 21H
    JMP FINALIZAR
    
    COMPARACION:
    MOV AL, NUM1
    CMP AL, NUM2
    JE IGUALES
    JS MENOR
    JMP MAYOR
    
    FINALIZAR:
    MOV AH, 4CH
    INT 21H
        
    
.stack
end ej2