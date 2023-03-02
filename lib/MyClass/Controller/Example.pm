package MyClass::Controller::Example;
use utf8;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {
    # my $self = shift;
    my @banner= $self->_get_banner();
    my @post = $self->app->{_dbh}->resultset('Post')->search({});
    @post = map { { 
       id_post => $_->id_post,
       title_post => $_->title_post,
       summary=> $_->summary,
       image=> $_->image,
       content=> $_->content
    } } @post;

  # Render template "example/welcome.html.ep" with message
    $self->render(msg => 'Chào mừng mọi người', banner=>\@banner, post=>\@post);
}

sub sukien_detail($self){
    my @banner= $self->_get_banner();
    my $id_post = $self->param('id_post');
    my $post = $self->app->{_dbh}->resultset('Post')->find($id_post);   
    if ($post) {
        $self->render(template => 'layouts/frontend/sukien_detail', banner=>\@banner, post => $post);
    } else {
        $self->render(template => 'layouts/frontend/sukien_detail');
    }
}

sub gioithieu($self){

    $self->render(template => 'layouts/frontend/gioithieu');
}

sub tuyensinh($self){

    $self->render(template => 'layouts/frontend/tuyensinh');
    
}

# @private
sub _get_banner($self) {
    my @banner = $self->app->{_dbh}->resultset('Banner')->search({});
    @banner = map { { 
       id_banner => $_->id_banner,
       banner_name => $_->banner_name,
       image=> $_->image
    } } @banner;

    return @banner;
}

1;