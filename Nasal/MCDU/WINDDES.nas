# A3XX mCDU by Joshua Davidson (Octal450), Jonathan Redpath, and Matthew Maring (mattmaring)

# Copyright (c) 2020 Matthew Maring (mattmaring)

var windDESPage = {
	title: nil,
	titleColour: "wht",
	fontMatrix: [[0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0]],
	arrowsMatrix: [[0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0]],
	arrowsColour: [["ack", "ack", "ack", "ack", "ack", "ack"],["ack", "ack", "ack", "ack", "ack", "ack"]],
	L1: [nil, nil, "ack"], # content, title, colour
	L2: [nil, nil, "ack"],
	L3: [nil, nil, "ack"],
	L4: [nil, nil, "ack"],
	L5: [nil, nil, "ack"],
	L6: [nil, nil, "ack"],
	C1: [nil, nil, "ack"],
	C2: [nil, nil, "ack"],
	C3: [nil, nil, "ack"],
	C4: [nil, nil, "ack"],
	C5: [nil, nil, "ack"],
	C6: [nil, nil, "ack"],
	R1: [nil, nil, "ack"],
	R2: [nil, nil, "ack"],
	R3: [nil, nil, "ack"],
	R4: [nil, nil, "ack"],
	R5: [nil, nil, "ack"],
	R6: [nil, nil, "ack"],
	scroll: 0,
	vector: [],
	index: nil,
	computer: nil,
	items: 0,
	new: func(computer) {
		var wdp = {parents:[windDESPage]};
		wdp.computer = computer;
		wdp._setupPageWithData();
		wdp.updateTmpy();
		return wdp;
	},
	del: func() {
		return nil;
	},
	_setupPageWithData: func() {
		me.title = "DES WIND";
		#me.title = ["DES WIND", " AT ", me.waypoint.wp_name];
		me.titleColour = "wht";
		me.arrowsMatrix = [[0, 0, 0, 0, 0, 1], [0, 0, 0, 1, 0, 0]];
		me.arrowsColour = [["ack", "ack", "ack", "ack", "ack", "wht"], ["ack", "ack", "ack", "wht", "ack", "ack"]];
		me.fontMatrix = [[1, 1, 1, 1, 1, 0], [1, 0, 0, 0, 0, 0]];
		
		var computer_temp = 2;
		if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
			computer_temp = me.computer;
		}
		
		# debug.dump(fmgc.windController.des_winds[0]);
# 		debug.dump(fmgc.windController.des_winds[1]);
# 		debug.dump(fmgc.windController.des_winds[2]);
		
		if (fmgc.windController.des_winds[computer_temp] == 0 or fmgc.windController.des_winds[computer_temp].wind1.altitude == "") {
			me.items = 1;
		} else if (fmgc.windController.des_winds[computer_temp].wind2.altitude == "") {
			me.items = 2;
		} else if (fmgc.windController.des_winds[computer_temp].wind3.altitude == "") {
			me.items = 3;
		} else if (fmgc.windController.des_winds[computer_temp].wind4.altitude == "") {
			me.items = 4;
		} else {
			me.items = 5;
		}
		
		if (me.items >= 5) {
			var windStore = fmgc.windController.des_winds[computer_temp].wind5;
			if (windStore.altitude != "") {
				me.L5 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude) ~ "/" ~ windStore.altitude, nil, "blu"];
				me.fontMatrix[0][4] = 1;
			} else {
				me.L5 = ["[  ]/[  ]/[   ]", nil, "blu"];
				me.fontMatrix[0][4] = 1;
			}
		} else {
			me.L5 = [nil, nil, "ack"];
		}
		
		if (me.items >= 4) {
			var windStore = fmgc.windController.des_winds[computer_temp].wind4;
			if (windStore.altitude != "") {
				me.L4 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude) ~ "/" ~ windStore.altitude, nil, "blu"];
				me.fontMatrix[0][3] = 1;
			} else {
				me.L4 = ["[  ]/[  ]/[   ]", nil, "blu"];
				me.fontMatrix[0][3] = 1;
			}
		} else {
			me.L4 = [nil, nil, "ack"];
		}
		
		if (me.items >= 3) {
			var windStore = fmgc.windController.des_winds[computer_temp].wind3;
			if (windStore.altitude != "") {
				me.L3 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude) ~ "/" ~ windStore.altitude, nil, "blu"];
				me.fontMatrix[0][2] = 1;
			} else {
				me.L3 = ["[  ]/[  ]/[   ]", nil, "blu"];
				me.fontMatrix[0][2] = 1;
			}
		} else {
			me.L3 = [nil, nil, "ack"];
		}
		
		if (me.items >= 2) {
			var windStore = fmgc.windController.des_winds[computer_temp].wind2;
			if (windStore.altitude != "") {
				me.L2 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude) ~ "/" ~ windStore.altitude, nil, "blu"];
				me.fontMatrix[0][1] = 1;
			} else {
				me.L2 = ["[  ]/[  ]/[   ]", nil, "blu"];
				me.fontMatrix[0][1] = 1;
			}
		} else {
			me.L2 = [nil, nil, "ack"];
		}
		
		if (me.items >= 1) {
			var windStore = fmgc.windController.des_winds[computer_temp].wind1;
			if (windStore.altitude != "") {
				me.L1 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude) ~ "/" ~ windStore.altitude, "TRU WIND/ALT", "blu"];
				me.fontMatrix[0][0] = 1;
			} else {
				me.L1 = ["[  ]/[  ]/[   ]", "TRU WIND/ALT", "blu"];
				me.fontMatrix[0][0] = 1;
			}
		}
		
		me.L6 = [" RETURN", nil, "wht"];
		
		if (getprop("/FMGC/internal/alt-set")) {
			var windStore = fmgc.windController.des_winds[computer_temp].alt1;
			if (windStore.heading != 0 and windStore.magnitude != 0) {
				me.R1 = [sprintf("%03.0f", windStore.heading) ~ "°/" ~ sprintf("%03.0f", windStore.magnitude), "ALTN WIND ", "blu"];
				me.fontMatrix[1][0] = 1;
			} else {
				me.R1 = ["[  ]/[  ]", "ALTN WIND ", "blu"];
				me.fontMatrix[1][0] = 1;
			}
		} else {
			me.R1 = ["", "", "blu"];
		}
		
		me.R3 = [" REQUEST ", "WIND ", "amb"];
		me.R4 = [" PHASE ", "PREV ", "wht"];
		
		canvas_mcdu.pageSwitch[me.computer].setBoolValue(0);
	},
	makeTmpy: func() {
		if (!fmgc.flightPlanController.temporaryFlag[me.computer]) {
			fmgc.flightPlanController.createTemporaryFlightPlan(me.computer);
		}
	},
	updateTmpy: func() {
		if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
			me.L1[2] = "yel";
			me.L2[2] = "yel";
			me.L3[2] = "yel";
			me.L4[2] = "yel";
			me.L5[2] = "yel";
			me.R1[2] = "yel";
			me.L6 = [" CANCEL", " WIND", "amb"];
			me.R6 = ["UPDATE ", "WIND ", "amb"];
			me.arrowsMatrix[0][5] = 0;
			me.title = "DRAFT DES WIND";
			me.titleColour = "yel";
			canvas_mcdu.pageSwitch[me.computer].setBoolValue(0);
		} else {
			me.L1[2] = "blu";
			me.L2[2] = "blu";
			me.L3[2] = "blu";
			me.L4[2] = "blu";
			me.L5[2] = "blu";
			me.R1[2] = "blu";
			me.L6 = [" RETURN", nil, "wht"];
			me.R6 = [nil, nil, "ack"];
			me.arrowsMatrix[0][5] = 1;
			me.title = "DES WIND";
			me.titleColour = "wht";
			canvas_mcdu.pageSwitch[me.computer].setBoolValue(0);
		}
	},
	reload: func() {
		me._setupPageWithData();
		me.updateTmpy();
	},
	pushButtonLeft: func(index) {
		if (index == 6 and fmgc.flightPlanController.temporaryFlag[me.computer]) {
			if (canvas_mcdu.myFpln[me.computer] != nil) {
				canvas_mcdu.myFpln[me.computer].pushButtonLeft(index);
			} else {
				fmgc.flightPlanController.destroyTemporaryFlightPlan(me.computer, 0);
				# push update to fuel
				if (getprop("/FMGC/internal/block-confirmed")) {
					setprop("/FMGC/internal/fuel-calculating", 0);
					setprop("/FMGC/internal/fuel-calculating", 1);
				}
			}
			me.reload();
		} else if (index == 6) {
			setprop("/MCDU[" ~ me.computer ~ "]/page", fmgc.windController.accessPage[me.computer]);
		} else if (me.items >= index) {
			if (size(mcdu_scratchpad.scratchpads[me.computer].scratchpad) >= 5 and size(mcdu_scratchpad.scratchpads[me.computer].scratchpad) <= 13) {
				var winds = split("/", mcdu_scratchpad.scratchpads[me.computer].scratchpad);
				if (size(winds[0]) >= 0 and size(winds[0]) <= 3 and num(winds[0]) != nil and winds[0] >= 0 and winds[0] <= 360 and
				size(winds[1]) >= 0 and size(winds[1]) <= 3 and num(winds[1]) != nil and winds[1] >= 0 and winds[1] <= 200 and
				size(winds[2]) >= 4 and size(winds[2]) <= 5 and (winds[2] == "GRND" or (num(winds[2]) != nil and winds[2] >= 1000 and winds[2] <= 39000) or
				(num(split("FL", winds[2])[1]) != nil and split("FL", winds[2])[1] >= 10 and split("FL", winds[2])[1] <= 390))) {
					me.makeTmpy();
					var computer_temp = 2;
					if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
						computer_temp = me.computer;
					}
					# if (winds[2] == "GRND") {
# 						setprop("/FMGC/internal/dest-mag-grnd", winds[0]);
# 						setprop("/FMGC/internal/dest-wind-grnd", winds[1]);
# 					}
					#print(computer_temp);
					if (index == 5) {
						fmgc.windController.des_winds[computer_temp].wind5.heading = winds[0];
						fmgc.windController.des_winds[computer_temp].wind5.magnitude = winds[1];
						fmgc.windController.des_winds[computer_temp].wind5.altitude = winds[2];
					} else if (index == 4) {
						fmgc.windController.des_winds[computer_temp].wind4.heading = winds[0];
						fmgc.windController.des_winds[computer_temp].wind4.magnitude = winds[1];
						fmgc.windController.des_winds[computer_temp].wind4.altitude = winds[2];
					} else if (index == 3) {
						fmgc.windController.des_winds[computer_temp].wind3.heading = winds[0];
						fmgc.windController.des_winds[computer_temp].wind3.magnitude = winds[1];
						fmgc.windController.des_winds[computer_temp].wind3.altitude = winds[2];
					} else if (index == 2) {
						fmgc.windController.des_winds[computer_temp].wind2.heading = winds[0];
						fmgc.windController.des_winds[computer_temp].wind2.magnitude = winds[1];
						fmgc.windController.des_winds[computer_temp].wind2.altitude = winds[2];
					} else if (index == 1) {
						fmgc.windController.des_winds[computer_temp].wind1.heading = winds[0];
						fmgc.windController.des_winds[computer_temp].wind1.magnitude = winds[1];
						fmgc.windController.des_winds[computer_temp].wind1.altitude = winds[2];
					}
					mcdu_scratchpad.scratchpads[me.computer].empty();
					if (me.items == index and index != 5) {
						me.items += 1;
					}
					me._setupPageWithData();
					me.updateTmpy();
				} else {
					mcdu_message(me.computer, "NOT ALLOWED");
				}
			} else if (mcdu_scratchpad.scratchpads[me.computer].scratchpad == "CLR") {
				var computer_temp = 2;
				if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
					computer_temp = me.computer;
				}
				if (me.items == index) {
					if (index == 5) {
						fmgc.windController.des_winds[computer_temp].wind5.heading = 0;
						fmgc.windController.des_winds[computer_temp].wind5.magnitude = 0;
						fmgc.windController.des_winds[computer_temp].wind5.altitude = "";
					} else if (index == 4) {
						fmgc.windController.des_winds[computer_temp].wind4.heading = 0;
						fmgc.windController.des_winds[computer_temp].wind4.magnitude = 0;
						fmgc.windController.des_winds[computer_temp].wind4.altitude = "";
					} else if (index == 3) {
						fmgc.windController.des_winds[computer_temp].wind3.heading = 0;
						fmgc.windController.des_winds[computer_temp].wind3.magnitude = 0;
						fmgc.windController.des_winds[computer_temp].wind3.altitude = "";
					} else if (index == 2) {
						fmgc.windController.des_winds[computer_temp].wind2.heading = 0;
						fmgc.windController.des_winds[computer_temp].wind2.magnitude = 0;
						fmgc.windController.des_winds[computer_temp].wind2.altitude = "";
					} else if (index == 1) {
						fmgc.windController.des_winds[computer_temp].wind1.heading = 0;
						fmgc.windController.des_winds[computer_temp].wind1.magnitude = 0;
						fmgc.windController.des_winds[computer_temp].wind1.altitude = "";
					}
				} else {
					if (index <= 1) {
						fmgc.windController.des_winds[computer_temp].wind1.heading = fmgc.windController.des_winds[computer_temp].wind2.heading;
						fmgc.windController.des_winds[computer_temp].wind1.magnitude = fmgc.windController.des_winds[computer_temp].wind2.magnitude;
						fmgc.windController.des_winds[computer_temp].wind1.altitude = fmgc.windController.des_winds[computer_temp].wind2.altitude;
					}
					if (index <= 2) {
						fmgc.windController.des_winds[computer_temp].wind2.heading = fmgc.windController.des_winds[computer_temp].wind3.heading;
						fmgc.windController.des_winds[computer_temp].wind2.magnitude = fmgc.windController.des_winds[computer_temp].wind3.magnitude;
						fmgc.windController.des_winds[computer_temp].wind2.altitude = fmgc.windController.des_winds[computer_temp].wind3.altitude;
					}
					if (index <= 3) {
						fmgc.windController.des_winds[computer_temp].wind3.heading = fmgc.windController.des_winds[computer_temp].wind4.heading;
						fmgc.windController.des_winds[computer_temp].wind3.magnitude = fmgc.windController.des_winds[computer_temp].wind4.magnitude;
						fmgc.windController.des_winds[computer_temp].wind3.altitude = fmgc.windController.des_winds[computer_temp].wind4.altitude;
					}
					if (index <= 4) {
						fmgc.windController.des_winds[computer_temp].wind4.heading = fmgc.windController.des_winds[computer_temp].wind5.heading;
						fmgc.windController.des_winds[computer_temp].wind4.magnitude = fmgc.windController.des_winds[computer_temp].wind5.magnitude;
						fmgc.windController.des_winds[computer_temp].wind4.altitude = fmgc.windController.des_winds[computer_temp].wind5.altitude;
					}	
				}
				mcdu_scratchpad.scratchpads[me.computer].empty();
				me.items -= 1;
				me._setupPageWithData();
				me.updateTmpy();
			} else {
				mcdu_message(me.computer, "NOT ALLOWED");
			}
		} else {
			mcdu_message(me.computer, "NOT ALLOWED");
		}
	},
	pushButtonRight: func(index) {
		if (index == 1 and getprop("/FMGC/internal/alt-set")) {
			if (size(mcdu_scratchpad.scratchpads[me.computer].scratchpad) >= 3 and size(mcdu_scratchpad.scratchpads[me.computer].scratchpad) <= 7) {
				var winds = split("/", mcdu_scratchpad.scratchpads[me.computer].scratchpad);
				if (size(winds[0]) >= 1 and size(winds[0]) <= 3 and num(winds[0]) != nil and winds[0] >= 0 and winds[0] <= 360 and
				size(winds[1]) >= 1 and size(winds[1]) <= 3 and num(winds[1]) != nil and winds[1] >= 0 and winds[1] <= 200) {
					me.makeTmpy();
					var computer_temp = 2;
					if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
						computer_temp = me.computer;
					}
					#print(computer_temp);
					fmgc.windController.des_winds[computer_temp].alt1.heading = winds[0];
					fmgc.windController.des_winds[computer_temp].alt1.magnitude = winds[1];
					mcdu_scratchpad.scratchpads[me.computer].empty();
					me._setupPageWithData();
					me.updateTmpy();
				} else {
					mcdu_message(me.computer, "NOT ALLOWED");
				}
			} else if (mcdu_scratchpad.scratchpads[me.computer].scratchpad == "CLR") {
				var computer_temp = 2;
				if (fmgc.flightPlanController.temporaryFlag[me.computer]) {
					computer_temp = me.computer;
				}
				fmgc.windController.des_winds[computer_temp].alt1.heading = 0;
				fmgc.windController.des_winds[computer_temp].alt1.magnitude = 0;
				mcdu_scratchpad.scratchpads[me.computer].empty();
				me._setupPageWithData();
				me.updateTmpy();
			} else {
				mcdu_message(me.computer, "NOT ALLOWED");
			}
		} else if (index == 6 and fmgc.flightPlanController.temporaryFlag[me.computer]) {
			if (canvas_mcdu.myFpln[me.computer] != nil) {
				canvas_mcdu.myFpln[me.computer].pushButtonRight(index);
			} else {
				fmgc.flightPlanController.destroyTemporaryFlightPlan(me.computer, 1);
				# push update to fuel
				if (getprop("/FMGC/internal/block-confirmed")) {
					setprop("/FMGC/internal/fuel-calculating", 0);
					setprop("/FMGC/internal/fuel-calculating", 1);
				}
			}
			me.reload();
		} else {
			mcdu_message(me.computer, "NOT ALLOWED");
		}
	}
};