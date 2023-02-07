package MyClass::Controller::Backend_sv;
use utf8;
use open ':encoding(utf8)';
binmode(STDOUT, ":utf8");
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Data::Dumper;
use Mojo::Log;
my $log = Mojo::Log->new(path => '/log/app.log', level => 'warn');
#thoikhoabieu

sub tkb_ngay($self){
    $self->render(template => 'layouts/backend_sv/thoikhoabieu_ngay');
}

sub tkb_tuan($self){
   my @schedule_st = $self->app->{_dbh}->resultset('ScheduleSt')->search({});
    #my @sinhvien = $self->app->{_dbh}->resultset('Student')->search({});

    #my $db_object = $self->app->{_dbh};
    
    #my $sinhvien = $db_object->resultset('Student')->search({});

    @schedule_st  = map { { 
       name_subject => $_->name_subject,
       teacher => $_->teacher,
        room=> $_->room,
        date => $_->date,
        lession => $_->lession,
    } } @schedule_st ;

    $self->render(template => 'layouts/backend_sv/thoikhoabieu_tuan',schedule_st =>\@schedule_st);
}

#danhbadienthoai
sub danhba_sv($self){
   # my $self = shift;

    my @student = $self->app->{_dbh}->resultset('Student')->search({});
    #my @sinhvien = $self->app->{_dbh}->resultset('Student')->search({});

    #my $db_object = $self->app->{_dbh};
    
    #my $sinhvien = $db_object->resultset('Student')->search({});
    # for my $sv (@sinhvien) {
    #     use Data::Dumper;
    #     print(Dumper($sv));
    # }
    @student = map { { 
       id_student => $_->id_student,
       full_name => $_->full_name,
        #birthday => $_->birthday,
        email => $_->email,
        phone => $_->phone,
    } } @student;

    $self->render(template => 'layouts/backend_sv/danhbadienthoai_sv', student=>\@student);
}

sub danhba_gv($self){
    my @teacher = $self->app->{_dbh}->resultset('Teacher')->search({});
    @teacher = map { { 
       id_teacher => $_->id_teacher,
       full_name => $_->full_name,
        #birthday => $_->birthday,
        email => $_->email,
        phone => $_->phone,
    } } @teacher;

    $self->render(template => 'layouts/backend_sv/danhbadienthoai_gv', teacher=>\@teacher);
}

#lylichsinhvien
sub lylich_sv($self){
    my $id_student = $self->param('id_student');
    my $dbh = $self->app->{_dbh};
    my $student = $dbh->resultset('Student')->search({"id_student" => 1})->first;
    if ($student) {
        my $student_info = +{
            full_name => $student->full_name,
            birthday => $student->birthday,
            address => $student->address,
            email => $student->email,
            phone => $student->phone,
        };
        $self->render(template => 'layouts/backend_sv/lylich_sv', student=>$student_info);
    }    
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