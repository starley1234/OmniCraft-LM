$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 36 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 36;            // roller width
flange_d = 52;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 27.94;            // hub diameter

roller_profile = [[3.97, 0], [26, 0], [26, 5], [20, 5], [21.4, 18], [20, 31], [26, 31], [26, 36], [3.97, 36]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
