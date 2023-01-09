package MyClass::Controller::Backend_sv;
use utf8;
use open ':encoding(utf8)';
binmode(STDOUT, ":utf8");
use Mojo::Base 'Mojolicious::Controller', -signatures;

#thoikhoabieu

sub tkb_ngay($self){
    $self->render(template => 'layouts/backend_sv/thoikhoabieu_ngay');
}

sub tkb_tuan($self){
    $self->render(template => 'layouts/backend_sv/thoikhoabieu_tuan');
}

#danhbadienthoai
sub danhba_sv($self){
   # my $self = shift;

    my @sinhvien = $self->app->{_dbh}->resultset('Student')->search({});
    #my @sinhvien = $self->app->{_dbh}->resultset('Student')->search({});

    #my $db_object = $self->app->{_dbh};
    
    #my $sinhvien = $db_object->resultset('Student')->search({});
    # for my $sv (@sinhvien) {
    #     use Data::Dumper;
    #     print(Dumper($sv));
    # }
    @sinhvien = map { { 
       id_student => $_->id_student,
       full_name => $_->full_name,
        #birthday => $_->birthday,
        email => $_->email,
        phone => $_->phone,
    } } @sinhvien;

    $self->render(template => 'layouts/backend_sv/danhbadienthoai_sv', sinhvien=>\@sinhvien);
}

sub danhba_gv($self){
      my @giaovien = $self->app->{_dbh}->resultset('Teacher')->search({});
    #my @sinhvien = $self->app->{_dbh}->resultset('Student')->search({});

    #my $db_object = $self->app->{_dbh};
    
    #my $sinhvien = $db_object->resultset('Student')->search({});

    @giaovien = map { { 
       id_teacher => $_->id_teacher,
       full_name => $_->full_name,
        #birthday => $_->birthday,
        email => $_->email,
        phone => $_->phone,
    } } @giaovien;

    $self->render(template => 'layouts/backend_sv/danhbadienthoai_gv', giaovien=>\@giaovien);
}

#lylichsinhvien
sub lylich_sv($self){
    $self->render(template => 'layouts/backend_sv/lylich_sv');
}

#ketquahoctap
sub diemhocphan($self){
    $self->render(template => 'layouts/backend_sv/diemhocphan');
}

sub ketqua_xhv($self){
    $self->render(template => 'layouts/backend_sv/ketqua_xhv');
}

sub chungchi($self){
    $self->render(template => 'layouts/backend_sv/chungchi');
}
1;