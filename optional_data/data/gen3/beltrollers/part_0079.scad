$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 38 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 38;            // roller width
flange_d = 60;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 36.7;             // hub diameter

roller_profile = [[6.35, 0], [30, 0], [30, 6], [20, 6], [21.4, 19], [20, 32], [30, 32], [30, 38], [6.35, 38]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
