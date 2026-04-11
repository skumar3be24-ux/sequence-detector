`timescale 1ns/1ps

module tb_seq_1011_detector;

    reg btn_clk;
    reg reset;
    reg x;
    wire z;
    wire [3:0] led;

    seq_1011_detector DUT (
        .btn_clk(btn_clk),
        .reset(reset),
        .x(x),
        .z(z),
        .led(led)
    );

    task pulse_clk;
        begin
            btn_clk = 1; #5;
            btn_clk = 0; #5;
        end
    endtask

    initial begin
        btn_clk = 0;
        reset   = 1;
        x       = 0;

        #10 reset = 0;

        x = 1; pulse_clk();
        x = 0; pulse_clk();
        x = 1; pulse_clk();
        x = 1; pulse_clk();   // z should go HIGH here
        x = 0; pulse_clk();
        x = 1; pulse_clk();
        x = 1; pulse_clk();

        #20 $stop;
    end

endmodule
