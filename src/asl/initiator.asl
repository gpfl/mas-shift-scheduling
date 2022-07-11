!askForProposals.

//Start broadcasting to participants send their offers
@r1 +!askForProposals : true <- 
	.abolish(propose(_,_));
	.abolish(refuse(_));
	?desiredWeekdays(LOD);
	?expectedShifts(LOS);
	for (.member(Weekday,LOD)) {
		for (.member(Shift,LOS)) {
			.broadcast(achieve,cfp(Weekday,Shift));
			.print("Asked for: '",Weekday,"', '",Shift,"'.");
		}
	}.
	
//An expected proposal was received
@np1 +propose(Role,Day,Shift)[source(Worker)] : desiredWeekdays(LOD) & .sublist([Day],LOD) <-
	.print("Received (",Worker,"): ",Role," ",Day," ",Shift);
	!deliberate(Day,Role,Shift).

@d1[atomic] +!deliberate(Day, Role, Shift) : true <-
	.findall([S,D,W,R], propose(R,D,S)[source(W)] & D == Day & R == Role & S == Shift, ListProposals);
	?expectedRoles(LOR);
	for (.member(Item,LOR)){
		if (.sublist([Role,_],Item)){
			.nth(1, Item, N)
			.length(ListProposals,L);
			-+listSize(0);
			-+listRoles(0);
			while(listSize(Sz) & listRoles(Rl) & Sz < L) {
				.nth(Sz,ListProposals,Proposal);
				.nth(0,Proposal,XShift);
				.nth(1,Proposal,XDay);
				.nth(2,Proposal,XWorker);
				.nth(3,Proposal,XRole);
				if (Rl <= N) {		
					.send(XWorker,tell,acceptProposal(XRole,XDay,XShift));
					.print("acceptProposal (",XWorker,"): ",XRole," ",XDay," ",XShift);
					-+listRoles(Rl+1);
				} else { 
					.send(XWorker,tell,rejectProposal(XRole,XDay,XShift));
					.print("rejectProposal (",XWorker,"): ",XRole," ",XDay," ",XShift);
				}
				-propose(XRole,XDay,XShift)[source(XSupplier)];
				-+listSize(Sz+1);
			}
		}		
	}.
		
//An refuse for proposal was received
@nop3 +refuse(Role,Day,Shift)[source(Worker)] : true <-
	.print("Refuse (",Worker,"): ",Role," ",Day," ",Shift);
	!deliberate(Role,Day,Shift).
	
//A participant informed the service is done
+informDone(Weekday,Shift) : .count(informDone(_,_),X) & desiredWeekdays(LOD) & .length(LOD, L) & X == L*2 <-
	.my_name(Me);
	.send(controller,tell,done(Me)).


//Failure event since initiator uses broadcasting
@r2 +!cfp(RequestedWeekday,RequestedShift): true.
