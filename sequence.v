module seq_1011_detector (
    input  wire btn_clk,
    input  wire reset,
    input  wire x,
    output reg  z,
    output reg [3:0] led
);

    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10,
               S3 = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge btn_clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S3 : S0;
            S3: next_state = x ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        z = (state == S3 && x);
    end

    always @(posedge btn_clk or posedge reset) begin
        if (reset)
            led <= 4'b0000;
        else
            led <= {led[2:0], x};
    end

endmodule