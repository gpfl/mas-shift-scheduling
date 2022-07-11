//Stop mas when all initiators are done
+done(X)[source(X)] : true <-	
	.print("Weekday/Shift organization ended sucessfully.").


//Failure event since initiator uses broadcasting
@r2 +!cfp(RequestedWeekday, RequestedShift): true.
