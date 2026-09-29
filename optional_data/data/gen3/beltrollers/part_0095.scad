$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 30 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 30;            // roller width
flange_d = 60;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 27.94;            // hub diameter

roller_profile = [[3.97, 0], [30, 0], [30, 4], [20, 4], [20.6, 15], [20, 26], [30, 26], [30, 30], [3.97, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
