$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 38 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 38;            // roller width
flange_d = 76;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 23.94;            // hub diameter

roller_profile = [[3.97, 0], [38, 0], [38, 6], [32, 6], [32.6, 19], [32, 32], [38, 32], [38, 38], [3.97, 38]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
