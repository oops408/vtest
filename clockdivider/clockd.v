module clock_divider(
  input wire clk_in,
  output reg clk_out
);

  parameter DIV_FACTOR = 5;

  reg [31:0] counter = 0;

  always @(posedge clk_in) begin
    counter <= counter + 1;
    if (counter == (2**31)/DIV_FACTOR) begin
      counter <= 0;
      clk_out <= ~clk_out;
    end
  end

endmodule
