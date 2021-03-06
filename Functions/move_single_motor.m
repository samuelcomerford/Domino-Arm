function move_single_motor (id, goal_pos)
%Instead of having to take angle and ID for all motors and keeping them in
%sync, simply takes angle and ID for one motor.
%% Main Code
axratio = 3.41;
mxratio = 11.375;
%Check which motor is to be moved and use appropriate conversion from angle
%to motor input (then move that motor)
 if (id==4)
        dyna_degrees = (goal_pos)*mxratio;
        calllib('dynamixel', 'dxl_write_word', id, 32, 40);
        calllib('dynamixel','dxl_write_word', id, 30, dyna_degrees);
 elseif (id==3)
        dyna_degrees = (goal_pos-30)*axratio;
        calllib('dynamixel', 'dxl_write_word', id, 32, 80);
        calllib('dynamixel','dxl_write_word', id, 30, dyna_degrees);
 else
        dyna_degrees = (goal_pos-30)*axratio;
        calllib('dynamixel', 'dxl_write_word', id, 32, 50);
        calllib('dynamixel','dxl_write_word', id, 30, dyna_degrees);
 end
%Wait for the motor to finish moving then end function
while (1)
    moving_1 = calllib('dynamixel','dxl_read_word', 1, 46);
    moving_2 = calllib('dynamixel','dxl_read_word', 2, 46);
    moving_3 = calllib('dynamixel','dxl_read_word', 3, 46);
    moving_4 = calllib('dynamixel','dxl_read_word', 4, 46);
    moving = [moving_1, moving_2, moving_3, moving_4];
    if max(moving) == 0
        break
    end
end
end