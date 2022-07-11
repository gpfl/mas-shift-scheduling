//Submit proposal plan, sends to the initiator my product offers
@sp +!cfp(Weekday, Shift)[source(X)] : true <-
	?weekdays(List);
	?role(Role);
	if (.sublist([[Weekday,_]],List)){
		for (.member(Item,List)) {
			.nth(0,Item,XDay);
			.nth(1,Item,XShift);
			if (Weekday == XDay & Shift == XShift) {
				.random(Y);
				.send(X,tell,propose(Role,Weekday,Shift));
			}
		}
	} else {
		.send(X,tell,refuse(Role,Weekday,Shift));
	}.		

+acceptProposal(Role,Weekday,Shift)[source(X)] : true <-
	.send(X,tell,informDone(Weekday,Shift)).

+rejectProposal(Role,Weekday,Shift)[source(X)] : true.
