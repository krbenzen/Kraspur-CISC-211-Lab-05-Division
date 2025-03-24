/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Benzen Raspur"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    /*Copying the inputs from register to memory*/
    ldr   r4, =dividend   
    str   r0, [r4]        /*dividend = r0*/
ldr   r4,=divisor        
    str   r1, [r4]        /*divisor = r1*/

   
    /*Initialize all of them to be = 0*/
    ldr   r4, =quotient
    mov   r5, #0
    str   r5, [r4]            
    ldr   r4, =mod
    str   r5, [r4]            
    ldr   r4, =we_have_a_problem
    str   r5, [r4]            

   
    /*Check for if r0 = 0 OR r1 = 0  errors*/
    cmp   r0, #0          /*if equal to 1*/
    beq   is_error
    cmp   r1, #0          /*if equal to 0*/
    beq   is_error

   
    /*Repeated subtraction*/
    mov   r2, #0              
    mov   r3, r0              

divide_loop:
    cmp   r3, r1          /*compare remainder divisor*/ 
    blo   finished           
    sub   r3, r3, r1          
    add   r2, r2, #1      /*quotient++*/ 
    b     divide_loop

finished:
 
    /*Store results and sets r0. Branch to done*/
    ldr   r4, =quotient
    str   r2, [r4]            @ quotient in memory
    ldr   r4, =mod
    str   r3, [r4]            @ mod in memory
    /*we_have_a_problem should stay 0*/
    mov   r0, r2              @ function return value = quotient
    b     done

is_error:
  
    /* Error we_have_a_problem = 1, r0 =quotient*/

    ldr   r4, =we_have_a_problem
    mov   r5, #1
    str   r5, [r4]          
    ldr   r0, = quotient     
    b     done

    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




