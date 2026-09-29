$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 30 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 30;            // roller width
flange_d = 76;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 31.94;            // hub diameter

roller_profile = [[3.97, 0], [38, 0], [38, 6], [28, 6], [28.6, 15], [28, 24], [38, 24], [38, 30], [3.97, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
