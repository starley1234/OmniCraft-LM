$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 40 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 64;            // barrel diameter
roller_w = 40;            // roller width
flange_d = 80;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 31.88;            // hub diameter

roller_profile = [[7.94, 0], [40, 0], [40, 5], [32, 5], [33, 20], [32, 35], [40, 35], [40, 40], [7.94, 40]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
