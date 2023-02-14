package MyClass;
use Mojo::Base 'Mojolicious', -signatures;
use MyClass::Model::DB ;

# This method will run once at server start
sub startup ($self) {

  $self->_set_db_operation_handler();
  # Database operations handler object
  sub _set_db_operation_handler {
    my $self = shift;

    $self->{ _dbh } = MyClass::Model::DB->new();

    return $self;
  }

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Example#welcome');
  $r->get('/sukien')->to('Example#sukien');
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
  $r->get('/lylich_sv')->to('BackendSv#lylich_sv'); 
  $r->get('/lylich_gv')->to('BackendGv#lylich_gv'); 
   
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
}
  

1;
