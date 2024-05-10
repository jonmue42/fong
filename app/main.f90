! example.f90
program main
    use, intrinsic :: iso_c_binding, only: c_null_char
    use :: raylib
    use :: player
    use :: ball
    implicit none (type, external)

    integer, parameter :: SCREEN_WIDTH  = 800
    integer, parameter :: SCREEN_HEIGHT = 450
    integer :: position_player(2) = [0, 0]
    integer :: position_ball(2) = [400, 225]
    integer :: hit_counter = 0
    integer :: miss_counter = 0
    character(len=100) :: hit_str
    character(len=100) :: miss_str

    call init_window(SCREEN_WIDTH, SCREEN_HEIGHT, 'Fong (Fortran + Pong)' // c_null_char)
    call set_target_fps(60)

    do while (.not. window_should_close())
        print *, get_frame_time()
        call move_player(position_player)
        call move_ball(position_ball, miss_counter)
        call detect_collision(position_ball, position_player, hit_counter)
        call begin_drawing()
            call clear_background(RAYWHITE)
            call draw_text('FORTRAN GAME NOWAY' // c_null_char, 190, 200, 20, RED)
            call draw_player(position_player)
            call draw_ball(position_ball)
            call draw_fps(10, 10)
            write(hit_str, '(I0)') hit_counter
            call draw_text('Hit: ' // hit_str // c_null_char, 300, 300, 30, BLUE)
            write(miss_str, '(I0)') miss_counter
            call draw_text('Misses: ' // miss_str // c_null_char, 300, 400, 30, RED)
        call end_drawing()
    end do
    call close_window()
end program main
