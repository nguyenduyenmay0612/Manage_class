package MyClass;
use Mojo::Base 'Mojolicious', -signatures;
use MyClass::Model::DB ;

# This method will run once at server start
sub startup ($self) {

    $self->_set_db_operation_handler();
    # $self->_db_handler();  ## Add after this line
    $self->_set_pagination();
    # Database operations handler object
    sub _set_db_operation_handler {
        my $self = shift;
        $self->{ _dbh } = MyClass::Model::DB->new();
        return $self;
    }
    sub _set_pagination {
        my $self = shift;
        $self->{paginate} = 10;
        return $self;
    }
    sub _get_pagination {
        my $self = shift;
        return $self->{paginate};
    }

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    # Configure the application
    $self->secrets($config->{secrets});

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('Example#welcome');
    $r->get('/sukien/:id_post')->to('Example#sukien_detail');
    $r->get('/thongbao/:id_noti')->to('Example#thongbao_detail');
    $r->get('/hoatdong/:id_activity')->to('Example#hoatdong_detail');
    $r->get('/gioithieu')->to('Example#gioithieu');
    $r->get('/tuyensinh')->to('Example#tuyensinh');
    $r->get('/sukien')->to('Example#welcome');

    #login_logout
    $r->get('/login_sv')->to('LoginLogout#login_sv');
    $r->get('/login_gv')->to('LoginLogout#login_gv');
    $r->post('/loginto_sv')->to('LoginLogout#loginto_sv');
    $r->post('/loginto_gv')->to('LoginLogout#loginto_gv');
    $r->get('/logout')->to('LoginLogout#logout');
    
    
    #thoikhoabieu
    $r->get('/schedule_day')->to('StudentController#schedule_day');
    $r->get('/schedule_week')->to('StudentController#schedule_week');


    #phonedienthoai
    $r->get('/phone_student')->to('StudentController#phone_student');
    $r->get('/phone_teacher')->to('StudentController#phone_teacher');
    $r->get('/phone_student1')->to('TeacherController#phone_student');
    $r->get('/phone_teacher1')->to('TeacherController#phone_teacher1');
    
    #lylich
    $r->get('/profile_sv')->to('StudentController#profile_sv'); 
    $r->get('/profile_gv')->to('TeacherController#profile_gv'); 
    
    #ketquahoctap
    $r->get('/diemhocphan')->to('StudentController#diemhocphan');
    $r->get('/ketqua_xhv')->to('StudentController#ketqua_xhv');
    $r->get('/chungchi')->to('StudentController#chungchi');  

    #lichday
    $r->get('/schedule_gv')->to('TeacherController#schedule_gv');

    #quan ly sinh vi??n
    $r->get('/list_sv')->to('TeacherController#list_sv');
    $r->get('/add_sv')->to('TeacherController#add_view');
    $r->post('/add_sv')->to('TeacherController#add_sv');
    $r->get('/edit_sv/:id')->to('TeacherController#edit_view');
    $r->post('/edit_sv/:id')->to('TeacherController#edit_sv');
    $r->get('/delete_sv/:id_student')->to('TeacherController#delete_sv');

    #cap nhat thong tin giang vien
    $r->get('/edit_gv')->to('TeacherController#edit_gv');

    #tim kiem sinh vien
    $r->post('/search_sv')->to('TeacherController#search_sv');

    #quan ly banner
    $r->get('/banner')->to('BannerController#banner');
    $r->get('/edit_banner/:id_banner')->to('BannerController#edit_banner_view');
    $r->post('/edit_banner/:id_banner')->to('BannerController#edit_banner');
    $r->get('/delete_banner/:id_banner')->to('BannerController#delete_banner');
    $r->post('/add_banner')->to('BannerController#add_banner');

    #quan ly TKB sinh vien
    $r->get('/edit_schedule')->to('ScheduleController#edit_schedule_view');
    $r->post('/edit_schedule')->to('ScheduleController#edit_schedule');

    #quan ly bai viet tren trang ch??? 
    $r->get('/post')->to('PostController#post');
    $r->get('/edit_post/:id_post')->to('PostController#edit_post_view');
    $r->post('/edit_post/:id_post')->to('PostController#edit_post');
    $r->get('/delete_post/:id_post')->to('PostController#delete_post');
    $r->get('/add_post')->to('PostController#add_post_view');
    $r->post('/add_post')->to('PostController#add_post');

    #quan ly hoat dong
    $r->get('/activity')->to('ActivityController#activity');
    $r->get('/edit_activity/:id_activity')->to('ActivityController#edit_activity_view');
    $r->post('/edit_activity/:id_activity')->to('ActivityController#edit_activity');
    $r->get('/delete_activity/:id_activity')->to('ActivityController#delete_activity');
    $r->get('/add_activity')->to('ActivityController#add_activity_view');
    $r->post('/add_activity')->to('ActivityController#add_activity');

    #quan ly thong bao
    $r->get('/noti')->to('NotiController#noti');
    $r->get('/edit_noti/:id_noti')->to('NotiController#edit_noti_view');
    $r->post('/edit_noti/:id_noti')->to('NotiController#edit_noti');
    $r->get('/delete_noti/:id_noti')->to('NotiController#delete_noti');
    $r->get('/add_noti')->to('NotiController#add_noti_view');
    $r->post('/add_noti')->to('NotiController#add_noti');

    #quan ly hinh anh 
    $r->get('/image')->to('ImageController#image');
    $r->get('/edit_image/:id_image')->to('ImageController#edit_image_view');
    $r->post('/edit_image/:id_image')->to('ImageController#edit_image');
    $r->get('/delete_image/:id_image')->to('ImageController#delete_image');
    $r->post('/add_image')->to('ImageController#add_image');

    }

    # Pagination 
    sub _db_handler {
    my $self = shift;

    $self->{dbh} = mojoForum::Model::DB->new();

    return $self;
    }

    sub _set_pagination {
        my $self = shift;
        $self->{paginate} = 10;
        return $self;
    }

    sub _get_pagination {
        my $self = shift;

        return $self->{paginate};
    }

    
1;
