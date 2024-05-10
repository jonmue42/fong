module ball
        use, intrinsic :: iso_c_binding
        use :: raylib
        implicit none
        private
        public :: draw_ball, move_ball, detect_collision

        integer, bind(c) :: speed(2) = [300, 300]

        
contains
        subroutine draw_ball(position)
                integer, intent(in) :: position(2)
                call draw_circle(position(1), position(2), 50.0, BLUE)
        end subroutine draw_ball
        
        subroutine move_ball(position, miss_counter)
                integer :: position(2)
                integer, intent(inout) :: miss_counter
                if ( position(2) <= 0 + 50 ) then
                        speed(2) = -speed(2)
                        position(2) = 0 + 50
                else if ( position(2) >= 450 - 50) then
                        speed(2) = -speed(2)
                        position(2) = 450 - 50
                end if

                if ( position(1) <= 0 + 50 ) then
                        speed(1) = -speed(1)
                        position(1) = 600
                        miss_counter = miss_counter + 1
                        print *, "collision with left wall"
                else if ( position(1) >= 800 - 50 ) then
                        speed(1) = -speed(1)
                        position(1) = 800 - 50
                end if
                position(2) = position(2) + speed(2)*get_frame_time()
                position(1) = position(1) + speed(1)*get_frame_time()
        end subroutine move_ball

        subroutine detect_collision(position, position_target, hit_counter)
                integer, intent(in) :: position(2)
                integer, intent(in) :: position_target(2)
                integer, intent(inout) :: hit_counter

                if ( position(1) <= position_target(1) + 100 ) then
                        if ( (position(2) <= position_target(2) + 100) .and. (position(2) >= position_target(2)) ) then
                                speed(1) = -speed(1)
                                hit_counter = hit_counter + 1
                        end if
                end if

        end subroutine detect_collision
      
end module ball
