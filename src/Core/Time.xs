#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


#include <SDL.h>

PerlInterpreter * perl_for_cb=NULL;

Uint32 add_timer_cb (Uint32 interval, void* param )
{

        PERL_SET_CONTEXT(perl_for_cb);

	dSP;

	int count;
	Uint32 ret_interval;

	ENTER;
	SAVETMPS;

	PUSHMARK(SP);
 
	XPUSHs(sv_2mortal(newSViv(interval)));
 
	PUTBACK;

 	count = call_pv(param,G_SCALAR);

        SPAGAIN;

	if (count != 1 ) croak("callback returned more than 1 value\n");	

        ret_interval = POPi;

        PUTBACK;
	FREETMPS;
	LEAVE;
	
	return ret_interval;

}



MODULE = SDL::Time 	PACKAGE = SDL::Time    PREFIX = time_

SDL_TimerID
time_add_timer ( interval, cmd )
	Uint32 interval
	char *cmd
	CODE:
 	 if (perl_for_cb == NULL) {
	   perl_for_cb = perl_clone(my_perl, CLONEf_KEEP_PTR_TABLE);
           PERL_SET_CONTEXT(my_perl);
         }
	 RETVAL = SDL_AddTimer(interval,add_timer_cb,(void *)cmd);
	OUTPUT:
		RETVAL


int
time_remove_timer ( id)
	int id
	CODE:
		RETVAL = SDL_RemoveTimer((SDL_TimerID) id);
	
	OUTPUT:
		RETVAL

