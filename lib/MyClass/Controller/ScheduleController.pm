package MyClass::Controller::ScheduleController;
use utf8;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub edit_schedule_view($self){
    # my $self = shift;
    my $schedule_st = $self->app->{_dbh}->resultset('ScheduleSt')->search({});  
    my $schedule_st = +{
            name_subject => $schedule_st->name_subject,
            teacher => $schedule_st->teacher,
            date => $schedule_st->date,
            lession => $schedule_st->lession,
            room => $schedule_st->room
        };
    $self->render(template => 'layouts/backend_gv/edit_schedule_student', schedule_st => $schedule_st , message => '', error=>'');

}

sub edit_schedule($self){

}

1;