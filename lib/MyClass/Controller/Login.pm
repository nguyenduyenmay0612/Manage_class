package MyClass::Controller::Login;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::JSON qw(encode_json);
use Email::Valid;

sub login_sv($self){

    $self->render(template => 'layouts/frontend/login_sv',
    error=> $self->flash('error') );
    
}
sub login_gv($self){

    $self->render(template => 'layouts/frontend/login_gv', 
    error=> $self->flash('error'));
}


#action form login
sub loginto_sv($self){
    #my $self = shift;
    my $email = $self->param('email');
    my $password = $self->param('password');
    
    my @valid_input = $self->_validate_form($email, $password);

    # check validate
    # if(scalar @valid_input > 0){
    #     my $output =  {
    #         ok => Mojo::JSON->false,
    #         code => '202',
    #         message => [@valid_input]
    #     };
    #     $self->render(
    #         template => 'layouts/login_student',
    #         datas=> $output,
    #         success_alert => 0,
    #         error_alert => 1
    #     );
    # }



    # pass validater
    # kiem tra user có ton tại trong Db
     # Conect DB
    my $db_object = $self->app->{_dbh};
    
    my $student = $db_object->resultset('Student')->search({email=>$email,password=>$password})->first;
    # Nếu có user thì sao 
    if ($student) {
            my @schedule_st = $self->app->{_dbh}->resultset('ScheduleSt')->search({});
            @schedule_st  = map { { 
            name_subject => $_->name_subject,
            teacher => $_->teacher,
                room=> $_->room,
                date => $_->date,
                lession => $_->lession,
            } } @schedule_st ;

            $self->render(template => 'layouts/backend_sv/thoikhoabieu_tuan',schedule_st =>\@schedule_st);

    } else {
        $self->flash(error => 'Email hoặc mật khẩu của bạn không đúng');
        $self->redirect_to('login_sv');
    }     
}

sub loginto_gv($self){
    #my $self = shift;
    my $email = $self->param('email');
    my $password = $self->param('password');
    
    my @valid_input = $self->_validate_form($email, $password);
    # kiem tra user có ton tại trong Db
     # Conect DB
    my $db_object = $self->app->{_dbh};
    
    my $teacher = $db_object->resultset('Teacher')->search({email=>$email,password=>$password})->first;
    # Nếu có user thì sao 
    if ($teacher) {
        my @schedule_tch = $self->app->{_dbh}->resultset('ScheduleTch')->search({});
        @schedule_tch  = map { { 
            name_subject => $_->name_subject,
            lession => $_->lession,
            room=> $_->room,
            date => $_->date,
        } } @schedule_tch ;

        $self->render(template => 'layouts/backend_gv/lichday',schedule_tch =>\@schedule_tch);
    } else {
         $self->flash(error => 'Email hoặc mật khẩu của bạn không đúng');
        $self->redirect_to('login_gv');
    }
    
   
}

# check validator
sub _validate_form($self, $email, $password) {
    #my $self = shift;
    my @errors = ();
    unless( Email::Valid->address($email) ) {
       push(@errors, 'Email khong chinh xac');
    }
    if ($password eq "")
    {
        push(@errors, 'Pasword khong chinh xac');
    }

    return @errors;
}

sub logout {
    my $self = shift;
   $self->redirect_to('/');
    }

1;
