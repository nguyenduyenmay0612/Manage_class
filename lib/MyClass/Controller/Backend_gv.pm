package MyClass::Controller::Backend_gv;
use utf8;
use open ':encoding(utf8)';
binmode(STDOUT, ":utf8");
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Data::Dumper;
#ly lich giang vien
sub lylich_gv($self){
    my $id_teacher = $self->param('id_teacher');
    my $dbh = $self->app->{_dbh};
    my $teacher = $dbh->resultset('Teacher')->search({"id_teacher" => 1})->first;
    if ($teacher) {
        my $teacher_info = +{
            full_name => $teacher->full_name,
            birthday => $teacher->birthday,
            #address => $teacher->address,
            email => $teacher->email,
            phone => $teacher->phone,
        };
        $self->render(template => 'layouts/backend_gv/lylich_gv', teacher=>$teacher_info);
    }    
}

#lich giang day theo tuan của giang vien
sub lichday($self){
   my @schedule_tch = $self->app->{_dbh}->resultset('ScheduleTch')->search({});
    @schedule_tch  = map { { 
        name_subject => $_->name_subject,
        lession => $_->lession,
        room=> $_->room,
        date => $_->date,
    } } @schedule_tch ;

    $self->render(template => 'layouts/backend_gv/lichday',schedule_tch =>\@schedule_tch);
}

#hien thi danh ba dien thoai sinh vien lop
sub danhba_sv($self){
    my @student = $self->app->{_dbh}->resultset('Student')->search({});
    @student = map { { 
       id_student => $_->id_student,
       full_name => $_->full_name,
        email => $_->email,
        phone => $_->phone,
    } } @student;

    $self->render(template => 'layouts/backend_gv/danhbadienthoai_sv', student=>\@student);
}

#hien thi danh ba dien thoai giang vien lop
sub danhba_gv($self){
    my @teacher = $self->app->{_dbh}->resultset('Teacher')->search({});
    @teacher = map { { 
       id_teacher => $_->id_teacher,
       full_name => $_->full_name,
        email => $_->email,
        phone => $_->phone,
    } } @teacher;

    $self->render(template => 'layouts/backend_gv/danhbadienthoai_gv', teacher=>\@teacher);
}

#hien thi danh sach thong tin sinh vien
sub danhsach_sv($self){
    my @student = $self->app->{_dbh}->resultset('Student')->search({});
    @student = map { { 
       id_student => $_->id_student,
       full_name => $_->full_name,
        birthday => $_->birthday,
        address => $_->address,
        email => $_->email,
        phone => $_->phone,
    } } @student;

    $self->render(template => 'layouts/backend_gv/danhsach_sv', student=>\@student);
}

#them sinh vien moi
sub them_view {
    my $self = shift;  
    $self -> render(template => 'layouts/backend_gv/them_sv', 
            error    => $self->flash('error'),
            message  => $self->flash('message')
    );
}

sub them_sv {
    my $self = shift;
    my $id_student = $self->param('id_student');
    my $full_name = $self->param('full_name');
    my $birthday = $self->param('birthday');
    my $email = $self->param('email');
    my $address = $self->param('address');
    my $phone= $self->param('phone');

    if (! $full_name || ! $birthday || ! $email || ! $address ) {
        $self->flash(error => 'Tên sinh viên, ngày sinh, email và địa chỉ là các trường không thể thiếu');
        $self->redirect_to('them_sv');
    }

    my $dbh = $self->app->{_dbh};
    my $student = $dbh->resultset('Student')->search({ email => $email, id_student => $id_student })->first;

    if (!$student) {
        eval {
            $dbh->resultset('Student')->create({
                id_student => $id_student,
                full_name => $full_name,
                birthday => $birthday,
                address => $address,
                phone => $phone,               
                email => $email
            });
        };
        $self->flash( message => 'Thêm sinh viên thành công');
        $self->redirect_to('them_sv');
    }       
}

#sua thong tin sinh vien
sub sua_view {
    my $self = shift;
    my $id_student = $self->param('id');
    my $dbh = $self->app->{_dbh};
    my $student = $dbh->resultset('Student')->find($id_student);
    
    if ($student) {
        $self->render(template => 'layouts/backend_gv/sua_sv', student => $student ,student => $student, message => '', error=>'');
    } else {
        $self->render(template => 'layouts/backend_gv/danhsach_sv');
    }

}
sub sua_sv{
    my $self = shift;
    my $id_student = $self->param('id');
    my $full_name = $self->param('full_name');
    my $birthday = $self->param('birthday');
    my $email = $self->param('email');
    my $address = $self->param('address');
    my $phone= $self->param('phone');
    my $dbh = $self->app->{_dbh}; 
    my $result= $dbh->resultset('Student')->find($id_student)->update({  
        full_name => $full_name,
        birthday => $birthday,
        address => $address,
        email => $email,
        phone => $phone,
        });
    my $student = $dbh->resultset('Student')->find($id_student);

    if ($student) {
        $self->render(template => 'layouts/backend_gv/sua_sv', student => $student, message => 'Cập nhật thông tin thành công', error=>'');
    } else {
        $self->render(template => 'layouts/backend_gv/danhsach_sv');
    }

}

#xoa sinh vien 
sub xoa_sv{
    my $self = shift;
    my $id_student = $self->param('id_student');
    my $dbh = $self->app->{_dbh};
    my $result = $dbh->resultset('Student')->find($id_student)->delete({});
    my @student = $self->app->{_dbh}->resultset('Student')->search({});
    if($result) {
    @student = map { { 
       id_student => $_->id_student,
       full_name => $_->full_name,
        birthday => $_->birthday,
        address => $_->address,
        email => $_->email,
        phone => $_->phone,
    } } @student;
    $self->render(template => 'layouts/backend_gv/danhsach_sv', student =>\@student);
    }else {
    $self->render(template => 'layouts/backend_gv/danhsach_sv', student =>\@student);
    }
}

1;
