        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main   
        MOV R0,#0x55 ;Carrega R0 com 0x55
        MOV R1,R0, LSL #16 ;Logical Shift Left, R0 em 16 bits e armazena em R1
        MOV R2,R1, LSR #8 ;Logical Shift Right, R1 em 8 bits e armazena em R2
        MOV R3,R2, ASR #4 ;Arithimetical Shift Right, R2 em 4 bits e armazena em R3
        MOV R4,R3, ROR #2 ;Rotate Right, R3 em 2 bits e armazena em R4
        MOV R5,R4, RRX    ;Rotate Right with Extension, R4 em #1 bit, levando em conta o Carry e armazena em R5

        MVN R0,#0x55 ;Carrega R0 com ~0x55
        MVN R1,R0, LSL #16 ;Logical Shift Left, R0 em 16 bits e armazena negado em R1
        MVN R2,R1, LSR #8 ;Logical Shift Right, R1 em 8 bits e armazena negado em R2
        MVN R3,R2, ASR #4 ;Arithimetical Shift Right, R2 em 4 bits e armazena negado em R3
        MVN R4,R3, ROR #2 ;Rotate Right, R3 em 2 bits e armazena negado em R4
        MVN R5,R4, RRX    ;Rotate Right with Extension, R4 em #1 bit, levando em conta o Carry e armazena negado em R5
fim:    B fim

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
