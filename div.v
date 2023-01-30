module tb_divider;
  reg [31:0] dividend, divisor;
  wire [31:0] quotient;
  divider dut (dividend, divisor, quotient);

  initial begin
    dividend = 32'h0000_000F;
    divisor = 4'h2;
    #10;
    $display("Dividend: %h, Divisor: %h, Quotient: %h", dividend, divisor, quotient);
    dividend = 32'h0000_0010;
    divisor = 4'h2;
    #10;
    $display("Dividend: %h, Divisor: %h, Quotient: %h", dividend, divisor, quotient);
  end
endmodule
