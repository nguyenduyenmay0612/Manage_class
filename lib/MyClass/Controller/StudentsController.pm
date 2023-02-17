package MyClass::Controller::Students;
use utf8;
use open ':encoding(utf8)';
binmode(STDOUT, ":utf8");
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Data::Dumper;

# Model Students
has _MStudent => sub ($self){
  return MyClass::Model::MStudents->new(
    { schema => $self->schema });
};

# Day la chuc nang hien thi && timf kiem danh sach sinh vien
# @prams $self
sub search {
    my ($self) = @_;


}

1;