import pkg ::*;

program test(fifo_if inf);
  
  environment env;
  
  initial begin
    env=new(inf);
    env.build();
    env.run();
  end
  
endprogram
