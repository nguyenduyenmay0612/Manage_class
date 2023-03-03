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

    #login_logout
    $r->get('/login_sv')->to('Login#login_sv');
    $r->get('/login_gv')->to('Login#login_gv');
    $r->post('/loginto_sv')->to('Login#loginto_sv');
    $r->post('/loginto_gv')->to('Login#loginto_gv');
    $r->get('/logout')->to('Login#logout');
    
    
    #thoikhoabieu
    $r->get('/schedule_day')->to('BackendSv#schedule_day');
    $r->get('/schedule_week')->to('BackendSv#schedule_week');


    #phonedienthoai
    $r->get('/phone_sv')->to('BackendSv#phone_sv');
    $r->get('/phone_gv')->to('BackendSv#phone_gv');
    $r->get('/phone_sv1')->to('BackendGv#phone_sv');
    $r->get('/phone_gv1')->to('BackendGv#phone_gv');
    
    #lylich
    $r->get('/profile_sv')->to('BackendSv#profile_sv'); 
    $r->get('/profile_gv')->to('BackendGv#profile_gv'); 
    
    #ketquahoctap
    $r->get('/diemhocphan')->to('BackendSv#diemhocphan');
    $r->get('/ketqua_xhv')->to('BackendSv#ketqua_xhv');
    $r->get('/chungchi')->to('BackendSv#chungchi');  

    #lichday
    $r->get('/schedule_gv')->to('BackendGv#schedule_gv');

    #quan ly sinh viên
    $r->get('/list_sv')->to('BackendGv#list_sv');
    $r->get('/add_sv')->to('BackendGv#add_view');
    $r->post('/add_sv')->to('BackendGv#add_sv');
    $r->get('/edit_sv/:id')->to('BackendGv#edit_view');
    $r->post('/edit_sv/:id')->to('BackendGv#edit_sv');
    $r->get('/delete_sv/:id_student')->to('BackendGv#delete_sv');

    #cap nhat thong tin giang vien
    $r->get('/edit_gv')->to('BackendGv#edit_gv');

    #tim kiem sinh vien
    $r->post('/search_sv')->to('BackendGv#search_sv');

    #quan ly banner
    $r->get('/banner')->to('BannerController#banner');
    $r->get('/edit_banner/:id_banner')->to('BannerController#edit_banner_view');
    $r->post('/edit_banner/:id_banner')->to('BannerController#edit_banner');
    $r->get('/delete_banner/:id_banner')->to('BannerController#delete_banner');
    $r->post('/add_banner')->to('BannerController#add_banner');

    #quan ly TKB sinh vien
    $r->get('/edit_schedule')->to('ScheduleController#edit_schedule_view');
    $r->post('/edit_schedule')->to('ScheduleController#edit_schedule');

    #quan ly bai viet tren trang chủ 
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
