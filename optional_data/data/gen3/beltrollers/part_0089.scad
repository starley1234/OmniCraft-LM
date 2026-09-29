$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 34 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 34;            // roller width
flange_d = 60;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 32.7;             // hub diameter

roller_profile = [[6.35, 0], [30, 0], [30, 4], [20, 4], [20.6, 17], [20, 30], [30, 30], [30, 34], [6.35, 34]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
