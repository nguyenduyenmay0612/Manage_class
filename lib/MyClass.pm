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

  #login
  $r->get('/login_sv')->to('Login#login_sv');
  $r->get('/login_gv')->to('Login#login_gv');
  $r->post('/loginto_sv')->to('Login#loginto_sv');
  $r->post('/loginto_gv')->to('Login#loginto_gv');
  
  #thoikhoabieu
  $r->get('/tkb_ngay')->to('Backend_sv#tkb_ngay');
  $r->get('/tkb_tuan')->to('Backend_sv#tkb_tuan');


  #danhbadienthoai
  $r->get('/danhba_sv')->to('Backend_sv#danhba_sv');
  $r->get('/danhba_gv')->to('Backend_sv#danhba_gv');
  
  #lylichsinhvien
  $r->get('/lylich_sv')->to('Backend_sv#lylich_sv');  
   
  #ketquahoctap
  $r->get('/diemhocphan')->to('Backend_sv#diemhocphan');
  $r->get('/ketqua_xhv')->to('Backend_sv#ketqua_xhv');
  $r->get('/chungchi')->to('Backend_sv#chungchi');  


}

1;
