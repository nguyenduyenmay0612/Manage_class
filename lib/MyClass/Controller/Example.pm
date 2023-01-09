package MyClass::Controller::Example;
use utf8;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Chào mừng mọi người');
}


sub sukien($self){

    $self->render(template => 'layouts/frontend/sukien');
}

sub gioithieu($self){

    $self->render(template => 'layouts/frontend/gioithieu');
}

sub tuyensinh($self){

    $self->render(template => 'layouts/frontend/tuyensinh');
    
}


1;