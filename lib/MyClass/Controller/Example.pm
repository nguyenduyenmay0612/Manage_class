package MyClass::Controller::Example;
use utf8;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {
    # my $self = shift;
    my @banner = $self->app->{_dbh}->resultset('Banner')->search({});
    @banner = map { { 
       id_banner => $_->id_banner,
       banner_name => $_->banner_name,
       image=> $_->image
    } } @banner;
  # Render template "example/welcome.html.ep" with message
    $self->render(msg => 'Chào mừng mọi người', banner=>\@banner);
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