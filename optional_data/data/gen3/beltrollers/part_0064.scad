$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 30 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 30;            // roller width
flange_d = 52;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 29.52;            // hub diameter

roller_profile = [[4.76, 0], [26, 0], [26, 6], [20, 6], [21.4, 15], [20, 24], [26, 24], [26, 30], [4.76, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
