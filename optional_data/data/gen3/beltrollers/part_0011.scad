$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 34 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 34;            // roller width
flange_d = 76;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 31.94;            // hub diameter

roller_profile = [[3.97, 0], [38, 0], [38, 6], [28, 6], [28.6, 17], [28, 28], [38, 28], [38, 34], [3.97, 34]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
