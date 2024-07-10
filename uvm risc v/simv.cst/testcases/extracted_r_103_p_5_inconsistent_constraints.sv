class c_103_5;
    rand bit[11:0] rv_si_imm_field; // rand_mode = ON 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (riscv_sequence.sv:32)
    {
       (rv_si_imm_field > 32'he0000000);
    }
endclass

program p_103_5;
    c_103_5 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzz1z0zzx0zxx011zxxx1xz0xx0z10zzzzzxxzzxxzzxzzzzxxzxzxxxzzzxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
