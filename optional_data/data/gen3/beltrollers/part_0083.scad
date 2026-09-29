$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 40 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 40;            // roller width
flange_d = 76;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 32.7;             // hub diameter

roller_profile = [[6.35, 0], [38, 0], [38, 5], [28, 5], [29.4, 20], [28, 35], [38, 35], [38, 40], [6.35, 40]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
