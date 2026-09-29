$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 28 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 28;            // roller width
flange_d = 60;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 27.94;            // hub diameter

roller_profile = [[3.97, 0], [30, 0], [30, 5], [20, 5], [21.4, 14], [20, 23], [30, 23], [30, 28], [3.97, 28]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
