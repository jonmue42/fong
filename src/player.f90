module player
        use, intrinsic :: iso_c_binding
        use :: raylib
        implicit none
        private
        public draw_player, move_player

        integer, bind(c) :: dy = 1000

        
contains
        subroutine draw_player(position)
                integer, intent(in) :: position(2)
                call draw_rectangle(position(1), position(2), 50, 100, RED)
        end subroutine draw_player
        
        subroutine move_player(position)
                integer :: position(2)
                if (is_key_down(KEY_UP) .and. position(2) >= 0) then
                        position(2) = position(2) - dy*get_frame_time()
                end if
                if (is_key_down(KEY_DOWN) .and. position(2) <= 450 - 100) then
                        position(2) = position(2) + dy*get_frame_time()
                end if
                
        end subroutine move_player
      
end module player
